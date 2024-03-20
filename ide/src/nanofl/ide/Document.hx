package nanofl.ide;

import stdlib.Uuid;
import stdlib.Timer;
import js.lib.Promise;
import haxe.io.Path;
import stdlib.Debug;
import stdlib.ExceptionTools;
import nanofl.engine.Log.console;
import nanofl.engine.geom.Matrix;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.DocumentProperties;
import nanofl.ide.CodeGenerator;
import nanofl.ide.CodePublisher;
import nanofl.ide.editor.Editor;
import nanofl.ide.editor.EditorLibrary;
import nanofl.ide.filesystem.FileAction;
import nanofl.ide.filesystem.FileActions;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.navigator.Navigator;
import nanofl.ide.plugins.Exporter;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.ide.plugins.IExporterPlugin;
import nanofl.ide.plugins.Importer;
import nanofl.ide.plugins.ImporterPlugins;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.Shell;
import nanofl.ide.sys.WebServerUtils;
import nanofl.ide.ui.View;
import nanofl.ide.ui.Popups;
import nanofl.ide.undo.document.UndoQueue;
import nanofl.ide.textureatlas.TextureAtlasPublisher;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using stdlib.StringTools;

#if profiler @:build(Profiler.buildAll()) #end
@:rtti
class Document extends InjectContainer
{
	@inject var preferences : Preferences;
	@inject var fileSystem : FileSystem;
	@inject var view : View;
    @inject var popups : Popups;
	@inject var folders : Folders;
	@inject var clipboard : Clipboard;
	@inject var shell : Shell;
	@inject var webServerUtils : WebServerUtils;
	@inject var recents : Recents;
	@inject var documentTools : DocumentTools;
	@inject var openedFiles : OpenedFiles;
	
	/**
	 * Document UUID (generated on every document object create).
	 */
	public var id(default, null) : String;

    function isTemporary() return path.startsWith(folders.unsavedDocuments + "/");
	
	/**
	 * Used when document was opened from none-NanoFL format. In other cases is null.
	 */
	public var originalPath(default, null) : String;
    
    /**
	 * Used when document was opened from none-NanoFL format. In other cases is null.
	 */
	public var originalLastModified(default, null) : Date;
	
	/**
	 * Used to detect document modification.
	 */
	var savedProperties : DocumentProperties;

	/**
	 * Path to NanoFL document file (*.nfl).
	 */
	public var path(default, null) : String;
	
	public var properties(default, null) : DocumentProperties;
	public var library(default, null) : EditorLibrary;
	public var lastModified(default, null) : Date;
	
	public var navigator(default, null) : Navigator;
	public var editor(default, null) : Editor;
	public var undoQueue(default, null) : UndoQueue;
	
	public function getTabTextColor() return "";
	public function getTabBackgroundColor() return "";

    public var isModified(get, never) : Bool;    
	
	public function new(path:String, properties:DocumentProperties, library:IdeLibrary, ?lastModified:Date)
	{
		super();
		
        stdlib.Debug.assert(path != null);
        stdlib.Debug.assert(properties != null);
        stdlib.Debug.assert(library != null);

        this.id = Uuid.newUuid();
		
		this.savedProperties = properties.clone();
		
		this.path = path;
		this.properties = properties;
		this.library = new EditorLibrary(library, this);
		this.lastModified = lastModified;
		
		navigator = new Navigator(this);
		editor = new Editor(this);
		undoQueue = new UndoQueue(this);
	}
	
	public function activate(?isCenterView:Bool)
	{
		openedFiles.activate(id);
		editor.loadViewState();
		navigator.update(isCenterView);
		library.update();
	}
	
	public function deactivate()
	{
		editor.saveViewState();
	}
	
	public function setProperties(properties:DocumentProperties)
	{
		this.properties = properties;
		
		editor.rebind();
	}
	
	function get_isModified() : Bool
	{
		if (undoQueue.isDocumentModified())
		{
			log("MODIFIED because undoQueue");
			return true;
		}
		
		if (isTemporary())
		{
			if (originalPath == null)
			{
				if (!properties.equ(savedProperties))
				{
					log("MODIFIED because document properties");
					return  true;
				}

                var tempEmptyLibrary = new IdeLibrary(library.getRawLibrary().libraryDir);
                tempEmptyLibrary.addSceneWithFrame();
				if (!library.getRawLibrary().equ(tempEmptyLibrary))
				{
					log("MODIFIED because library not empty");
					return  true;
				}
			}
			else
			{
				if (lastModified == null || originalLastModified == null)
				{
					log("MODIFIED because lastModified or originalLastModified is null");
					return true;
				}
				if (lastModified.getTime() > originalLastModified.getTime())
				{
					log("MODIFIED because lastModified > originalLastModified");
					return true;
				}
			}
		}
		
		return false;
	}
	
	public function save(?force:Bool) : Promise<Bool>
	{
		return saveAs
		(
			originalPath != null 
				? (detectExporter(originalPath) != null ? originalPath : null)
				: (!isTemporary() ? path : null),
            force
		);
	}
	
	public function saveAs(?newPath:String, ?force:Bool) : Promise<Bool>
	{
		if (newPath == null)
		{
			final exporters = ExporterPlugins.plugins.array();
			exporters.sort((a, b) -> Reflect.compare(a.name, b.name));
			
			final filters = [];
			filters.push({ name:"NanoFL documents (*.nfl)", extensions:["nfl"] });
			for (exporter in exporters) 
			{
				final extensions = exporter.fileFilterExtensions.filter((ext:String) ->
                {
                    return ImporterPlugins.plugins.array().exists
                    (
                        importer -> importer.fileFilterExtensions.contains(ext)
                    );
                });
				if (extensions.length > 0)
				{
					filters.push({ name:exporter.fileFilterDescription, extensions:extensions });
				}
			}
			
            return popups.showSaveFile("Select document file name to save", filters).then(filePath ->
            {
                if (filePath == null) return Promise.resolve(false);
                
                final ext = Path.extension(filePath);
                if ([ "nfl", "xfl" ].contains(ext))
                {
                    final name = Path.withoutDirectory(Path.withoutExtension(filePath));
                    filePath = Path.join([ Path.directory(filePath), name, name + "." + ext ]);
                }
                
                return saveAs(filePath, force);
            });
		}
		else
		{
			recents.add(newPath, view);
			
			if (Path.extension(newPath) == "nfl")
			{
                if (!saveNative(force)) return Promise.resolve(false);

                final success = saveNativeAs(newPath);
                if (success)
                {
                    originalPath = null;
                    originalLastModified = null;
                    openedFiles.titleChanged(this);
                    view.alerter.info("Document \"" + newPath + "\" saved.");
                }
                else
                {
                    view.alerter.error("Could't save document \"" + newPath + "\".");
                }

                return Promise.resolve(success);
			}
			else
			{
				return export(newPath).then((success:Bool) ->
				{
					if (success)
					{
						originalPath = newPath;
						originalLastModified = lastModified;
						openedFiles.titleChanged(this);
						view.alerter.info("Document \"" + newPath + "\" saved.");
					}
					else
					{
						view.alerter.error("Could't save document \"" + newPath + "\".");
					}
					return success;
				});
			}
		}
	}
	
	function saveNativeAs(newPath:String) : Bool
	{
		if (newPath == originalPath || newPath == path)
		{
			return saveNative();
		}
		else
		{
			final oldPath = path;
			
            fileSystem.copyAny(Path.directory(oldPath), Path.directory(newPath));
			library.changeDir(Path.directory(newPath) + "/library");
			
            lastModified = null;
            path = newPath;
			final success = saveNative();
			
            if (success) originalPath = null;
			else         path = oldPath;
			
            return success;
		}
	}
		
	public function export(?destPath:String, ?plugin:IExporterPlugin) : Promise<Bool>
	{
		if (destPath == null)
		{
			var fileFilters = [];
			if (plugin != null)
			{
				fileFilters.push({ name:plugin.fileFilterDescription, extensions:plugin.fileFilterExtensions });
			}
			else
			{
				for (exporterName in ExporterPlugins.plugins.keys().sorted())
				{
					final plugin = ExporterPlugins.plugins.get(exporterName);
					fileFilters.push({ name:plugin.fileFilterDescription, extensions:plugin.fileFilterExtensions });
				}
			}

            return popups.showSaveFile("Select destination file name to export", fileFilters).then(filePath ->
            {
                if (filePath == null) return Promise.resolve(false);

                return export(filePath, plugin).then(success ->
                {
                    if (success) openedFiles.titleChanged(this);
                    return success;
                });
            });
		}
		else
		{
			final exporter = plugin != null
				? new Exporter(plugin.name, plugin.getParams(preferences.storage))
				: detectExporter(destPath);
			
			if (exporter != null)
			{
				if (!saveNative()) return Promise.resolve(false);
                return exporter.run(this, destPath, popups);
			}
			else
			if (Path.extension(destPath) == "nfl")
			{
				return new Document(path, properties, library.getRawLibrary().clone()).saveAs(destPath);
			}
			else
			{
				return Promise.resolve(false);
			}
		}
	}

    public function reload() : Promise<{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }>
    {
        return reloadInner(true, false);
    }
    
    public function reloadWoTransactionForced() : Promise<{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }>
    {
        return reloadInner(false, true);
    }
    
    function reloadInner(addUndoTransaction:Bool, force:Bool) : Promise<{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }>
    {
        return documentTools.loadLibraryAndProperties(path, !force ? lastModified : null).then((e: { library:IdeLibrary, properties:DocumentProperties, lastModified:Date }) ->
        {
            if (e == null) return Promise.resolve({ added:[], removed:[] });
            return syncLibraryItems(e.library, e.lastModified, addUndoTransaction);
        });
    }    

	function syncLibraryItems(newLibrary:IdeLibrary, newLastModified:Date, addUndoTransaction:Bool) : Promise<{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }>
	{
        final itemsToRemove = library.getItems().filter(x -> !newLibrary.hasItem(x.namePath));
        final itemsToAdd = newLibrary.getItemsAsIde().filter(x -> !library.hasItem(x.namePath));
        
        if (addUndoTransaction) undoQueue.beginTransaction({ libraryRemoveItems:itemsToRemove.map(x -> x.namePath), libraryAddItems:true });
        library.removeItems(itemsToRemove.map(x -> x.namePath));
        library.addItems(itemsToAdd, false);
        if (addUndoTransaction) undoQueue.commitTransaction();
        
        return library.preload().then(_ ->
        {
            editor.rebind();
            library.update();
            
            lastModified = newLastModified;
            
            return { added:itemsToAdd, removed:itemsToRemove };
        });
	}

    @:allow(nanofl.ide.DocumentTools.import_)
    function import_(path:String, importer:Importer) : Promise<Bool>
    {
        if (importer == null) importer = detectImporter(preferences, path);
        if (importer == null) return Promise.resolve(null);

        view.waiter.show();

        originalPath = path;

        trace("Import document " + originalPath + " => " + this.path);
        
        return importer.run(originalPath, this.path, properties, library.getRawLibrary()).then(success ->
        {
            if (!success) { view.waiter.hide(); view.alerter.error("Error during importing."); return Promise.resolve(false); }

            view.alerter.info("Document successfully imported.");
            
            library.fixErrors();
            
            return library.preload().then(_ ->
            {
                saveNative(true);
                originalLastModified = lastModified; // must be before activate() to update "modified" in title
                
                activate(true);
                
                view.waiter.hide();
                return true;
            });
        });
    }

    var webServer = { uid:null, address:null };
	public function test() : Promise<Bool>
	{
        if (webServer.uid == null)
        {
            webServer.uid = webServerUtils.start(getPublishDirectory());
            if (webServer.uid == null)
            {
                view.alerter.error("Can't run web server.");
                return Promise.resolve(false);
            }
        }

		return publish().then((success:Bool) ->
		{
			if (success)
			{
				var htmlFilePath = getPublishDirectory() + "/index.html";
				
				if (!fileSystem.exists(htmlFilePath))
				{
					view.alerter.error("File \"" + htmlFilePath + "\" is not found.");
					return Promise.resolve(false);
				}
                
                if (webServer.address == null)
                {
                    webServer.address = webServerUtils.getAddress(webServer.uid);
                    if (webServer.address == null) return Timer.delayAsync(500).then(_ ->
                    {
                        webServer.address = webServerUtils.getAddress(webServer.uid);
                        if (webServer.address == null)
                        {
                            view.alerter.error("Can't get web server address.");
                            return false;
                        }
                        shell.openInExternalBrowser(webServer.address + "/index.html");
                        return true;
                    });
                }

                shell.openInExternalBrowser(webServer.address + "/index.html");
                return Promise.resolve(true);
			}
			
			return Promise.resolve(success);
		});
	}
	
	public function publish() : Promise<Bool>
	{
		view.output.clear();
		
        if (!saveNative()) throw new DocumentError("Can't save file " + getPath() + ".");

        try
        {
			log("prepare output directory");
			final destDir = getPublishDirectory();
			
            log("destDir = " + destDir);
            fileSystem.createDirectory(destDir);
			if (!fileSystem.isDirectory(destDir)) throw new DocumentError("Can't prepare output directory '" + destDir + "'.");
			
            if (properties.publishSettings.useTextureAtlases && properties.publishSettings.textureAtlases.iterator().hasNext())
            {
                log("Publish texture atlases");
                TextureAtlasPublisher.publish(fileSystem, library.getRawLibrary(), properties.publishSettings.textureAtlases, destDir, properties.publishSettings.supportLocalFileOpen);
            }
            else
            {
                TextureAtlasPublisher.deleteFiles(fileSystem, destDir);
            }

    		log("Publish library items to " + Path.directory(path));
			final publishedLibrary = library.publishItems(properties.publishSettings, destDir);

            log("Publish 'library.js'");
            publishedLibrary.publishLibraryJsFile(destDir);

            CodePublisher.publishHtmlAndJsFiles
            (
                destDir,
                properties,
                publishedLibrary.getMeshes().length > 0, // add link to three.js ?
                publishedLibrary.getInstancableItems().exists(x -> x.linkedClass != "") // add link to application.js ?
            );
			
			view.alerter.info("Published successfully.");

            return Promise.resolve(true);
        }
		catch (e:Dynamic)
		{
			log("catch error = " + e);
			
			if (Std.isOfType(e, DocumentError))
			{
				view.alerter.error((cast e:DocumentError).message);
				return Promise.resolve(false);
			}
			else
			{
				ExceptionTools.rethrow(e);
				return Promise.resolve(false);
			}
		}
	}
	
	function getPublishDirectory()
	{
		final r = originalPath != null
			  ? detectImporter(preferences, originalPath).getPublishDirectoryBasePath(originalPath)
			  : Path.directory(path);
		return r + ".release";
	}
	
	public function resize(width:Int, height:Int) : Void
	{
		library.getSceneItem().transform(new Matrix().scale(width / properties.width, height / properties.height));
		
		properties.width  = width; 
		properties.height = height; 
		
		editor.rebind();
	}
	
	public function canBeSaved() : Bool
	{
		return originalPath != null
			? (undoQueue.isDocumentModified() && detectExporter(originalPath) != null)
			: (!isTemporary() && lastModified != null && undoQueue.isDocumentModified());
	}
	
	public function dispose()
	{
        if (webServer.uid != null) webServerUtils.kill(webServer.uid);

		if (isTemporary())
		{
			stdlib.Debug.assert(path.startsWith(folders.temp));
			try fileSystem.deleteAny(Path.directory(path)) catch (_:Dynamic) {}
		}
	}
	
	public function saveNative(force = false) : Bool
	{
		if (!force && lastModified != null && !undoQueue.isDocumentModified()) return true;
		
        undoQueue.commitTransaction();
        
        var e = saveNativeInner
        (
            path,
            properties,
            library.getRawLibrary(),
            FileActions.fromUndoOperations(undoQueue.getOperationsFromLastSaveToNow())
        );
        
        lastModified = e.lastModified;
        undoQueue.documentSaved();
        openedFiles.titleChanged(this);
        trace("Saved " + path);
        if (e.errorMessage != null) view.alerter.error("Generator error: " + e.errorMessage);
        
        return true;
	}
	
	function saveNativeInner(path:String, properties:DocumentProperties, library:IdeLibrary, fileActions:Array<FileAction>) : { lastModified:Date, errorMessage:String }
	{
		Debug.assert(path != null);
		Debug.assert(properties != null);
		Debug.assert(library != null);
		Debug.assert(fileActions != null);
		
		FileActions.process(fileSystem, path, fileActions);
		
		log("Save document properties");
		properties.save(path);
		
		log("Save library");
		library.save(fileSystem);

        CodeGenerator.generate
        (
            Path.withoutDirectory(Path.withoutExtension(path)),
            library,
            Path.directory(path)
        );
		
		return { lastModified:Date.fromTime(Date.now().getTime() + 1), errorMessage:null };
	}
    
	public function getShortTitle() : String
	{
		return (isTemporary() && originalPath == null ? "Untitled" : Path.withoutDirectory(originalPath != null ? originalPath : Path.withoutExtension(path)))
			 + (isModified ? "*" : "");
	}
	
	public function getPath() : String return originalPath != null ? originalPath : path;
	
	public function getLongTitle() : String
	{
		return (isTemporary() && originalPath == null ? "Untitled" : getPath())
			 + (isModified ? "*" : "");
	}
	
	public function getIcon() : String
	{
		var plugin = ImporterPlugins.getByExtension(Path.extension(getPath()));
		return plugin == null ? "custom-icon-native-document" : plugin.menuItemIcon;
	}
	
	public function toggleSelection()
	{
		editor.toggleSelection();
	}
	
	public function deselectAll()
	{
		editor.deselectAll();
	}
	
	public function undo() undoQueue.undo();
	public function redo() undoQueue.redo();
	
	public function canUndo() return undoQueue.canUndo();
	public function canRedo() return undoQueue.canRedo();
	
	public function canCut() return clipboard.canCut();
	public function canCopy() return clipboard.canCopy();
	public function canPaste() return clipboard.canPaste();

	public function saveWithPrompt() : Promise<Bool>
	{
		if (isModified)
		{
			return new Promise<Bool>(function(resolve, reject)
			{
                popups.showConfirm("Confirmation", "Document was changed!", "Save", "Cancel", "Don't save").then(r ->
                {
                    switch (r.response)
                    {
                        case 0: save().then(r -> resolve(r));
                        case 1: // do nothing
                        case 2: resolve(true);
                        case _: reject(new js.lib.Error());
                    }
                });
			});
		}
		else
		{
			return Promise.resolve(true);
		}
	}
	
 	public function close(?force:Bool) : Promise<{}>
 	{
		if (force)
		{
			dispose();
			openedFiles.close(this);
			return Promise.resolve(null);
		}
		else
		{
			return saveWithPrompt().then(function(success:Bool)
			{
				dispose();
				openedFiles.close(this);
				return null;
			});
		}
 	}	
	
	public function undoStatusChanged() : Void
	{
		openedFiles.titleChanged(this);
	}    
	
	static function detectImporter(preferences:Preferences, path:String) : Importer
	{
		var plugin = ImporterPlugins.getByExtension(Path.extension(path));
		if (plugin == null) return null;
		return new Importer(plugin.name, plugin.getParams(preferences.storage));
	}
	
	function detectExporter(path:String) : Exporter
	{
		var plugin = ExporterPlugins.getByExtension(Path.extension(path));
		if (plugin == null) return null;
		return new Exporter(plugin.name, plugin.getParams(preferences.storage));
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
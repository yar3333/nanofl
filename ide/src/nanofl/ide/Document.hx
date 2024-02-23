package nanofl.ide;

import js.Browser.console;
import js.lib.Promise;
import haxe.io.Path;
import stdlib.Debug;
import stdlib.Uuid;
import stdlib.ExceptionTools;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.geom.Matrix;
import nanofl.ide.DocumentProperties;
import nanofl.ide.CodeGenerator;
import nanofl.ide.CodePublisher;
import nanofl.ide.editor.Editor;
import nanofl.ide.editor.EditorLibrary;
import nanofl.ide.editor.NewObjectParams;
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
import nanofl.ide.sys.WebServer;
import nanofl.ide.ui.View;
import nanofl.ide.undo.document.UndoQueue;
import nanofl.ide.textureatlas.TextureAtlasPublisher;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using stdlib.StringTools;

#if profiler @:build(Profiler.buildAll()) #end
@:rtti
class Document extends OpenedFile
{
	@inject var app : Application;
	@inject var preferences : Preferences;
	@inject var fileSystem : FileSystem;
	@inject var view : View;
	@inject var newObjectParams : NewObjectParams;
	@inject var folders : Folders;
	@inject var clipboard : Clipboard;
	@inject var webServer : WebServer;
	@inject var recents : Recents;
	
	function get_type() return OpenedFileType.DOCUMENT;
	
	var savedLibrary : IdeLibrary;

    public var allowAutoReloading(default, null) = true;
	
	/**
	 * Used when document was opened directly from none-NanoFL format. In other cases is null.
	 */
	public var originalPath(default, null) : String;
	
	/**
	 * Used to detect document modification.
	 */
	var originalProperties : DocumentProperties;
	
	/**
	 * Used when document was opened directly from none-NanoFL format. In other cases is null.
	 */
	public var originalLastModified(default, null) : Date;
	
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
	
	public var isTemporary(get, never) : Bool;
	function get_isTemporary() return path.startsWith(getBaseTemporaryDir(folders) + "/");
	
	public function getTabTextColor() return "";
	public function getTabBackgroundColor() return "";
	
	public function new(path:String, properties:DocumentProperties, library:IdeLibrary, ?lastModified:Date)
	{
		stdlib.Debug.assert(path != null);
		
		super(this);
		
		this.originalProperties = properties.clone();
		
		this.path = path;
		this.properties = properties;
		this.library = new EditorLibrary(library, this);
		this.lastModified = lastModified;
		
		if (lastModified != null) savedLibrary = library.clone();
		
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
		
		if (isTemporary)
		{
			if (originalPath == null)
			{
				if (!properties.equ(originalProperties))
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
	
	public static function createTemporary(openedFiles:OpenedFiles, folders:Folders, ?properties:DocumentProperties) : Document
	{
		if (properties == null) properties = new DocumentProperties();
		var path = generateTempFilePath(folders);
		var library = new IdeLibrary(Path.directory(path) + "/library");
		var document = new Document(path, properties, library);
		openedFiles.add(document);
		return document;
	}
	
	public static function load(fileSystem:FileSystem, openedFiles:OpenedFiles, preferences:Preferences, folders:Folders, view:View, path:String) : Promise<Document>
	{
		path = Path.normalize(path);
		
		if (Path.extension(path) == "nfl")
		{
			console.log("Loading " + path);
			
			return loadRaw(fileSystem, path, null).then(function(e:{ library:IdeLibrary, properties:DocumentProperties, lastModified:Date })
			{
				if (e != null)
				{
					var document = new Document(path, e.properties, e.library, e.lastModified);
					document.library.fixErrors();
					return e.library.preload().then(function(_)
					{
						openedFiles.add(document);
						return document;
					});
				}
				else
				{
					return null;
				}
			});
		}
		else
		{
			return import_(preferences, openedFiles, folders, view, path).then(function(document:Document) : Document
			{
				if (document != null)
				{
					document.originalPath = path;
					document.originalLastModified = Date.now();
				}
				return document;
			});
		}
	}
	
	public static function loadRaw(fileSystem:FileSystem, path:String, lastModified:Date) : Promise<{ library:IdeLibrary, properties:DocumentProperties, lastModified:Date }>
	{
		if (fileSystem.exists(path) && !fileSystem.isDirectory(path))
		{
			var realLastModified = fileSystem.getDocumentLastModified(path);
			
			if (lastModified == null || lastModified.getTime() < realLastModified.getTime())
			{
				var properties = DocumentProperties.load(path, fileSystem);
				var library = new IdeLibrary(Path.join([ Path.directory(path), "library" ]));
				return library.loadItems().then(_ ->
                ({
                    properties: properties,
                    library: library,
                    lastModified: realLastModified
                }));
			}
		}
		return Promise.resolve(null);
	}
	
	
	public function save() : Promise<Bool>
	{
		return saveAs
		(
			originalPath != null 
				? (detectExporter(originalPath) != null ? originalPath : null)
				: (!isTemporary ? path : null)
		);
	}
	
	public function saveAs(?newPath:String) : Promise<Bool>
	{
		if (newPath == null)
		{
			var exporters = ExporterPlugins.plugins.array();
			exporters.sort((a, b) -> Reflect.compare(a.name, b.name));
			
			var filters = [];
			filters.push({ name:"NanoFL documents (*.nfl)", extensions:["nfl"] });
			for (exporter in exporters) 
			{
				var extensions = exporter.fileFilterExtensions.filter((ext:String) ->
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
			
            return popups.showSaveFile("Select document file name to save", filters).then(r ->
            {
                if (StringTools.isNullOrEmpty(r.filePath)) return null;
                
                var path = r.filePath;
                var ext = Path.extension(path);
                if ([ "nfl", "xfl" ].contains(ext))
                {
                    var name = Path.withoutDirectory(Path.withoutExtension(path));
                    path = Path.join([ Path.directory(path), name, name + "." + ext ]);
                }
                
                return path;
            })
            .then(path ->
            {
                return !StringTools.isNullOrEmpty(path) ? saveAs(path) : Promise.resolve(false);
            });
		}
		else
		{
			recents.add(newPath, view);
			
			if (Path.extension(newPath) == "nfl")
			{
                if (!saveNative()) return Promise.resolve(false);

                var success = saveNativeAs(newPath);
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
			var oldPath = path;
			path = newPath;
			library.copyAndChangeDir(Path.directory(newPath) + "/library");
			fileSystem.syncDirectory(Path.directory(oldPath) + "/src", Path.directory(newPath) + "/src");
			lastModified = null;
			var success = saveNative();
			if (success) originalPath = null;
			else         path = oldPath;
			return success;
		}
	}
	
	public static function import_(preferences:Preferences, openedFiles:OpenedFiles, folders:Folders, view:View, path:String, ?importer:Importer) : Promise<Document>
	{
		if (importer == null) importer = detectImporter(preferences, path);
		
		if (importer != null)
		{
			return DocumentImporterHelper.run(path, createTemporary(openedFiles, folders), importer).then((document:Document) ->
			{
				if (document != null)
				{
					trace("Import success");
					
					document.library.fixErrors();
					
					return document.library.preload().then((_) ->
					{
						document.lastModified = Date.now();
						openedFiles.add(document);
						document.activate(true);
						view.waiter.hide();
						return document;
					});
				}
				else
				{
					trace("Import fail");
					view.waiter.hide();
					return null;
				}
			});
		}
		else
		{
			return Promise.resolve(null);
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
					var plugin = ExporterPlugins.plugins.get(exporterName);
					fileFilters.push({ name:plugin.fileFilterDescription, extensions:plugin.fileFilterExtensions });
				}
			}

            return new Promise<Bool>((resolve, reject) ->
            {
                popups.showSaveFile("Select destination file name to export", fileFilters).then(r ->
                {
                    if (r.filePath != null)
                    {
                        export(r.filePath, plugin).then((success:Bool) ->
                        {
                            if (success) openedFiles.titleChanged(this);
                            resolve(success);
                        });
                    }
                    else
                    {
                        resolve(false);
                    }
                });
            });
		}
		else
		{
			var exporter = plugin != null
				? new Exporter(plugin.name, plugin.getParams(preferences.storage))
				: detectExporter(destPath);
			
			if (exporter != null)
			{
				if (!saveNative()) return Promise.resolve(false);
                return DocumentExporterHelper.run(this, destPath, exporter);
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
        return loadRaw(fileSystem, path, !force ? lastModified : null).then((e:{ library:IdeLibrary, properties:DocumentProperties, lastModified:Date }) ->
        {
            if (e == null) return Promise.resolve({ added:[], removed:[] });
            
            var itemsToRemove = library.getItems().filter(x -> !e.library.hasItem(x.namePath));
            var itemsToAdd = e.library.getItemsAsIde().filter(x -> !library.hasItem(x.namePath));
            
            if (addUndoTransaction) undoQueue.beginTransaction({ libraryRemoveItems:itemsToRemove.map(x -> x.namePath), libraryAddItems:true });
            library.removeItems(itemsToRemove.map(x -> x.namePath));
            library.addItems(itemsToAdd, false);
            if (addUndoTransaction) undoQueue.commitTransaction();
            
            return library.preload().then(_ ->
            {
                editor.rebind();
                library.update();
                
                lastModified = e.lastModified;
                savedLibrary = library.getRawLibrary().clone();
                
                return { added:itemsToAdd, removed:itemsToRemove };
            });
        });
	}
	
	public function test() : Promise<Bool>
	{
		return publish().then((success:Bool) ->
		{
			if (success)
			{
				var htmlFilePath = getPublishDirectory() + "/index.html";
				
				if (!fileSystem.exists(htmlFilePath))
				{
					view.alerter.error("File \"" + htmlFilePath + "\" not found.");
					return false;
				}
				
				webServer.openInBrowser(htmlFilePath);
			}
			
			return success;
		});
	}
	
	public function publish() : Promise<Bool>
	{
		view.output.clear();
		
		var promise = Promise.resolve(saveNative()).then(success ->
		{
			log("saved " + success);
			if (!success) throw new DocumentError("Can't save file " + getPath() + ".");
			return true;
		});
		
		for (openedFile in openedFiles)
		{
			if (openedFile != this && openedFile.relatedDocument == this)
			{
				if (openedFile.isModified)
				{
					promise = promise.then(_ ->
					{
						log("save " + openedFile.getPath());
						return openedFile.save().then(success ->
						{
							if (success) return true;
							throw new DocumentError("Can't save file " + openedFile.getPath() + ".");
						});
					});
				}
			}
		}
		
		return promise.then(_ ->
		{
			log("prepare output directory");
			var destDir = getPublishDirectory();
			
            log("destDir = " + destDir);
            fileSystem.createDirectory(destDir);
			if (!fileSystem.isDirectory(destDir)) throw new DocumentError("Can't prepare output directory '" + destDir + "'.");
			
            if (properties.publishSettings.useTextureAtlases && properties.publishSettings.textureAtlases.iterator().hasNext())
            {
                log("Publish texture atlases");
                TextureAtlasPublisher.publish(fileSystem, library.getRawLibrary(), properties.publishSettings.textureAtlases, destDir);
            }
            else
            {
                TextureAtlasPublisher.deleteFiles(fileSystem, destDir);
            }

    		log("Publish library items to " + Path.directory(path));
			var publishedLibrary = library.publishItems(properties.publishSettings, destDir);

            log("Publish 'library.js'");
            publishedLibrary.publishLibraryJsFile(destDir);

            final hasCodeToPublish = publishedLibrary.getInstancableItems().exists(x -> x.linkedClass != "");
    
            CodePublisher.publishHtmlAndJsFiles
            (
                destDir,
                properties,
                publishedLibrary.getMeshes().length > 0, // add link to three.js ?
                hasCodeToPublish // add link to application.js ?
            );

            if (hasCodeToPublish) CodeGenerator.generate(publishedLibrary, destDir + "/src/autogen.ts");
            else
            {
                fileSystem.deleteFile(destDir + "/src/autogen.ts");
                try { fileSystem.deleteEmptyDirectory(destDir + "/src"); } catch (_) {}
            }
			
			view.alerter.info("Published successfully.");

            return Promise.resolve(true);
		})
		.catchError((e:Dynamic) ->
		{
			log("catchError = " + e);
			
			if (Std.isOfType(e, DocumentError))
			{
				view.alerter.error((cast e:DocumentError).message);
				return false;
			}
			else
			{
				ExceptionTools.rethrow(e);
				return false;
			}
		});
	}
	
	function getPublishDirectory()
	{
		var r = originalPath != null
			  ? detectImporter(preferences, originalPath).getPublishPath(originalPath)
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
			: (!isTemporary && lastModified != null && app.document.undoQueue.isDocumentModified());
	}
	
	public function dispose()
	{
		if (isTemporary)
		{
			stdlib.Debug.assert(path.startsWith(folders.temp));
			try fileSystem.deleteAny(Path.directory(path)) catch (_:Dynamic) {}
		}
	}
	
	public function saveNative() : Bool
	{
		if (lastModified != null && !undoQueue.isDocumentModified()) return true;
		
        undoQueue.commitTransaction();
        
        var e = saveDocument
        (
            path,
            properties,
            library.getRawLibrary(),
            FileActions.fromUndoOperations(undoQueue.getOperationsFromLastSaveToNow())
        );
        
        lastModified = e.lastModified;
        savedLibrary = library.getRawLibrary().clone();
        undoQueue.documentSaved();
        openedFiles.titleChanged(this);
        trace("Saved " + path);
        if (e.errorMessage != null) view.alerter.error("Generator error: " + e.errorMessage);
        
        return true;
	}
	
	function saveDocument(path:String, properties:DocumentProperties, library:IdeLibrary, fileActions:Array<FileAction>) : { lastModified:Date, errorMessage:String }
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
		
		return { lastModified:Date.now(), errorMessage:null };
	}

    public function runPreventingAutoReload<T>(f:Void->Promise<T>) : Promise<T>
    {
        allowAutoReloading = false;
        
        try
        {
            return f()  .catchError(e ->
                        {
                            allowAutoReloading = true;
                            throw e;
                        })
                        .then(r -> {
                            allowAutoReloading = true;
                            return r;
                        });
        }
        catch (e)
        {
            allowAutoReloading = true;
            throw e;
        }
    }
	
	public function getShortTitle() : String
	{
		return (isTemporary && originalPath == null ? "Untitled" : Path.withoutDirectory(originalPath != null ? originalPath : Path.withoutExtension(path)))
			 + (isModified ? "*" : "");
	}
	
	public function getPath() : String return originalPath != null ? originalPath : path;
	
	public function getLongTitle() : String
	{
		return (isTemporary && originalPath == null ? "Untitled" : getPath())
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
	
	static function generateTempFilePath(folders:Folders) : String
	{
		var name = Uuid.newUuid();
		return getBaseTemporaryDir(folders) + "/" + name + "/" + name + ".nfl";
	}
	
	static function getBaseTemporaryDir(folders:Folders) return folders.temp + "/unsaved";
	
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
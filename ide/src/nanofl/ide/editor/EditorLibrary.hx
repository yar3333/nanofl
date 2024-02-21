package nanofl.ide.editor;

import nanofl.ide.textureatlas.TextureAtlasPublisher;
import haxe.io.Path;
import stdlib.ExceptionTools;
import js.lib.Promise;
import htmlparser.HtmlNodeElement;
import js.Browser;
import js.Browser.console;
import js.html.File;
import nanofl.engine.FontVariant;
import nanofl.ide.MovieClipItemTools;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.ide.libraryitems.*;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.PublishSettings;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.library.LibraryItems;
import nanofl.ide.library.IdeLibraryTools;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Uploader;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;
import nanofl.ide.undo.states.LibraryState;
import stdlib.Std;
using stdlib.StringTools;
using stdlib.Lambda;

@:rtti
class EditorLibrary extends InjectContainer
{
	@inject var app : Application;
	@inject var popups : Popups;
	@inject var view : View;
	@inject var fileSystem : FileSystem;
	@inject var clipboard : Clipboard;
	@inject var uploader : Uploader;
	@inject var preferences : Preferences;
	
	var library : IdeLibrary;
	var document : Document;
	
	public var libraryDir(get, never) : String;
	function get_libraryDir() return library.libraryDir;
	
	public function new(library:IdeLibrary, document:Document)
	{
		super();
		
		this.library = library;
		this.document = document;
	}
	
	public var activeItem(get, set) : IIdeLibraryItem;
	function get_activeItem() return view.library.activeItem;
	function set_activeItem(v:IIdeLibraryItem) return view.library.activeItem = v;
	
	public function addItems(items:Array<IIdeLibraryItem>, addUndoTransaction=true)
	{
		if (addUndoTransaction) document.undoQueue.beginTransaction({ libraryAddItems:true });
		for (item in items) library.addItem(item);
		if (addUndoTransaction) document.undoQueue.commitTransaction();
	}
	
	public function canRenameItem(oldNamePath:String, newNamePath:String) : Bool
	{
		return newNamePath != IdeLibrary.SCENE_NAME_PATH && library.canRenameItem(oldNamePath, newNamePath);
	}
	
	public function renameItems(itemRenames:Array<{ oldNamePath:String, newNamePath:String }>)
	{
		document.undoQueue.beginTransaction({ libraryRenameItems:itemRenames });
		for (t in itemRenames)
		{
			library.renameItem(t.oldNamePath, t.newNamePath);
		}
		document.undoQueue.commitTransaction();
	}
	
	public function removeItems(namePaths:Array<String>) : Void
	{
		document.undoQueue.beginTransaction({ libraryRemoveItems:namePaths });
		
		var n = app.document.navigator.editPath.findIndex(x -> Std.isOfType(x.element, Instance) && namePaths.indexOf((cast x.element:Instance).symbol.namePath) >= 0);
		if (n >= 0)
		{
			app.document.navigator.navigateTo(app.document.navigator.editPath.slice(0, n));
		}
		else
		{
			app.document.navigator.navigateTo(app.document.navigator.editPath);
		}
		
		for (namePath in namePaths) library.removeItem(namePath);
		
		document.undoQueue.commitTransaction();
		
		app.document.editor.rebind();
		view.movie.timeline.update();
		view.movie.timeline.update();
		update();
	}
	
	public function copyAndChangeDir(libraryDir:String) : Void
	{
		var oldLibraryDir = library.libraryDir;
		library.libraryDir = libraryDir;
		fileSystem.syncDirectory(oldLibraryDir, libraryDir);
	}
	
	public function getNextItemName() : String
	{
		var prefix = "LibraryItem ";
		var i = library.getItemCount();
		while (true)
		{
			if (!hasItem(prefix + i)) return prefix + i;
			i++;
		}
	}
	
	public function hasItem(namePath:String) return library.hasItem(namePath);
	public function addFont(family:String, variants:Array<FontVariant>) library.addFont(family, variants);
	public function preload() : Promise<{}> return library.preload();
	public function getItem(namePath:String) return library.getItem(namePath);
	public function getSceneInstance() return library.getSceneInstance();
	public function getSceneItem() return library.getSceneItem();
	public function getItems(?includeScene:Bool) return library.getItemsAsIde(includeScene);
	
	@:allow(nanofl.ide.undo)
	function getState(itemsToClone:Array<String>) return library.getState(itemsToClone);
	
	@:allow(nanofl.ide.undo)
	function setState(state:LibraryState) { library.setState(state); update(); }
	
	public function getRawLibrary() return library;
	
	public function getSelectedItemsWithDependencies() : Array<IIdeLibraryItem>
	{
		var r = [];
		for (item in getSelectedItems())
		{
			if (r.indexOf(item) < 0) r.push(item);
			if (Std.isOfType(item, MovieClipItem))
			{
				MovieClipItemTools.findInstances((cast item:MovieClipItem), (instance, _) ->
				{
					if (r.indexOf((cast instance.symbol:IIdeLibraryItem)) < 0) r.push((cast instance.symbol:IIdeLibraryItem));
				});
			}
			else
			if (Std.isOfType(item, FolderItem))
			{
				for (item2 in getItems())
				{
					if (item2.namePath.startsWith(item.namePath + "/"))
					{
						if (r.indexOf(item2) < 0) r.push(item2);
					}
				}
			}
		}
		return r;
	}
	
	public function hasSelected() return getSelectedItems().length > 0;
	
	public function removeSelected() view.library.removeSelected();
	public function renameByUser(namePath:String) view.library.renameByUser(namePath);
	public function deselectAll() view.library.deselectAll();
	public function update() view.library.update();
	public function getSelectedItems() : Array<IIdeLibraryItem> return view.library.getSelectedItems();
	public function gotoPrevItem(overwriteSelection:Bool) view.library.gotoPrevItem(overwriteSelection);
	public function gotoNextItem(overwriteSelection:Bool) view.library.gotoNextItem(overwriteSelection);
	public function showPropertiesPopup() view.library.showPropertiesPopup();
	
	public function createEmptyMovieClip()
	{
		popups.prompt.show("Create Empty Movie Clip", "Enter new symbol name:", getNextItemName(), function(namePath)
		{
			if (namePath != null && namePath != "")
			{
				if (!hasItem(namePath))
				{
					addItems([ MovieClipItem.createWithFrame(namePath) ]);
					update();
				}
				else
				{
					Browser.window.alert("Symbol '" + namePath + "' already exists.");
				}
			}
		});
	}
	
	public function createFolder()
	{
		popups.prompt.show("Create Folder", "Enter new folder name:", getNextItemName(), function(namePath)
		{
			if (namePath != null && namePath != "")
			{
				if (!hasItem(namePath))
				{
					addItems([ new FolderItem(namePath) ]);
					update();
				}
				else
				{
					Browser.window.alert("Symbol '" + namePath + "' already exists.");
				}
			}
		});
	}
	
	public function importFiles(?paths:Array<String>, folderPath="") : Promise<{}>
	{
		if (paths == null)
		{
			return popups.showOpenFile
			(
				"Select files to import into library", 
				[
					{ name:"All supported files", extensions:["png", "jpg", "svg", "wav", "mp3", "ogg"] },
					{ name:"Image files", extensions:["png", "jpg", "svg"] },
					{ name:"Sound files", extensions:["wav", "mp3", "ogg"] }
				],
				true
			)
            .then(r ->
            {
                // TODO: check - may be return true/false?
                return r.filePaths != null ? importFiles(r.filePaths, folderPath) : null;
            });
		}
		else
		{
			view.waiter.show();
			
			var files = [];
			for (path in paths)
			{
				var file = Path.withoutDirectory(path);
				var destLocalPath = Path.join([ folderPath, file ]);
				var dest = Path.join([ library.libraryDir, destLocalPath ]);
				fileSystem.copyFile(path, dest);
				files.push(destLocalPath);
			}
			
			return LibraryItems.load(preferences, library.libraryDir, files).then(function(items:Array<IIdeLibraryItem>)
			{
				for (item in items)
				{
					library.addItem(item);
				}
				
				return library.preload().then(function(_)
				{
					view.waiter.hide();
					update();
					return null;
				});
			});
		}
	}
	
	public function importImages(folderPath="") : Promise<{}>
	{
		return popups.showOpenFile
		(
			"Select image files to import into library", 
			[
				{ name:"Image files", extensions:["png", "jpg", "svg"] }
			],
			true
		)
        .then(r ->
        {
            return app.document.library.importFiles(r.filePaths, folderPath);
        });
	}
	
	public function importSounds(folderPath="") : Promise<{}>
	{
		return popups.showOpenFile
		(
			"Select sound files to import into library",
			[
				{ name:"Sound files", extensions:["wav", "mp3", "ogg"] }
			],
			true
		)
        .then(r ->
        {
            return app.document.library.importFiles(r.filePaths, folderPath);
        });
	}
	
	public function importMeshes(folderPath="") : Promise<{}>
	{
		return popups.showOpenFile
		(
			"Select mesh files to import into library",
			[
				{ name:"Mesh files", extensions:["blend", "json"] }
			],
			true
		)
        .then(r ->
        {
            return app.document.library.importFiles(r.filePaths, folderPath);
        });
	}
	
	public function importFont()
	{
		popups.fontImport.show();
	}
	
	public function addFiles(files:Array<File>, folderPath="") : Promise<Array<IIdeLibraryItem>>
	{
        return document.runPreventingAutoReload(() ->
        {
            document.saveNative();
			
			return uploader.saveUploadedFiles(files, Path.join([ library.libraryDir, folderPath ])).then(_ ->
			{
                return document.reload().then((e:{ added:Array<IIdeLibraryItem> }) ->
                {
                    if (folderPath != "")
                    {
                        var folder : FolderItem = cast getItem(folderPath);
                        folder.opened = true;
                        view.library.update();
                        view.library.select(e.added.map(x -> x.namePath));
                    }
                    return e.added;
                });
            });
		});
	}
	
	public function loadFilesFromClipboard() : Bool
	{
        log("EditorLibrary.loadFilesFromClipboard");
        if (!document.saveNative()) return false;
        clipboard.loadFilesFromClipboard(libraryDir);
        return true;
	}
	
	public function copyFilesIntoLibrary(srcDir:String, relativePaths:Array<String>) : Void
	{
        log("EditorLibrary.copyFilesIntoLibrary");
        document.saveNative();
        fileSystem.copyLibraryFiles(srcDir, relativePaths, libraryDir);
	}
	
	public function selectUnusedItems()
	{
		view.library.select(IdeLibraryTools.getUnusedItems(library, false).map(x -> x.namePath));
	}
	
	public function removeUnusedItems()
	{
		removeItems(IdeLibraryTools.getUnusedItems(library, false).map(x -> x.namePath));
	}
	
	public function optimize()
	{
		document.undoQueue.beginTransaction({ libraryChangeItems:getItems(true).map(x -> x.namePath) });
		
		library.optimize();
		
		document.undoQueue.commitTransaction();
		
		app.document.editor.rebind();
		view.movie.timeline.update();
		view.movie.timeline.update();
		update();
	}
	
	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, folder:String) : Promise<Array<IIdeLibraryItem>>
	{
		return LibraryItems.drop(dropEffect, data, document, folder);
	}
	
	public function getWithExandedFolders(items:Array<IIdeLibraryItem>) : Array<IIdeLibraryItem>
	{
		var r = items.copy();
		for (item in items)
		{
			var subItems = library.getItemsInFolderAsIde(item.namePath);
			for (subItem in subItems) 
			{
				if (r.indexOf(subItem) < 0) r.push(subItem);
			}
		}
		return r;
	}
	
	public function fixErrors()
	{
		for (item in getItems(true).filterByType(MovieClipItem))
		{
			var wasFixed = false;

            for (element in MovieClipItemTools.getElements(item))
            {
                var original = element.getState();
                
                try
                {
                    if (element.fixErrors())
                    {
                        //console.log("Fix errors in the element \"" + element.toString() + "\".");
                        wasFixed = true;
                    }
                }
                catch (e:Dynamic)
                {
                    console.log("Exception while fixing element in " + item.namePath + ":");
                    console.log(ExceptionTools.wrap(e).toString());
                    log(original);
                }
			}
			
			if (wasFixed) trace("Fix errors in item \"" + item.namePath + "\".");
		}
		
		if (!hasItem(IdeLibrary.SCENE_NAME_PATH))
		{
			library.addSceneWithFrame();
		}
		else
		{
			var scene = getSceneItem();
			if (scene.layers.length == 0)
			{
				scene.addLayer(new Layer("Layer 0"));
			}
			
			if (scene.getTotalFrames() == 0)
			{
				scene.layers[0].addKeyFrame(new KeyFrame());
			}
		}
	}
	
	public function publishItems(settings:PublishSettings, destDir:String) : IdeLibrary
	{
		var publishedItems = [];

        var destLibraryDir = destDir + "/library";
        fileSystem.deleteAnyByPattern(destLibraryDir + "/*");
		
		for (item in IdeLibraryTools.getUsedItems(library, settings.useTextureAtlases))
		{
			log("Publish item " + item.namePath);
			var publishedItem = item.publish(fileSystem, settings, destLibraryDir);
			if (publishedItem != null) publishedItems.push(publishedItem);
		}

        if (publishedItems.length == 0) fileSystem.deleteEmptyDirectory(destLibraryDir);
		
        return new IdeLibrary(destLibraryDir, publishedItems);
	}

	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
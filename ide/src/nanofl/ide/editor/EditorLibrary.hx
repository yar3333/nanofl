package nanofl.ide.editor;

import nanofl.ide.library.dropprocessors.LibraryDragAndDropTools;
import stdlib.Debug;
import haxe.io.Path;
import js.lib.Promise;
import js.Browser;
import js.html.File;
import stdlib.ExceptionTools;
import stdlib.Std;
import htmlparser.HtmlNodeElement;
import nanofl.engine.LibraryItemType;
import nanofl.engine.Log.console;
import nanofl.engine.FontVariant;
import nanofl.ide.MovieClipItemTools;
import nanofl.ide.sys.Shell;
import nanofl.ide.filesystem.ExternalChangesDetector;
import nanofl.ide.plugins.LoaderPlugins;
import nanofl.ide.libraryitems.IIdeLibraryItem;
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
import nanofl.ide.sys.MediaUtils;
import nanofl.ide.sys.Uploader;
import nanofl.ide.ui.Popups;
import nanofl.ide.ui.View;
import nanofl.ide.undo.states.LibraryState;
using stdlib.StringTools;
using stdlib.Lambda;

@:rtti
class EditorLibrary extends InjectContainer
{
	@inject var popups : Popups;
	@inject var view : View;
	@inject var fileSystem : FileSystem;
	@inject var mediaUtils : MediaUtils;
	@inject var clipboard : Clipboard;
	@inject var uploader : Uploader;
	@inject var preferences : Preferences;
	@inject var externalChangesDetector : ExternalChangesDetector;
	@inject var shell(default, never) : Shell;
	
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
            if (view.library.activeItem?.namePath == t.oldNamePath)
            {
                view.library.activeItem = getItem(t.newNamePath);
            }
		}
        update();
		document.undoQueue.commitTransaction();
	}
	
	public function removeItems(namePaths:Array<String>) : Void
	{
		document.undoQueue.beginTransaction({ libraryRemoveItems:namePaths });
		
		var n = document.navigator.editPath.findIndex(x -> namePaths.contains(x.mcItem.namePath));
		if (n >= 0)
		{
			document.navigator.navigateTo(document.navigator.editPath.slice(0, n), true, false);
		}
		
		for (namePath in namePaths) library.removeItem(namePath);
		
		document.undoQueue.commitTransaction();
		
		document.editor.rebind();
		view.movie.timeline.update();
		view.movie.timeline.update();
		update();
	}
	
	public function changeDir(libraryDir:String) : Void
	{
		library.libraryDir = libraryDir;
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

    function getNextItemNamePathForDuplication(baseNamePath:String)
    {
        final re = ~/(.+) Copy(?: (\d+))?$/;
        final baseName = re.match(baseNamePath) ? re.matched(1) : baseNamePath;
        
        final namePaths = library.getItemsAsIde().filter(x -> x.namePath.startsWith(baseName)).map(x -> x.namePath);
        var maxN = -1; for (namePath in namePaths) if (re.match(namePath)) maxN = Std.max(maxN, re.matched(2) != null ? Std.parseInt(re.matched(2)) : 0);
        maxN++;

        final r = baseName + " Copy" + (maxN > 0 ? " " + maxN : "");
        Debug.assert(!library.hasItem(r));
        return r;
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
		popups.prompt.show("Create Empty Movie Clip", "Enter new symbol name:", getNextItemName(), namePath ->
		{
			if (namePath == null || namePath == "") return;

            if (hasItem(namePath))
            {
                Browser.window.alert("Symbol '" + namePath + "' already exists.");
                return;
            }

            addItems([ MovieClipItem.createWithFrame(namePath) ]);
            update();
		});
	}
	
	public function createFolder()
	{
		popups.prompt.show("Create Folder", "Enter new folder name:", getNextItemName(), namePath ->
		{
			if (namePath == null || namePath == "") return;
            
            if (hasItem(namePath))
            {
                Browser.window.alert("Symbol '" + namePath + "' already exists.");
                return;
            }
				
            addItems([ new FolderItem(namePath) ]);
            update();
		});
	}
	
	public function importFiles(folderPath="") : Promise<{}>
	{
        var filters = LoaderPlugins.plugins.filter(x -> x.extensions != null && x.extensions.length > 0)
                                           .map(x -> { name:x.menuItemName + " files", extensions:x.extensions });
        
        filters.unshift({ name:"All supported files", extensions:filters.flatMap(x -> x.extensions).distinct() });
        
        return popups.showOpenFiles("Select files to import into library", filters)
                .then(filePaths -> 
                {
                    if (filePaths != null) importFilesInner(filePaths, folderPath);
                    return null;
                });
    }
    
    function importFilesInner(paths:Array<String>, folderPath="") : Void
    {
        for (path in paths)
        {
            var file = Path.withoutDirectory(path);
            var destLocalPath = Path.join([ folderPath, file ]);
            var dest = Path.join([ library.libraryDir, destLocalPath ]);
            fileSystem.copyFile(path, dest);
        }
    }
	
	public function importFont()
	{
		popups.fontImport.show();
	}
	
	public function addUploadedFiles(files:Array<File>, folderPath="") : Promise<Array<IIdeLibraryItem>>
	{
        return externalChangesDetector.runPreventingAutoReloadAsync(() ->
        {
            document.saveNative();
			
			return uploader.saveUploadedFiles(files, Path.join([ library.libraryDir, folderPath ]))
                .then(_ -> document.reload())
                .then(e ->
                {
                    if (folderPath != "")
                    {
                        final folder : FolderItem = cast getItem(folderPath);
                        folder.opened = true;
                        view.library.update();
                        view.library.select(e.added.map(x -> x.namePath));
                    }
                    return e.added;
                });
            });
	}
	
	public function addFilesFromClipboard() : Bool
	{
        log("EditorLibrary.addFilesFromClipboard");
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
		
		document.editor.rebind();
		view.movie.timeline.update();
		view.movie.timeline.update();
		update();
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
        var usedItems = IdeLibraryTools.getUsedItems(library, settings.useTextureAtlases);
        
        final savedData = new Map<String, Dynamic>();
        for (item in usedItems) savedData.set(item.namePath, item.getDataToSaveBeforeCleanDestDirectoryAndPublish(fileSystem, destLibraryDir));

        fileSystem.deleteAnyByPattern(destLibraryDir + "/*");
		
		for (item in usedItems)
		{
			log("Publish item " + item.namePath);
			var publishedItem = item.publish(fileSystem, mediaUtils, settings, destLibraryDir, savedData.get(item.namePath));
			if (publishedItem != null) publishedItems.push(publishedItem);
		}

        if (publishedItems.length == 0) fileSystem.deleteEmptyDirectory(destLibraryDir);
		
        return new IdeLibrary(destLibraryDir, publishedItems);
	}

    public function duplicate()
    {
 		final selectedItems = getSelectedItems().filter(x -> !x.type.match(LibraryItemType.folder));
        if (selectedItems.length == 0) return;

        externalChangesDetector.runPreventingAutoReloadAsync(() ->
        {
            document.saveNative();
            
            document.undoQueue.beginTransaction({ libraryAddItems:true });
        
            final newNamePaths = [];
            for (item in selectedItems)
            {
                final newNamePath = getNextItemNamePathForDuplication(item.namePath);
                newNamePaths.push(newNamePath);
                
                library.addItem(item.duplicate(newNamePath));
                fileSystem.copyByPattern(library.libraryDir + "/" + item.namePath + ".*", library.libraryDir + "/" + newNamePath + ".*");
            }

            return document.reloadWoTransactionForced().then(_ ->
            {
                view.library.select(newNamePaths);
                view.library.activeItem = library.getItem(newNamePaths[0]);
                document.undoQueue.commitTransaction();
            });
        });
    }

    public function openInAssociated()
    {
        for (item in getSelectedItems())
        {
            final filePath = LibraryItemTools.getFilePathToRunInExternalEditor(fileSystem, library.libraryDir, item.namePath);
            if (filePath != null) shell.openInAssociatedApplication(filePath);
        }
    }
    
    public function showInExplorer()
    {
        for (item in getSelectedItems())
        {
            final filePath = LibraryItemTools.getFilePathToRunInExternalEditor(fileSystem, library.libraryDir, item.namePath);
            if (filePath != null) shell.showInFileExplorer(filePath);
        }
    }

	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
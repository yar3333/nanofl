package nanofl.ide.library;

import stdlib.Uuid;
import haxe.Json;
import datatools.ArrayRO;
import datatools.ArrayTools;
import haxe.io.Path;
import js.lib.Promise;
import nanofl.engine.FontVariant;
import nanofl.engine.MovieClipItemTools;
import nanofl.engine.elements.TextElement;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.ide.libraryitems.*;
import nanofl.ide.library.LibraryItems;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.sys.FileSystem;
import stdlib.Debug;
import stdlib.Std;
using StringTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
@:rtti
class IdeLibrary extends nanofl.engine.Library
{
	public static final SCENE_NAME_PATH = nanofl.engine.Library.SCENE_NAME_PATH;
	public static final GROUPS_NAME_PATH = nanofl.engine.Library.GROUPS_NAME_PATH;
	
	@inject var fileSystem : FileSystem;
	@inject var preferences : Preferences;
    
	public function new(libraryDir:String, ?items:ArrayRO<IIdeLibraryItem>)
    {
        super(libraryDir, items);
        
        Globals.injector.injectInto(this);
    }

	override public function getItem(namePath:String) return (cast super.getItem(namePath) : IIdeLibraryItem);
        
    override public function getSceneItem() : MovieClipItem
	{
		return cast(items.get(SCENE_NAME_PATH), MovieClipItem);
	}
	
	override public function getSceneInstance() : Instance
	{
		return getSceneItem().newInstance();
	}
	
	public function getInstancableItemsAsIde() : Array<IIdeInstancableItem>
	{
		return getItemsAsIde(true).filterByType(IIdeInstancableItem);
	}

	public function getItemsAsIde(?includeScene:Bool) : Array<IIdeLibraryItem>
    {
        return (cast getItems(includeScene) : Array<IIdeLibraryItem>);
    }
	
	public function getBitmapsAsIde() : Array<BitmapItem>
	{
        return getItemsAsIde().filterByType(BitmapItem);
	}
	
	public function getSoundsAsIde() : Array<SoundItem>
	{
        return getItemsAsIde().filterByType(SoundItem);
	}
	
	public function getFontItemsAsIde() : Array<FontItem>
	{
		return getItemsAsIde().filterByType(FontItem);
	}

	public function getItemsInFolderAsIde(folderNamePath:String) : Array<IIdeLibraryItem>
    {
        return cast super.getItemsInFolder(folderNamePath);
    }
	
	public function save(fileSystem:nanofl.ide.sys.FileSystem)
	{
        log("save: " + libraryDir);
        Debug.assert(libraryDir != null);
		
		for (item in getItemsAsIde(true))
		{
			item.save(fileSystem);
		}
	}
	
	override public function realUrl(url:String) : String
	{
		if (url.indexOf("//") >= 0) return url;
		return "file:///" + libraryDir + "/" + url;
	}
	
	override function createItemOnItemNotFound(namePath:String) : IIdeLibraryItem
	{
		return MovieClipItem.createWithFrame(namePath, [ new TextElement("", 0, 0, false, true, [ new TextRun("Symbol '" + namePath + "' is not found.") ]) ], "temp");
	}
	
    public function addSceneWithFrame(?elements:Array<Element>, ?layerName:String) : MovieClipItem
	{
		final scene = MovieClipItem.createWithFrame(IdeLibrary.SCENE_NAME_PATH, elements, layerName);
		addItem(scene);
		return scene;
	}
    
	override public function clone() : IdeLibrary
	{
		return new IdeLibrary(libraryDir, ArrayTools.clone(getItemsAsIde(true)));
	}
	
	public function loadItems() : Promise<{}>
	{
		log("loadItems: " + libraryDir);
		
		final files = [];
		final dirs = [];
		
		fileSystem.findFiles
		(
			libraryDir,
			file -> { files.push(file.substr(libraryDir.length + 1)); },
			dir  -> {  dirs.push( dir.substr(libraryDir.length + 1)); return true; }
		);
		
		return LibraryItems.load(preferences, libraryDir, files).then((items:Array<IIdeLibraryItem>) ->
		{
			for (item in items)
			{
				Debug.assert(item != null);
				if (!hasItem(item.namePath))
				{
					addItem(item);
				}
			}
			
			for (dir in dirs)
			{
                final namePath = Path.withoutExtension(dir);
				if (!hasItem(namePath))
				{
					addItem(new FolderItem(namePath));
				}
			}
			
			return null;
		});
	}
	
	public function addFont(family:String, variants:Array<FontVariant>)
	{
		for (item in items)
		{
			if (Path.withoutDirectory(item.namePath) == family && Std.isOfType(item, FontItem))
			{
				for (variant in variants)
				{
					(cast item:FontItem).addVariant(variant);
				}
				return;
			}
		}
		
		addItem(new FontItem(family, variants));
	}
	
	public function canRenameItem(oldNamePath:String, newNamePath:String) : Bool
	{
		if (newNamePath == null || newNamePath == "" || newNamePath.startsWith(oldNamePath + "/")) return false;
		
		var folders = newNamePath.split("/");
		for (i in 1...folders.length)
		{
			var folder = items.get(folders.slice(0, i).join("/"));
			if (folder != null && !Std.isOfType(folder, FolderItem)) return false;
		}
		
		return true;
	}
	
	public function renameItem(oldNamePath:String, newNamePath:String)
	{
		Debug.assert(canRenameItem(oldNamePath, newNamePath), "oldNamePath = '" + oldNamePath + "', newNamePath = '" + newNamePath + "'");

        log("renameItem: " + oldNamePath + " => " + newNamePath);
		
		for (item in getItemsInFolder(oldNamePath))
		{
			var newNamePath2 = newNamePath + item.namePath.substring(oldNamePath.length);
			renameItemInner(item.namePath, newNamePath2);
		}
		renameItemInner(oldNamePath, newNamePath);
		
		ensureFolderOfItemExists(newNamePath);
	}
	
	function renameItemInner(oldNamePath:String, newNamePath:String)
	{
		var item = items.get(oldNamePath);
		Debug.assert(item != null, "IdeLibrary.renameItem " + oldNamePath + " => " + newNamePath);

        log("*   renameItemInner: " + oldNamePath + " => " + newNamePath);
		
		items.remove(oldNamePath);
		items.set(newNamePath, item);
		item.namePath = newNamePath;
		
		for (item in items.filterByType(MovieClipItem))
		{
            MovieClipItemTools.iterateElements(item, true, (element, _) ->
            {
                if (Std.isOfType(element, ShapeElement))
                {
                    (cast element:ShapeElement).swapInstance(oldNamePath, newNamePath);
                }
                else
                if (Std.isOfType(element, Instance))
                {
                    if ((cast element:Instance).namePath == oldNamePath) (cast element:Instance).namePath = newNamePath;
                }
            });
		}
	}
	
	public function publishLibraryJsFile(destDir:String) : Void
	{
		var list : Dynamic<String> = {};
		
		for (item in getItemsAsIde(true))
		{
            if (Std.isOfType(item, FolderItem)) continue;
            Reflect.setField(list, item.namePath, item.saveToJson());
		}
		
		fileSystem.saveContent(destDir + "/library.js", "libraryData =\n" + Json.stringify(list, "  "));
	}
	
	@:allow(nanofl.ide.editor.EditorLibrary)
	function getState(itemsToClone:Array<String>) : nanofl.ide.undo.states.LibraryState
	{
		var r = [];
		for (item in items)
		{
			r.push(cast(itemsToClone.exists(x -> item.namePath == x) ? item.clone() : item, IIdeLibraryItem));
		}
		return r;
	}
	
	@:allow(nanofl.ide.editor.EditorLibrary)
	function setState(state:nanofl.ide.undo.states.LibraryState)
	{
		items = new Map();
		for (item in state) addItem(item);
	}
	
	public function removeUnusedItems()
	{
		for (item in IdeLibraryTools.getUnusedItems(this, false))
		{
			removeItem(item.namePath);
		}
	}
	
	public function optimize()
	{
		IdeLibraryTools.optimize(this);
	}

    override function ensureFolderOfItemExists(namePath:String)
    {
        final parts = namePath.split("/");
        for (i in 1...parts.length)
        {
            final folder = parts.slice(0, i).join("/");
            if (!hasItem(folder)) addItem(new FolderItem(folder));
        }
    }

    public function getSceneFramesIterator(documentProperties:DocumentProperties, applyBackgroundColor:Bool) : SceneFramesIterator
    {
        return new SceneFramesIterator(documentProperties, this, applyBackgroundColor);
    }

    public function getNextGroupNamePath() : String
    {
        return GROUPS_NAME_PATH + "/" + Uuid.newUuid();
    }

	static function log(v:Dynamic)
    {
        nanofl.engine.Log.console.namedLog("IdeLibrary", v);
    }
}

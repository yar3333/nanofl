package nanofl.engine;

import js.Browser;
import datatools.MapTools;
import js.lib.Promise;
import datatools.ArrayRO;
import nanofl.engine.elements.Instance;
import nanofl.engine.Font;
import datatools.ArrayTools;
import nanofl.engine.ILibraryItem;
import nanofl.engine.elements.TextElement;
import nanofl.engine.libraryitems.*;
import stdlib.Debug;
using StringTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
#if ide @:rtti #end
class Library
{
	public static var SCENE_NAME_PATH(default, never) = "scene";
	
	@:allow(nanofl.ide.editor.EditorLibrary.changeDir)
	public var libraryDir(default, null) : String;
	
    var items = new Map<String, ILibraryItem>();
	
    function new(libraryDir:String, ?items:ArrayRO<ILibraryItem>)
    {
        this.libraryDir = libraryDir;
        if (items != null) for (item in items) addItem(item);
    }

	public function addItem<TLibraryItem:ILibraryItem>(item:TLibraryItem) : Void
    {
        item.setLibrary(cast this);
        items.set(item.namePath, item);
        ensureFolderOfItemExists(item.namePath);
    }

	public function removeItem(namePath:String)
    {
        for (item in getItemsInFolder(namePath)) removeItemInner(item.namePath);
        removeItemInner(namePath);
    }

	function removeItemInner(namePath:String)
    {
        var itemToRemove = getItem(namePath);
        
        items.remove(namePath);
        
        for (item in items)
        {
            if (Std.isOfType(item, MovieClipItem))
            {
                final mcItem : MovieClipItem = cast item;

                for (instance in MovieClipItemTools.getInstances(mcItem).filter(x -> x.namePath == namePath))
                {
                    instance.parent.removeElement(instance);
                }

                if (mcItem.relatedSound == itemToRemove.namePath)
                {
                    mcItem.relatedSound = "";
                }
            }
        }
    }    

	public function getItem(namePath:String) : ILibraryItem
    {
        Debug.assert(namePath != null);
        Debug.assert(namePath != "");
        var r = items.get(namePath);
        if (r != null) return r;
        Browser.console.warn("Symbol '" + namePath + "' is not found.");
        return createItemOnItemNotFound(namePath);
    }

	public function getItems(?includeScene:Bool) : Array<ILibraryItem>
    {
        var namePaths = items.keys().array();
        if (!includeScene) namePaths = namePaths.filter(namePath -> namePath != SCENE_NAME_PATH);
        namePaths.sort((a, b) -> Reflect.compare(a.toLowerCase(), b.toLowerCase()));
        return namePaths.map(namePath -> items.get(namePath));
    }
        
    public function hasItem(namePath:String) : Bool
    {
        return items.exists(namePath);
    }
    
    public function realUrl(url:String) : String
    {
        if (url.indexOf("//") >= 0) return url;
        return libraryDir + "/" + url;
    }

	public function preload() : Promise<{}>
    {
        var r = Promise.resolve();
        for (item in items)
        {
            r = r.then(_ -> item.preload());
        }
        return r;
    }

	public function getItemCount() : Int return items.count();

	function ensureFolderOfItemExists(namePath:String)
    {
        var parts = namePath.split("/");
        for (i in 1...parts.length)
        {
            var folder = parts.slice(0, i).join("/");
            if (!hasItem(folder)) addItem(new FolderItem(folder));
        }
    }    

	function createItemOnItemNotFound(namePath:String) : ILibraryItem
	{
		return MovieClipItem.createWithFrame(namePath, [ new TextElement("", 0, 0, false, true, [ new TextRun("Symbol '" + namePath + "' is not found.") ]) ], "temp");
	}
	
	public function getItemsInFolder(folderNamePath:String) : Array<ILibraryItem>
    {
        if (Std.is(items.get(folderNamePath), FolderItem))
        {
            return getItems().filter(x -> x.namePath.startsWith(folderNamePath + "/"));
        }
        return [];
    }	

	public function clone() : Library
	{
		return new Library(libraryDir, ArrayTools.clone(getItems(true)));
	}
	
	public function getSceneItem() : MovieClipItem
	{
		return cast(items.get(SCENE_NAME_PATH), MovieClipItem);
	}
	
	public function getSceneInstance() : Instance
	{
		return getSceneItem().newInstance();
	}
	
	public function getInstancableItems() : Array<InstancableItem>
	{
		return getItems(true).filterByType(InstancableItem);
	}
	
	public function getBitmaps() : Array<BitmapItem>
	{
		return getItems().filterByType(BitmapItem);
	}
	
	public function getMeshes() : Array<MeshItem>
	{
		return getItems().filterByType(MeshItem);
	}
	
	public function getSounds() : Array<SoundItem>
	{
		return getItems().filterByType(SoundItem);
	}
	
	public function getFonts() : Array<Font>
	{
		var fontItems = getItems().filterByType(FontItem);
		var fonts = fontItems.map(item -> item.toFont());
		fonts.sort((a, b) -> Reflect.compare(a.family, b.family));
		return fonts;
	}

	public function equ(library:Library) : Bool
    {
        return MapTools.equ(items, library.items);
    }
    
    #if (!ide || display)
    // public static function load(urlToLibraryJson:String) : Promise<Library>
    // {
    //     var n = urlToLibraryJson.lastIndexOf("/");
    //     var baseLibraryUrl = (n > 0 ? urlToLibraryJson.substring(0, n + 1) : "") + "library";
        
    //     var library = new Library(urlToLibraryJson);

    //     var p : Promise<Void>;
    //     p = Loader.file(urlToLibraryJson).then(jsonStr ->
    //     {
    //         var jsonObj = jsonmod.Json.parse(jsonStr);
    //         var namePaths = Reflect.fields(jsonObj);

    //         for (namePath in namePaths)
    //         {
    //             p = p.then(_ ->
    //             {
    //                 var itemType = Reflect.field(jsonObj, namePath);
    //                 return switch (itemType)
    //                 {
    //                     case "movieclip": MovieClipItem.loadFromJson(namePath, baseLibraryUrl);
    //                     case _: null;
    //                 }
    //             })
    //             .then((item:ILibraryItem) ->
    //             {
    //                 if (item != null) library.addItem(item);
    //             });
    //         }
    //     });

    //     return p.then(_ -> library);
    // }
    #end

    #if !ide
    public static function loadFromJson(libraryDir:String, obj:Dynamic) : Library
    {
        var items = Reflect.fields(obj).map(namePath -> LibraryItem.loadFromJson(namePath, Reflect.field(obj, namePath)));
        return new Library(libraryDir, items);
    }
    #end
}	

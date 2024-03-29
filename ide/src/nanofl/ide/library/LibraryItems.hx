package nanofl.ide.library;

import haxe.io.Path;
import js.lib.Promise;
import stdlib.Debug;
import stdlib.Std;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import nanofl.engine.libraryitems.InstancableItem;
import nanofl.ide.plugins.PluginApi;
import nanofl.ide.libraryitems.MeshItem;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.ide.libraryitems.FontItem;
import nanofl.ide.libraryitems.BitmapItem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.libraryitems.FolderItem;
import nanofl.ide.draganddrop.AllowedDropEffect;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.plugins.LoaderPlugins;
import nanofl.ide.preferences.Preferences;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using StringTools;

class LibraryItems
{
	public static function load(preferences:Preferences, libraryDir:String, relativeFilePaths:Array<String>) : Promise<Array<IIdeLibraryItem>>
	{
		//log("LibraryItems load: ");
		
		var loaders = LoaderPlugins.plugins.sorted((x, y) -> y.priority - x.priority);
		
		var cachedFiles = new Map<String, CachedFile>();
		for (relativeFilePath in relativeFilePaths)
		{
			cachedFiles.set(relativeFilePath, new CachedFile(libraryDir, relativeFilePath));
		}
		
		//for (file in cachedFiles.keys())
		//{
		//	log('$file => ' + cachedFiles.get(file).path);
		//}
		
		var p = Promise.resolve(new Array<IIdeLibraryItem>());
		
        final pluginApi = new PluginApi();
		
        for (loader in loaders)
		{
			p = p.then(function(r:Array<IIdeLibraryItem>) : Promise<Array<IIdeLibraryItem>>
			{
				log("Loader " + loader.name);
				final params = loader.getParams(preferences.storage);
				return loader.load(pluginApi, params, libraryDir, cachedFiles).then((items:Array<IIdeLibraryItem>) ->
				{
					for (item in items)
                    {
                        Debug.assert(item != null, "Loader " + loader.name + " returns null.");
                        r.push(item);
                    }
					return r;
				});
			});
		};
		
		p = p.then(function(r:Array<IIdeLibraryItem>) : Array<IIdeLibraryItem>
		{
			if (!cachedFiles.empty())
			{
				log("Skipped files:\n\t" + cachedFiles.keys().sorted().join("\n\t"));
			}
			return r;
		});
		
		return p;
	}
	
	public static function saveToXml(items:Array<IIdeLibraryItem>, out:XmlBuilder)
	{
		out.begin("libraryitems");
		for (item in items.filter(x -> !x.namePath.startsWith(IdeLibrary.GROUPS_NAME_PATH + "/")))
		{
			out.begin("item").attr("namePath", item.namePath);
			item.saveToXml(out);
			out.end();
		}
		out.end();
	}
	
	public static function loadFromXml(xml:HtmlNodeElement) : Array<IIdeLibraryItem>
	{
		return xml.find(">libraryitems>item")
			.map(node -> parseItem(node.getAttribute("namePath"), node.children[0]))
			.filter(items ->
			{
				if (items == null) log("Error parsing library item xml:\n\t" + xml.toString().replace("\n", "\n\t"));
				return items != null;
			})
            .flatten();
	}

    static function parseItem(namePath:String, itemNode:HtmlNodeElement) : Array<IIdeLibraryItem>
    {
        var movieClipItems = MovieClipItem.parse(namePath, itemNode);
        if (movieClipItems != null) return movieClipItems;
        
        var bitmapItem = BitmapItem.parse(namePath, itemNode);
        if (bitmapItem != null) return [ bitmapItem ];
		
		var meshItem = MeshItem.parse(namePath, itemNode);
		if (meshItem != null) return [ meshItem ];
        
        var fontItem = FontItem.parse(namePath, itemNode);
        if (fontItem != null) return [ fontItem ];
        
        var soundItem = SoundItem.parse(namePath, itemNode);
        if (soundItem != null) return [ soundItem ];
        
        var folderItem = FolderItem.parse(namePath, itemNode);
        if (folderItem != null) return [ folderItem ];
        
        return null;
    }    
	
	#if ide
	public static function getFiles(items:Array<IIdeLibraryItem>) : Array<String>
	{
		var r = []; for (item in items) r = r.concat(item.getLibraryFilePaths());
		
		var i = 0; while (i < r.length)
		{
			var j = 0; while (j < r.length)
			{
				if (i != j && (r[j] == r[i] || r[j].startsWith(r[i] + "/")))
				{
					r.splice(j, 1);
					if (i > j) i--;
				}
				else j++;
			}
			i++;
		}
		
		return r;
	}
	#end
	
	#if !test
	public static function drag(document:Document, item:IIdeLibraryItem, items:Array<IIdeLibraryItem>, out:XmlBuilder) : AllowedDropEffect
	{
		out.attr("documentID", document.id);
		
		out.attr("namePath", item.namePath);
		out.attr("icon", item.getIcon());
		out.attr("text", item.namePath);
		
		if (Std.isOfType(item, InstancableItem))
		{
			var obj = (cast item:InstancableItem).createDisplayObject(null);
			var bounds =  DisplayObjectTools.getInnerBounds(obj);
			out.attr("width",  bounds?.width ?? 0);
			out.attr("height", bounds?.height ?? 0);
		}
		
		LibraryItems.saveToXml(items, out);
		
		var files = LibraryItems.getFiles(items);
		if (files.length > 0)
		{
			out.begin("libraryfiles").attr("libraryDir", document.library.libraryDir);
			for (file in files)
			{
				out.begin("file").attr("path", file).end();
			}
			out.end();
		}
		
		return AllowedDropEffect.copyMove;
	}
	
	public static function drop(dropEffect:DropEffect, data:HtmlNodeElement, document:Document, folder:String) : Promise<Array<IIdeLibraryItem>>
	{
		Debug.assert(folder != null);
		
		var sourceDocumentID = data.getAttribute("documentID");
		
		log("LibraryItems.drop");
		
		if (document.id == sourceDocumentID)
		{
			log("\njust rename");
			
			if (folder != "") (cast document.library.getItem(folder) : FolderItem).opened = true;
			
			var namePaths = data.find(">libraryitems>item")
				.map(x -> x.getAttribute("namePath"))
				.filter(namePath ->
				{
					if (!document.library.hasItem(namePath))
					{
						log("IdeLibrary item not found: '" + namePath + "'.");
						return false;
					}
					return true;
				});
			
			final renames = [];
			for (namePath in getWithoutSubItems(namePaths))
			{
				final newNamePath = Path.join([ folder, Path.withoutDirectory(namePath) ]);
				if (namePath != newNamePath && document.library.canRenameItem(namePath, newNamePath))
				{
					renames.push({ oldNamePath:namePath, newNamePath:newNamePath });
				}
			}
			document.library.renameItems(renames);
			
			return Promise.resolve(renames.map(x -> document.library.getItem(x.newNamePath)));
		}
		else
		{
			final items = LibraryItems.loadFromXml(data);
			log("\titems: " + items.map(x -> x.namePath));
			
			document.undoQueue.beginTransaction({ libraryAddItems:true });
			
			document.library.addItems(items, false);
			
			final libraryFilesNodes = data.find(">libraryfiles");
			if (libraryFilesNodes.length > 0)
			{
				final libraryDir = libraryFilesNodes[0].getAttribute("libraryDir");
				final files = libraryFilesNodes[0].find(">file").map(x -> x.getAttribute("path"));
				document.library.copyFilesIntoLibrary(libraryDir, files);
                log("\tfiles copied into library");
                
                return document.reloadWoTransactionForced().then((e:{ added:Array<IIdeLibraryItem>, removed:Array<IIdeLibraryItem> }) ->
                {
                    log("\tdocument reloaded\n\t" + e.added.map(x -> x.namePath).join("\n\t"));
                    document.undoQueue.commitTransaction();
                    return items.concat(e.added);
                });
			}
			else
			{
				log("\tno files");
				document.undoQueue.commitTransaction();
				return Promise.resolve(items);
			}
		}
	}
	#end
	
	static function getWithoutSubItems(namePaths:Array<String>) : Array<String>
	{
		final r = [];
		
		for (namePath in namePaths)
		{
			var skip = false;
			
			var folder = namePath;
			while (folder.indexOf("/") > 0)
			{
				folder = Path.directory(folder);
				if (namePaths.indexOf(folder) >= 0)
				{
					skip = true;
					break;
				}
			}
			
			if (!skip) r.push(namePath);
		}
		
		return r;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}

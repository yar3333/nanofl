package nanofl.ide.library;

import js.lib.Promise;
import stdlib.Debug;
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import nanofl.ide.plugins.PluginApi;
import nanofl.ide.libraryitems.MeshItem;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.ide.libraryitems.FontItem;
import nanofl.ide.libraryitems.BitmapItem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.libraryitems.FolderItem;
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
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.trace("", Reflect.isFunction(v) ? v() : v);
	}
}

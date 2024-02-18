import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.SpriteItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
using Lambda;

class SpriteLoaderPlugin implements ILoaderPlugin
{
	public var name = "SpriteLoader";
	public var priority = 500;
	public var menuItemName = "Sprite";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        var r = new Array<IIdeLibraryItem>();
        
        for (file in files)
        {
            if (file.excluded) continue;
            
            if (Path.extension(file.path) == "json")
            {
                var namePath = Path.withoutExtension(file.path);
                if (!r.exists(function(item) return item.namePath == namePath))
                {
                    var json : { framerate:Int, images:Array<String>, frames:Array<Array<Int>> } = file.json;
                    if (json != null && json.frames != null && json.images != null)
                    {
                        r.push(new SpriteItem(namePath, json.frames.map(function(frame) return
                        {
                            image: json.images[frame[4]],
                            x: frame[0],
                            y: frame[1],
                            width: frame[2],
                            height: frame[3],
                            regX: cast frame[5],
                            regY: cast frame[6]
                        })));
                        
                        for (image in json.images)
                        {
                            var p = Path.join([ Path.directory(namePath), image ]);
                            if (files.exists(p)) files.get(p).exclude();
                        }
                        
                        file.exclude();
                    }
                }
            }
        }
        
        return Promise.resolve(r);
	}
}
import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
using Lambda;

class MovieClipLoaderPlugin implements ILoaderPlugin
{
	public var name = "MovieClipLoader";
	public var priority = 200;
	
	public var menuItemName = "MovieClip";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        var r = new Array<IIdeLibraryItem>();
        
        for (file in files)
        {
            if (file.excluded) continue;
            
            if ([ "json", "xml", "movieclip" ].indexOf(Path.extension(file.path)) >= 0)
            {
                var namePath = Path.withoutExtension(file.path);
                if (!r.exists(item -> item.namePath == namePath))
                {
                    if (file.xml != null)
                    {
                        var mc = MovieClipItem.parse(namePath, file.xml);
                        if (mc != null)
                        {
                            r.push(mc);
                            file.exclude();
                        }
                    }
                    else if (file.json != null)
                    {
                        var mc = MovieClipItem.parseJson(namePath, file.xml);
                        if (mc != null)
                        {
                            r.push(mc);
                            file.exclude();
                        }
                    }
                }
            }
        }
        
        return Promise.resolve(r);
	}
}
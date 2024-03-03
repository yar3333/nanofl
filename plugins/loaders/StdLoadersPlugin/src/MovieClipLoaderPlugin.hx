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

    public var extensions = [];
	
	public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        var r = new Array<IIdeLibraryItem>();
        
        for (file in files)
        {
            if (file == null) continue;
            
            if (Path.extension(file.relativePath).toLowerCase() == "xml")
            {
                var namePath = Path.withoutExtension(file.relativePath);
                if (!r.exists(item -> item.namePath == namePath))
                {
                    var mc = file.xml != null ? MovieClipItem.parse(namePath, file.xml) : null;
                    if (mc != null)
                    {
                        r.push(mc);
                        files.remove(file.relativePath);
                    }
                }
            }
        }
        
        return Promise.resolve(r);
	}
}
import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.FontItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
using Lambda;

class FontLoaderPlugin implements ILoaderPlugin
{
	public var name = "FontLoader";
	public var priority = 400;

	public var menuItemName = "Font";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
    
    public var extensions = [];
	
	public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : Promise<Array<IIdeLibraryItem>>
	{
        var r = new Array<IIdeLibraryItem>();
        
        for (file in files)
        {
            if (!files.exists(file.relativePath)) continue;
            
            if (Path.extension(file.relativePath) == "xml")
            {
                if (file.xml != null)
                {
                    var font = FontItem.parse(Path.withoutExtension(file.relativePath), file.xml);
                    if (font != null)
                    {
                        r.push(font);
                        files.remove(file.relativePath);
                    }
                }
            }
        }
        
        return Promise.resolve(r);
	}
}
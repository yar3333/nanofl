import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.BitmapItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
using Lambda;

class BitmapLoaderPlugin implements ILoaderPlugin
{
	static var extensions = [ "jpg", "jpeg", "png", "gif", "svg" ];
	
	public var name = "BitmapLoader";
	public var priority = 100;
	
	public var menuItemName = "Bitmap";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        var r = new Array<IIdeLibraryItem>();
        
        for (file in files)
        {
            if (file.excluded) continue;
            
            var ext = Path.extension(file.path);
            if (ext != null && extensions.indexOf(ext.toLowerCase()) >= 0)
            {
                var namePath = Path.withoutExtension(file.path);
                if (!r.exists(item -> item.namePath == namePath))
                {
                    var xmlFile = files.get(namePath + ".xml") ?? files.get(namePath + ".bitmap"); // ".bitmap" - obsolete
                    var item = xmlFile != null && xmlFile.xml != null && xmlFile.xml.name == "bitmap"
                            ? BitmapItem.parse(namePath, xmlFile.xml)
                            : new BitmapItem(namePath, ext);
                    xmlFile?.exclude();
                    r.push(item);
                }
                file.exclude();
            }
        }
        
        return Promise.resolve(r);
	}
}
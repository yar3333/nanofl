import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.BitmapItem;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
using Lambda;

class ImageLoaderPlugin implements ILoaderPlugin
{
	public var name = "ImageLoader";
	public var priority = 100;
	
	public var menuItemName = "Image";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
	
	public var extensions = [ "svg", "png", "jpg" ];
	
    public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        var r = new Array<IIdeLibraryItem>();
        
        for (file in files)
        {
            if (!files.exists(file.relativePath)) continue;
            
            var ext = Path.extension(file.relativePath);
            if (ext != null && extensions.indexOf(ext.toLowerCase()) >= 0)
            {
                var namePath = Path.withoutExtension(file.relativePath);
                if (!r.exists(item -> item.namePath == namePath))
                {
                    var xmlFile = files.get(namePath + ".xml");
                    var item = (xmlFile?.xml != null ? BitmapItem.parse(namePath, xmlFile.xml) : null) ?? new BitmapItem(namePath, ext);
                    files.remove(xmlFile?.relativePath);
                    r.push(item);
                }
                files.remove(file.relativePath);
            }
        }
        
        return Promise.resolve(r);
	}
}
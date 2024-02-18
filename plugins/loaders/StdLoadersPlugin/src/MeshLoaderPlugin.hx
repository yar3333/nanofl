import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.MeshItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;

class MeshLoaderPlugin implements ILoaderPlugin
{
	public var name = "MeshLoader";
	public var priority = 600;
	public var menuItemName = "Mesh";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : js.lib.Promise<Array<IIdeLibraryItem>>
	{
        var r = new Array<IIdeLibraryItem>();
        
        var extensions = [ "xml", "gltf" ];
        
        for (file in files)
        {
            if (file.excluded) continue;
            
            var ext = Path.extension(file.path);
            if (extensions.contains(ext))
            {
                var item = MeshItem.load(Path.withoutExtension(file.path), ext, files);
                if (item != null) r.push(item);
            }
        }
        
        return Promise.resolve(r);
	}
}
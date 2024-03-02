import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.MeshItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
using Lambda;

class MeshLoaderPlugin implements ILoaderPlugin
{
	public var name = "MeshLoader";
	public var priority = 600;

	public var menuItemName = "Mesh";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
    
    public var extensions = [ "gltf" ];
	
	public function new() {}
	
	public function load(api:PluginApi, params:Dynamic, baseDir:String, files:Map<String, CachedFile>) : Promise<Array<IIdeLibraryItem>>
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
                    var item = (xmlFile?.xml != null ? MeshItem.parse(namePath, xmlFile.xml) : null) ?? new MeshItem(namePath);
                    files.remove(xmlFile?.relativePath);
                    r.push(item);
                }
                files.remove(file.relativePath);
            }
        }
        
        return Promise.resolve(r);
	}
}
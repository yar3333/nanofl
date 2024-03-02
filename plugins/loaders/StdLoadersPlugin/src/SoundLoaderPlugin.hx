import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.libraryitems.SoundItem;
import nanofl.ide.filesystem.CachedFile;
import nanofl.ide.plugins.ILoaderPlugin;
using Lambda;

class SoundLoaderPlugin implements ILoaderPlugin
{
	static var extensions = [ "ogg", "mp3", "wav" ];
	
	public var name = "SoundLoader";
	public var priority = 300;
	
	public var menuItemName = "Sound";
	public var menuItemIcon = "";
	public var properties : Array<CustomProperty> = null;
	
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
                    var xmlFile = files.get(namePath + ".xml") ?? files.get(namePath + ".sound");   // ".sound" - obsolete
                    var item = xmlFile != null && xmlFile.xml != null && xmlFile.xml.name == "sound"
                                    ? SoundItem.parse(namePath, xmlFile.xml)
                                    : new SoundItem(namePath, ext);
                    files.remove(xmlFile?.relativePath);
                    r.push(item);
                }
                files.remove(file.relativePath);
            }
        }
        
        return Promise.resolve(r);
	}
}
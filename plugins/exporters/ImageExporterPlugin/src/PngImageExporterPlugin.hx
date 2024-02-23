import haxe.crypto.Base64;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.plugins.IExporterPlugin;

class PngImageExporterPlugin implements IExporterPlugin
{
	public var name = "PngImageExporter";
	
	public var menuItemName = "PNG Image (*.png)";
	public var menuItemIcon = "custom-icon-picture";
	public var fileFilterDescription = "PNG Image (*.png)";
	public var fileFilterExtensions = [ "png" ];
	public var fileDefaultExtension = "png";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function exportDocument(api:PluginApi, params:Dynamic, srcFilePath:String, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
        var sceneFramesIterator = library.getSceneFramesIterator(documentProperties, false);
        if (!sceneFramesIterator.hasNext()) return false;
        
        var ctx = sceneFramesIterator.next();
        
		var data = ctx.canvas.toDataURL("image/png").split(",")[1];
		api.fileSystem.saveBinary(destFilePath, Base64.decode(data));
        
		return true;
	}
}
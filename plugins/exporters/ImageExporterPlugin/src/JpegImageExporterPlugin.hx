import haxe.crypto.Base64;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.plugins.IExporterPlugin;

class JpegImageExporterPlugin implements IExporterPlugin
{
	public var name = "JpegImageExporter";
	
	public var menuItemName = "JPEG Image (*.jpg)";
	public var menuItemIcon = "custom-icon-picture";
	public var fileFilterDescription = "JPEG Image (*.jpg)";
	public var fileFilterExtensions = [ "jpg", "jpeg" ];
	public var fileDefaultExtension = "jpg";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function exportDocument(api:PluginApi, params:Dynamic, srcFilePath:String, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
        var sceneFramesIterator = library.getSceneFramesIterator(documentProperties, true);
        if (!sceneFramesIterator.hasNext()) return false;
        
        var ctx = sceneFramesIterator.next();
        
		var data = ctx.canvas.toDataURL("image/jpeg").split(",")[1];
		api.fileSystem.saveBinary(destFilePath, Base64.decode(data));
        
		return true;
	}
}
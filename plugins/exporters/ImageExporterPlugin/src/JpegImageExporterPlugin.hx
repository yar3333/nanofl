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
		ImageExporter.run("image/jpeg", api.fileSystem, destFilePath, documentProperties, library);
		return true;
	}
}
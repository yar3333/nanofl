import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.plugins.IExporterPlugin;

class PngImageSequenceExporterPlugin implements IExporterPlugin
{
	public var name = "PngImageSequenceExporter";
	
	public var menuItemName = "Sequence of PNG Images (*.png)";
	public var menuItemIcon = "custom-icon-film";
	public var fileFilterDescription = "PNG Images Sequence (*.png)";
	public var fileFilterExtensions = [ "png" ];
	public var fileDefaultExtension = "png";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function exportDocument(api:PluginApi, params:Dynamic, srcFilePath:String, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
		ImageSequenceExporter.run("image/png", api.fileSystem, destFilePath, documentProperties, library);
		return true;
	}
}
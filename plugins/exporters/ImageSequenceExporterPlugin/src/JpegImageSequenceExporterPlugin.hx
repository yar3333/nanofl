import nanofl.ide.plugins.ExporterArgs;
import js.lib.Promise;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.IExporterPlugin;

class JpegImageSequenceExporterPlugin implements IExporterPlugin
{
	public var name = "JpegImageSequenceExporter";
	
	public var menuItemName = "Sequence of JPEG Images (*.jpg)";
	public var menuItemIcon = "custom-icon-film";
	public var fileFilterDescription = "JPEG Images Sequence (*.jpg)";
	public var fileFilterExtensions = [ "jpg", "jpeg" ];
	public var fileDefaultExtension = "jpg";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
		return ImageSequenceExporter.run("image/jpeg", true, api.fileSystem, args.destFilePath, args.documentProperties, args.library);
	}
}
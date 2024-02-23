import js.lib.Promise;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.ExporterArgs;
import nanofl.ide.plugins.PluginApi;
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
	
	public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
		return ImageSequenceExporter.run("image/png", false, api.fileSystem, args.destFilePath, args.documentProperties, args.library);
	}
}
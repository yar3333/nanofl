import js.lib.Promise;
import haxe.crypto.Base64;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.PluginApi;
import nanofl.ide.plugins.IExporterPlugin;
import nanofl.ide.plugins.ExporterArgs;

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
	
	public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
        var sceneFramesIterator = args.library.getSceneFramesIterator(args.documentProperties, false);
        if (!sceneFramesIterator.hasNext()) return Promise.resolve(false);
        
        var ctx = sceneFramesIterator.next();
        
		var data = ctx.canvas.toDataURL("image/png").split(",")[1];
		api.fileSystem.saveBinary(args.destFilePath, Base64.decode(data));
        
		return Promise.resolve(true);
	}
}
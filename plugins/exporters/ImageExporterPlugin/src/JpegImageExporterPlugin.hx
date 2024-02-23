import js.lib.Promise;
import haxe.crypto.Base64;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.ExporterArgs;
import nanofl.ide.plugins.PluginApi;
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
	
	public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
        var sceneFramesIterator = args.library.getSceneFramesIterator(args.documentProperties, true);
        if (!sceneFramesIterator.hasNext()) return Promise.resolve(false);
        
        var ctx = sceneFramesIterator.next();
        
		var data = ctx.canvas.toDataURL("image/jpeg").split(",")[1];
		api.fileSystem.saveBinary(args.destFilePath, Base64.decode(data));
        
		return Promise.resolve(true);
	}
}
import haxe.crypto.Base64;
import haxe.io.Path;
import js.lib.Promise;
import nanofl.engine.CustomProperty;
import nanofl.engine.elements.Instance;
import nanofl.engine.movieclip.KeyFrame;
import nanofl.ide.plugins.ImporterArgs;
import nanofl.ide.plugins.PluginApi;
import nanofl.ide.plugins.IImporterPlugin;
import nanofl.ide.plugins.ImporterPlugins;

class GifImporterPlugin implements IImporterPlugin
{
	static function main() ImporterPlugins.register(new GifImporterPlugin());
	
	public var name = "GifImporter";
	
	public var menuItemName = "GIF (*.gif)";
	public var menuItemIcon = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAACxAAAAsQAa0jvXUAAAClSURBVDhPY2RLufqfgUjwdboaOwsLyx8g8z9Y4x8hLYgMHsDy7hqY/jZDnQOo+ScTmEcC4Mq4+QNEY2j8B3Q4COMDIFdiaGRihGB0APIODIMAyU6FARSNfzsRGMaH0cjiIADXCBJkLkdgdIAuTh2nwgCyk2AAp1MJAZxOBQmim4oPoCW5fwyMzBCz/v8DEsD4/A9MDIygeAXxoQCU/EhK5AjAwAAAHto/WjOGRAgAAAAASUVORK5CYII=)";
	public var fileFilterDescription = "GIF image files (*.svg)";
	public var fileFilterExtensions = [ "gif" ];

    public function new() {}
	
	public var properties : Array<CustomProperty> = [];
	
	public function importDocument(api:PluginApi, args:ImporterArgs) : Promise<Bool>
	{
        final scene = args.library.addSceneWithFrame();
        final layer = scene.layers[0];
        layer.keyFrames.splice(0, layer.keyFrames.length);

        var n = 0;
        return VideoImporter.run(api.mediaUtils, api.processManager, api.folders, args.srcFilePath, canvas ->
        {
		    if (n == 0)
		    {
                args.documentProperties.width = canvas.width;
		        args.documentProperties.height = canvas.height;
            }
            
            api.fileSystem.saveBinary(args.library.libraryDir + "/Frame " + n + ".png", Base64.decode(canvas.toDataURL("image/png").split(",")[1]));
            layer.addKeyFrame(new KeyFrame(null, 1, null, [ new Instance("Frame " + n) ]));
            n++;
        })
        .then(success ->
        {
            return success ? args.library.loadItems().then(_ -> true) : Promise.resolve(false);
        });
	}

    public function getPublishDirectoryBasePath(originalPath:String) : String
    {
        return Path.withoutExtension(originalPath);
    }
}

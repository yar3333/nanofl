import js.lib.Promise;
import nanofl.ide.plugins.ExporterArgs;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.IExporterPlugin;

// http://underpop.online.fr/f/ffmpeg/ffmpeg-all.html.gz
// https://ffmpeg.org/ffmpeg-formats.html
// ffmpeg -f rawvideo -pixel_format rgb24 -video_size 1920x1080 -framerate 10 -i pipe:0 result.webm

class GifVideoExporterPlugin implements IExporterPlugin
{
	public var name = "GifVideoExporter";
	
	public var menuItemName = "GIF image (*.gif)";
	public var menuItemIcon = "custom-icon-film";
	public var fileFilterDescription = "GIF image (*.gif)";
	public var fileFilterExtensions = [ "gif" ];
	public var fileDefaultExtension = "gif";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
		return VideoExporter.run
        (
            api.fileSystem,
            api.processManager,
            api.folders,
            args.destFilePath,
            args.documentProperties,
            args.library,
            []
        );
	}
}
import js.lib.Promise;
import nanofl.ide.plugins.ExporterArgs;
import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.IExporterPlugin;

// http://underpop.online.fr/f/ffmpeg/ffmpeg-all.html.gz
// https://ffmpeg.org/ffmpeg-formats.html
// ffmpeg -f rawvideo -pixel_format rgb24 -video_size 1920x1080 -framerate 10 -i pipe:0 result.mp4

class Mp4VideoExporterPlugin implements IExporterPlugin
{
	public var name = "Mp4VideoExporter";
	
	public var menuItemName = "MP4 Video (*.mp4)";
	public var menuItemIcon = "custom-icon-film";
	public var fileFilterDescription = "MP4 Video (*.mp4)";
	public var fileFilterExtensions = [ "mp4" ];
	public var fileDefaultExtension = "mp4";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
		return VideoExporter.run(api.fileSystem, api.processManager, api.folders, args.destFilePath, args.documentProperties, args.library/*, "libx264"*/);
	}
}
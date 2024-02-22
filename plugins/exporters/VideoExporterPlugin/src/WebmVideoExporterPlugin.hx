import nanofl.ide.plugins.PluginApi;
import nanofl.engine.CustomProperty;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
import nanofl.ide.plugins.IExporterPlugin;

// http://underpop.online.fr/f/ffmpeg/ffmpeg-all.html.gz
// https://ffmpeg.org/ffmpeg-formats.html
// ffmpeg -f rawvideo -pixel_format rgb24 -video_size 1920x1080 -framerate 10 -i pipe:0 result.mp4

class WebmVideoExporterPlugin implements IExporterPlugin
{
	public var name = "Mp4VideoExporter";
	
	public var menuItemName = "MP4 Video (*.mp4)";
	public var menuItemIcon = "custom-icon-film";
	public var fileFilterDescription = "MP4 Video (*.mp4)";
	public var fileFilterExtensions = [ "mp4" ];
	public var fileDefaultExtension = "mp4";
	public var properties : Array<CustomProperty> = null;
	
	public function new() {}
	
	public function exportDocument(api:PluginApi, params:Dynamic, srcFilePath:String, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
		VideoExporter.run(api.fileSystem, api.processManager, api.folders, destFilePath, documentProperties, library);
		return true;
	}
}
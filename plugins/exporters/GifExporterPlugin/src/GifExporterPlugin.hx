import haxe.io.Path;
import js.Browser;
import js.lib.Uint8Array;
import js.lib.Promise;
import js.html.ImageData;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.ide.plugins.ExporterArgs;
import nanofl.ide.plugins.PluginApi;
import nanofl.ide.plugins.IExporterPlugin;
using StringTools;

class GifExporterPlugin implements IExporterPlugin
{
	static function main() 
	{
		ExporterPlugins.register(new GifExporterPlugin());
	}
	
	public var name = "GifExporter";
	
	public var menuItemName = "GIF image (*.gif)";
	public var menuItemIcon = "custom-icon-film";
	public var fileFilterDescription = "GIF image (*.gif)";
	public var fileFilterExtensions = [ "gif" ];
	public var fileDefaultExtension = "gif";
	
    public var properties : Array<CustomProperty> =
	[
		//{ type:"bool", name:"myName", label:"Short text", defaultValue:true },
		//{ type:"file", name:"myName", label:"Short text", description:"Long text", defaultValue:"", fileFilters:[ { description:"Executable files (*.exe)", extensions:[ "exe" ] } ] },

        { type:"float", name:"framerate", label:"Framerate", description:"Set to 0 to use document framerate.", defaultValue:0.0, units:"fps", minValue:0, maxValue:120 },
        
        { type:"info", label:"Select dithering mode. See <a href='https://ffmpeg.org/ffmpeg-filters.html#paletteuse'>ffmpeg-filters#paletteuse</a>." },
		{
            type : "list",
            name : "dither",
            label : "Dither",
            description : "",
            defaultValue : "sierra2_4a",
            values : [ "bayer","heckbert", "floyd_steinberg", "sierra2", "sierra2_4a", "sierra3", "burkes", "atkinson", "none" ]
        },
	];

	public function new() {}
	
    public function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>
	{
        if (api.fileSystem.exists(args.destFilePath)) api.fileSystem.deleteFile(args.destFilePath);
        
        final srcFramerate = args.documentProperties.framerate;
        final destFramerate = args.params.framerate == 0 || Path.extension(args.originalFilePath ?? "").toLowerCase() == "gif" 
                        ? args.documentProperties.framerate
                        : args.params.framerate;
        final width = args.documentProperties.width;
        final height = args.documentProperties.height;

        final dataOut = new Uint8Array(width * height * 3); // RGB

        final totalFrames = args.library.getSceneItem().getTotalFrames();
        final sceneFramesIterator = args.library.getSceneFramesIterator(args.documentProperties, true);

        // https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality
        // ffmpeg -ss 30 -t 3s -i cat.mp4 -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 output.gif
        // ffmpeg -ss 30 -t 3s -i cat.mp4 -vf "split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse=dither=none" -loop 0 output.gif
        final ffmpegArgs =
        [
            "-f", "rawvideo",
            "-pixel_format", "rgb24",
            "-video_size", width + "x" + height,
            "-framerate", srcFramerate + "",
            "-i", "pipe:0",
            "-vf", (destFramerate != srcFramerate ? "fps=" + destFramerate + "," : "") + "split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse=dither=" + args.params.dither,
            args.destFilePath
        ];

        Browser.console.log("FFmpeg: ", ffmpegArgs);

        var frameNum = 0;
        try
        {
            return api.processManager.runPipedStdIn(api.folders.tools + "/ffmpeg.exe", ffmpegArgs, null, null, process ->
            {
                if (!sceneFramesIterator.hasNext() || args.wantToCancel) return Promise.resolve(null);
                
                frameNum++;
                args.setProgressPercent(Math.round(frameNum * 100 / totalFrames));
                
                return sceneFramesIterator.next().then(ctx ->
                {
                    imageDataToRgbArray(ctx.getImageData(0, 0, width, height), dataOut);
                    return dataOut.buffer;
                });
            })
            .then(r -> r.code == 0);
        }
        catch (e)
        {
            Browser.console.error(e);
            return Promise.resolve(false);
        }
	}

    static function imageDataToRgbArray(imageData:ImageData, outBuffer:Uint8Array) : Void
    {
        final pixIn = imageData.data;
        
        var pIn = 0;
        var pOut = 0;
        
        for (_ in 0...(imageData.width * imageData.height))
        {
            outBuffer[pOut++] = pixIn[pIn++]; // R
            outBuffer[pOut++] = pixIn[pIn++]; // G
            outBuffer[pOut++] = pixIn[pIn++]; // B
            pIn++; // skip A
        }
    }    
}

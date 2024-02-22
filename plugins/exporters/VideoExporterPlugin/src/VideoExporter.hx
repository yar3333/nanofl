import js.lib.Promise;
import js.Browser;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.ProcessManager;
import js.html.CanvasElement;
import nanofl.MovieClip;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
using StringTools;

// http://underpop.online.fr/f/ffmpeg/ffmpeg-all.html.gz
// https://ffmpeg.org/ffmpeg-formats.html
// ffmpeg -f rawvideo -pixel_format rgb24 -video_size 1920x1080 -framerate 10 -i pipe:0 result.mp4

class VideoExporter
{
	public static function run(processManager:ProcessManager, folders:Folders, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Promise<Bool>
	{
        final args =
        [
            "-f", "rawvideo",
            "-pixel_format", "rgb24",
            "-video_size", documentProperties.width + "x" + documentProperties.height,
            "-framerate", documentProperties.framerate + "",
            "-i", "pipe:0",
            destFilePath
        ];
            
        var canvas : CanvasElement = cast js.Browser.document.createElement("canvas");
        canvas.width = documentProperties.width;
        canvas.height = documentProperties.height;
        
        var ctx = canvas.getContext2d({ willReadFrequently:true });

        var totalFrames = library.getSceneItem().getTotalFrames();
        var frameNum = 0;

        try
        {
            return processManager.runPipedStdIn(folders.tools + "/ffmpeg.exe", args, null, null, () ->
            {
                var scene = new MovieClip(library.getSceneItem(), frameNum, null);
                
                ctx.fillStyle = documentProperties.backgroundColor;
                ctx.fillRect(0, 0, documentProperties.width, documentProperties.height);
                scene.draw(ctx);
                
                return ctx.getImageData(0, 0, canvas.width, canvas.height).data.buffer;
            })
            .then(r ->
            {
                return r.code == 0;
            });
        }
        catch (e)
        {
            Browser.console.error(e);
            return Promise.resolve(false);
        }
	}
}
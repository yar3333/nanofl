import nanofl.ide.sys.FileSystem;
import js.lib.Uint8Array;
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
	public static function run(fileSystem:FileSystem, processManager:ProcessManager, folders:Folders, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Promise<Bool>
	{
        if (fileSystem.exists(destFilePath)) fileSystem.deleteFile(destFilePath);

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
        
        var totalFrames = library.getSceneItem().getTotalFrames();
        var frameNum = 0;

        final dataOut = new Uint8Array(canvas.width * canvas.height * 3); // RGB

        final stage = new nanofl.Stage(canvas);
        var scene : nanofl.MovieClip = cast library.getSceneInstance().createDisplayObject(null);
        stage.addChild(scene);

        var backColor = hexToRgb(documentProperties.backgroundColor);
        var ctx = canvas.getContext2d({ willReadFrequently:true });

        try
        {
            return processManager.runPipedStdIn(folders.tools + "/ffmpeg.exe", args, null, null, () ->
            {
                if (frameNum >= totalFrames) return null;
                
                stage.update();       
                
                final dataIn = ctx.getImageData(0, 0, canvas.width, canvas.height).data;
                var pIn = 0;
                var pOut = 0;
                var i = 0; while (i < canvas.height)
                {
                    var j = 0; while (j < canvas.width)
                    {
                        final r = dataIn[pIn++];
                        final g = dataIn[pIn++];
                        final b = dataIn[pIn++];
                        final a = dataIn[pIn++];
                        dataOut[pOut++] = applyAlpha(r, a, backColor.r);
                        dataOut[pOut++] = applyAlpha(g, a, backColor.g);
                        dataOut[pOut++] = applyAlpha(b, a, backColor.b);
                        j++;
                    }
                    i++;
                }

                frameNum++;

                if (frameNum < totalFrames) scene.advance();

                return dataOut.buffer;
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

    static inline function applyAlpha(fore:Int, a:Int, back:Int) : Int
    {
        var fa = a / 255.0;
        return Math.round((1 - fa) * back + fa * fore);
    }

    static function hexToRgb(hex) : { r:Int, g:Int, b:Int }
    {
        var re = ~/^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i;
        var result = re.match(hex);
        return result ? {
          r: cast js.Lib.parseInt(re.matched(1), 16),
          g: cast js.Lib.parseInt(re.matched(2), 16),
          b: cast js.Lib.parseInt(re.matched(3), 16),
        } : null;
    }
}
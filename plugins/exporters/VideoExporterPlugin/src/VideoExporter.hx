import js.Browser;
import js.lib.Uint8Array;
import js.lib.Promise;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.ProcessManager;
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

        final videoArgs =
        [
            "-f", "rawvideo",
            "-pixel_format", "rgb24",
            "-video_size", documentProperties.width + "x" + documentProperties.height,
            "-framerate", documentProperties.framerate + "",
            "-i", "pipe:0",
        ];

        final audioTracks = AudioHelper.getSceneTracks(documentProperties.framerate, library);
        final audioArgs = AudioHelper.getFFmpegArgsForMixTracks(audioTracks, 1);
            
        final dataOut = new Uint8Array(documentProperties.width * documentProperties.height * 3); // RGB

        var sceneFramesIterator = library.getSceneFramesIterator(documentProperties, true);

        final args = videoArgs.concat(audioArgs).concat(["-map", "0:v", destFilePath]);

        Browser.console.log("FFmpeg: ", args);

        try
        {
            return processManager.runPipedStdIn(folders.tools + "/ffmpeg.exe", args, null, null, () ->
            {
                if (!sceneFramesIterator.hasNext()) return null;
                
                var ctx = sceneFramesIterator.next();
                final dataIn = ctx.getImageData(0, 0, documentProperties.width, documentProperties.height).data;
                var pIn = 0;
                var pOut = 0;
                var i = 0; while (i < documentProperties.height)
                {
                    var j = 0; while (j < documentProperties.width)
                    {
                        final r = dataIn[pIn++];
                        final g = dataIn[pIn++];
                        final b = dataIn[pIn++];
                        final a = dataIn[pIn++];
                        dataOut[pOut++] = r;
                        dataOut[pOut++] = g;
                        dataOut[pOut++] = b;
                        j++;
                    }
                    i++;
                }

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
}
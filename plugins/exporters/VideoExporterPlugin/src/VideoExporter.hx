import js.html.ImageData;
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
                if (!sceneFramesIterator.hasNext()) return Promise.resolve(null);
                
                return sceneFramesIterator.next().then(ctx ->
                {
                    imageDataToRgbArray(ctx.getImageData(0, 0, documentProperties.width, documentProperties.height), dataOut);
                    return dataOut.buffer;
                });
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

    static function imageDataToRgbArray(imageData:ImageData, outBuffer:Uint8Array) : Void
    {
        final pixIn = imageData.data;
        var pIn = 0;
        var pOut = 0;
        for (i in 0...imageData.height)
        {
            for (j in 0...imageData.width)
            {
                final r = pixIn[pIn++];
                final g = pixIn[pIn++];
                final b = pixIn[pIn++];
                final a = pixIn[pIn++];
                outBuffer[pOut++] = r;
                outBuffer[pOut++] = g;
                outBuffer[pOut++] = b;
            }
        }
    }
}
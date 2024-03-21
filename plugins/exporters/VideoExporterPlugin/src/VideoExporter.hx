import nanofl.ide.plugins.ExporterArgs;
import nanofl.ide.plugins.PluginApi;
import js.html.ImageData;
import js.Browser;
import js.lib.Uint8Array;
import js.lib.Promise;
using StringTools;

// http://underpop.online.fr/f/ffmpeg/ffmpeg-all.html.gz
// https://ffmpeg.org/ffmpeg-formats.html
// ffmpeg -f rawvideo -pixel_format rgb24 -video_size 1920x1080 -framerate 10 -i pipe:0 result.mp4

class VideoExporter
{
	public static function run(api:PluginApi, args:ExporterArgs, ffmpegQualityOptions:Array<String>) : Promise<Bool>
	{
        if (api.fileSystem.exists(args.destFilePath)) api.fileSystem.deleteFile(args.destFilePath);

        final videoArgs =
        [
            "-f", "rawvideo",
            "-pixel_format", "rgb24",
            "-video_size", args.documentProperties.width + "x" + args.documentProperties.height,
            "-framerate", args.documentProperties.framerate + "",
            "-i", "pipe:0",
        ];

        final audioTracks = AudioHelper.getSceneTracks(args.documentProperties.framerate, args.library);
        final audioArgs = AudioHelper.getFFmpegArgsForMixTracks(audioTracks, 1);
            
        final dataOut = new Uint8Array(args.documentProperties.width * args.documentProperties.height * 3); // RGB

        final totalFrames = args.library.getSceneItem().getTotalFrames();
        final sceneFramesIterator = args.library.getSceneFramesIterator(args.documentProperties, true);

        final ffmpegArgs = videoArgs
                    .concat(audioArgs)
                    .concat([ "-map", "0:v" ])
                    .concat(ffmpegQualityOptions)
                    .concat([ args.destFilePath ]);

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
                    imageDataToRgbArray(ctx.getImageData(0, 0, args.documentProperties.width, args.documentProperties.height), dataOut);
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
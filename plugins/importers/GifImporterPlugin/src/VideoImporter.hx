import js.Browser;
import js.html.CanvasElement;
import js.html.ImageData;
import js.lib.Uint8Array;
import js.lib.Promise;
import nanofl.ide.sys.VideoUtils;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.ProcessManager;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.DocumentProperties;
using StringTools;
using Lambda;

// http://underpop.online.fr/f/ffmpeg/ffmpeg-all.html.gz
// https://ffmpeg.org/ffmpeg-formats.html
// ffmpeg -f rawvideo -pixel_format rgb24 -video_size 1920x1080 -framerate 10 -i pipe:0 result.mp4

class VideoImporter
{
	public static function run(videoUtils:VideoUtils, processManager:ProcessManager, folders:Folders, srcFilePath:String, processFrame:CanvasElement->Void) : Promise<Bool>
	{
        final fileInfo = videoUtils.getFileInfo(srcFilePath);
        final videoInfo = fileInfo?.streams?.find(x -> x.type == "video");

        if (videoInfo == null)
        {
            Browser.console.warn("VideoImporter.run: video stream not found.");
            return Promise.resolve(false);
        }
        
        // ffmpeg -i 2222.gif -f rawvideo -pix_fmt rgb24 pipe:1
        final args =
        [
            "-i", srcFilePath,
            "-f", "rawvideo",
            "-pixel_format", "rgb24",
            "pipe:1",
        ];

        Browser.console.log("FFmpeg: ", args);

        final width = videoInfo.videoWidth;
        final height = videoInfo.videoHeight;
        final chunkSize = width * height * 3;

        try
        {
            return processManager.runPipedStdOut(folders.tools + "/ffmpeg.exe", args, null, null, null, chunkSize, buffer ->
            {
                final view = new Uint8Array(buffer);
                
                final canvas = Browser.document.createCanvasElement();
                canvas.width = width;
                canvas.height = height;
                final imageData = canvas.getContext2d().getImageData(0,0,width, height).data;

                var pView = 0;
                var pImg = 0;
                for (i in 0...(width * height))
                {
                    imageData[pImg++] = view[pView++]; // R
                    imageData[pImg++] = view[pView++]; // G
                    imageData[pImg++] = view[pView++]; // B
                    imageData[pImg++] = 255; // A
                }

                processFrame(canvas);
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
        
        for (_ in 0...(imageData.width * imageData.height))
        {
            outBuffer[pOut++] = pixIn[pIn++]; // R
            outBuffer[pOut++] = pixIn[pIn++]; // G
            outBuffer[pOut++] = pixIn[pIn++]; // B
            pIn++; // skip A
        }
    }
}
package nanofl.ide.displayobjects;

import js.Browser;
import js.lib.Error;
import js.lib.Map;
import js.lib.Promise;
import js.html.CanvasElement;
import js.html.VideoElement;
import easeljs.utils.VideoBuffer;
using stdlib.Lambda;

class VideoCache
{
    static final MAX_IMAGES_PER_VIDEO = 100;

    static final cache = new Map<String, Array<{ position:Float, canvas:CanvasElement }>>();

    public static function getImageAsync(videoSrc:String, position:Float) : Promise<CanvasElement>
    {
        if (position == 0) position = 0.0001;

        final canvasFromCache = getFromCache(videoSrc, position);
        if (canvasFromCache != null) return Promise.resolve(canvasFromCache);

        return loadVideo(videoSrc, position).then(video ->
        {
            final r = (new VideoBuffer(video)).getImage();
            saveToCache(videoSrc, position, r);
            return r;
        });
    }

    static function getFromCache(videoSrc:String, position:Float) : CanvasElement
    {
        final frames = cache.get(videoSrc);
        if (frames != null)
        {
            final r = frames.find(x -> x.position > position - 0.0002 && x.position < position + 0.0002);
            if (r != null)
            {
                //log("VideoCache: hit");
                return r.canvas;
            }
        }
        //log("VideoCache: miss");
        return null;
    }

    static function saveToCache(videoSrc:String, position:Float, canvas:CanvasElement) : Void
    {
        final frames = cache.get(videoSrc);
        if (frames != null)
        {
            if (frames.exists(x -> x.position > position - 0.0002 && x.position < position + 0.0002)) return;
            frames.push({ position:position, canvas:canvas });
            if (frames.length > MAX_IMAGES_PER_VIDEO) frames.shift();
        }
        else
        {
            cache.set(videoSrc, [ { position:position, canvas:canvas } ]);
        }
    }

	static function loadVideo(url:String, position:Float) : Promise<VideoElement>
	{
		return new Promise<VideoElement>((resolve, reject) ->
		{
			final video = Browser.document.createVideoElement();
            video.currentTime = position;

			video.addEventListener("canplaythrough", () -> resolve(video), { once:true });

			video.addEventListener("error", () ->
            {
				nanofl.engine.Log.console.error("Failed to load '" + url + "'.");
                log("ERROR: Failed to load '" + url + "'.");
				reject(new Error("Failed to load '" + url + "'."));
            });

			video.src = url;
		});
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.namedLog("VideoCache", v);
	}
}
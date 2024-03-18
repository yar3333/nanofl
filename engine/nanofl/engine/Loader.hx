package nanofl.engine;

import stdlib.Uuid;
import js.Browser;
import nanofl.engine.Log.console;
import js.lib.Error;
import js.lib.Promise;
import js.html.Image;
import js.html.ImageElement;
import js.html.VideoElement;
import js.html.XMLHttpRequest;
using stdlib.Lambda;
using StringTools;

class Loader
{
	public static function image(url:String) : Promise<ImageElement>
	{
		return new Promise<ImageElement>((resolve, reject) ->
		{
			var image = new Image();
			image.onload = _ ->
			{
				resolve(image);
			};
			image.onerror = _ ->
			{
				console.error("Failed to load '" + (url.startsWith("data:") ? "<DataUrl>" : url) + "'.");
				image.src = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACwAAAAAAQABAAACAkQBADs=";
				reject(new Error("Failed to load '" + (url.startsWith("data:") ? "<DataUrl>" : url) + "'."));
			};
			image.src = withAntiCacheSuffix(url);
		});
	}
	
	public static function file(url:String) : Promise<String>
	{
		return new Promise<String>((resolve, reject) ->
		{
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.responseType = js.html.XMLHttpRequestResponseType.TEXT;
			xmlhttp.onreadystatechange = () ->
			{
				if (xmlhttp.readyState == XMLHttpRequest.DONE)
				{
					if (xmlhttp.status == 200)
					{
						resolve(xmlhttp.responseText);
					}
					else
					{
						console.error(new Error("Failed to load '" + url + "': " + xmlhttp.status + " / " + xmlhttp.statusText + "."));
						reject(new Error("Failed to load '" + url + "': " + xmlhttp.status + " / " + xmlhttp.statusText + "."));
					}
				}
			};
			xmlhttp.open("GET", withAntiCacheSuffix(url), true);
			xmlhttp.send();
		});
	}

    public static function javaScript(url:String) : Promise<{}>
    {
        return new Promise<{}>((resolve, reject) -> 
        {
            final elem = Browser.document.createScriptElement();
            elem.type = "text/javascript";
            elem.async = true;
            elem.src = withAntiCacheSuffix(url);
            elem.addEventListener("load", _  ->
            {
                elem.remove();
                resolve(null);
            });
            elem.addEventListener("error", _ ->
            {
                elem.remove();
                console.error(new Error("Failed to load '" + url + "'."));
                reject(new Error("Failed to load '" + url + "'."));
            });
            Browser.document.head.appendChild(elem);
        });
    }

	public static function video(url:String) : Promise<VideoElement>
	{
		return new Promise<VideoElement>((resolve, reject) ->
		{
			var video = Browser.document.createVideoElement();
            video.currentTime = 0.001;

			video.addEventListener("loadeddata", () -> resolve(video), { once:true });

			video.addEventListener("error", () ->
            {
				console.error("Failed to load '" + url + "'.");
				reject(new Error("Failed to load '" + url + "'."));
            });

			video.src = url;
		});
	}
	
	public static function queued<T>(urls:Array<String>, load:String->Promise<T>) : Promise<Array<T>>
    {
        return Promise.all(urls.map(x -> load(x)));
    }

    static function withAntiCacheSuffix(url:String) : String
    {
        if (!url.startsWith("file://")) return url;
        return url + (url.indexOf("?") < 0 ? "?" : "&") + Uuid.newUuid();
    }
}
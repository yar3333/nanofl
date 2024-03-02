package nanofl.engine;

import js.html.VideoElement;
import js.Browser;
import js.lib.Error;
import js.lib.Promise;
import js.html.Image;
import js.html.ImageElement;
import js.html.XMLHttpRequest;
import nanofl.engine.Debug.console;
using stdlib.Lambda;

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
				console.error("Failed to load '" + url + "'.");
				image.src = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACwAAAAAAQABAAACAkQBADs=";
				reject(new Error("Failed to load '" + url + "'."));
			};
			image.src = url;
		});
	}
	
	public static function file(url:String) : Promise<String>
	{
		return new Promise<String>((resolve, reject) ->
		{
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.responseType = js.html.XMLHttpRequestResponseType.TEXT;
			xmlhttp.onreadystatechange = function()
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
			xmlhttp.open("GET", url, true);
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
            elem.src = url;
            elem.addEventListener("load", _  ->
            {
                elem.remove();
                resolve(null);
            });
            elem.addEventListener("error", e ->
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
			video.onloadedmetadata = _ ->
			{
				resolve(video);
			};
			video.onerror = _ ->
			{
				console.error("Failed to load '" + url + "'.");
				//image.src = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACwAAAAAAQABAAACAkQBADs=";
				reject(new Error("Failed to load '" + url + "'."));
			};
			video.src = url;
		});
	}
	
	public static function queued<T>(urls:Array<String>, load:String->Promise<T>) : Promise<Array<T>>
    {
        return Promise.all(urls.map(x -> load(x)));
    }
}
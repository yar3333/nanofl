package nanofl.engine;

import js.Browser;
import js.lib.Promise;
import js.html.Image;
import js.html.XMLHttpRequest;
import nanofl.engine.Debug.console;
using stdlib.Lambda;

class Loader
{
	public static function image(url:String) : Promise<Image>
	{
		return new Promise<Image>((resolve, reject) ->
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
				reject("Failed to load '" + url + "'.");
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
						console.error("Failed to load '" + url + "': " + xmlhttp.status + " / " + xmlhttp.statusText);
						reject("Failed to load '" + url + "': " + xmlhttp.status + " / " + xmlhttp.statusText);
					}
				}
			};
			xmlhttp.open("GET", url, true);
			xmlhttp.send();
		});
	}
	
	public static function queued<T>(urls:Array<String>, load:String->Promise<T>) : Promise<Array<T>>
	{
		return Promise.all(urls.map(x -> load(x)));
	}

    public static function loadJsScript(url:String) : Promise<{}>
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
                reject(e);
            });
            Browser.document.head.appendChild(elem);
        });
    }
}
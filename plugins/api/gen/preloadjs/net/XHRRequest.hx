package preloadjs.net;

/**
 * A preloader that loads items using XHR requests, usually XMLHttpRequest. However XDomainRequests will be used
 * for cross-domain requests if possible, and older versions of IE fall back on to ActiveX objects when necessary.
 * XHR requests load the content as text or binary data, provide progress and consistent completion events, and
 * can be canceled during load. Note that XHR is not supported in IE 6 or earlier, and is not recommended for
 * cross-domain loading.
 */
/**
	
	 * A preloader that loads items using XHR requests, usually XMLHttpRequest. However XDomainRequests will be used
	 * for cross-domain requests if possible, and older versions of IE fall back on to ActiveX objects when necessary.
	 * XHR requests load the content as text or binary data, provide progress and consistent completion events, and
	 * can be canceled during load. Note that XHR is not supported in IE 6 or earlier, and is not recommended for
	 * cross-domain loading.
	 
**/
@:native('createjs.XHRRequest') extern class XHRRequest extends preloadjs.net.AbstractRequest {
	function new(item:haxe.extern.EitherType<String, preloadjs.data.LoadItem>):Void;
	/**
		
			 * Look up the loaded result.
			 
	**/
	function getResult(?raw:Bool):Dynamic;
	/**
		
			 * Get all the response headers from the XmlHttpRequest.
			 * 
			 * <strong>From the docs:</strong> Return all the HTTP headers, excluding headers that are a case-insensitive match
			 * for Set-Cookie or Set-Cookie2, as a single string, with each header line separated by a U+000D CR U+000A LF pair,
			 * excluding the status line, and with each header name and header value separated by a U+003A COLON U+0020 SPACE
			 * pair.
			 
	**/
	function getAllResponseHeaders():String;
	/**
		
			 * Get a specific response header from the XmlHttpRequest.
			 * 
			 * <strong>From the docs:</strong> Returns the header field value from the response of which the field name matches
			 * header, unless the field name is Set-Cookie or Set-Cookie2.
			 
	**/
	function getResponseHeader(header:String):String;
}
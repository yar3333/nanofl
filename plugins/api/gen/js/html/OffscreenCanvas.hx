package js.html;

/**
 [MDN Reference](https://developer.mozilla.org/docs/Web/API/OffscreenCanvas)
 */
/**
	 [MDN Reference](https://developer.mozilla.org/docs/Web/API/OffscreenCanvas) 
**/
@:native("OffscreenCanvas") extern class OffscreenCanvas extends js.html.EventTarget {
	function new(width:Int, height:Int):Void;
	/**
		
		     * These attributes return the dimensions of the OffscreenCanvas object's bitmap.
		     *
		     * They can be set, to replace the bitmap with a new, transparent black bitmap of the specified dimensions (effectively resizing it).
		     *
		     * [MDN Reference](https://developer.mozilla.org/docs/Web/API/OffscreenCanvas/height)
		     
	**/
	var height : Int;
	var oncontextlost : (js.html.OffscreenCanvas, js.html.Event) -> Dynamic;
	var oncontextrestored : (js.html.OffscreenCanvas, js.html.Event) -> Dynamic;
	/**
		
		     * These attributes return the dimensions of the OffscreenCanvas object's bitmap.
		     *
		     * They can be set, to replace the bitmap with a new, transparent black bitmap of the specified dimensions (effectively resizing it).
		     *
		     * [MDN Reference](https://developer.mozilla.org/docs/Web/API/OffscreenCanvas/width)
		     
	**/
	var width : Int;
	/**
		
		     * Returns a promise that will fulfill with a new Blob object representing a file containing the image in the OffscreenCanvas object.
		     *
		     * The argument, if provided, is a dictionary that controls the encoding options of the image file to be created. The type field specifies the file format and has a default value of "image/png"; that type is also used if the requested type isn't supported. If the image format supports variable quality (such as "image/jpeg"), then the quality field is a number in the range 0.0 to 1.0 inclusive indicating the desired quality level for the resulting image.
		     *
		     * [MDN Reference](https://developer.mozilla.org/docs/Web/API/OffscreenCanvas/convertToBlob)
		     
	**/
	function convertToBlob(?options:js.html.ImageEncodeOptions):js.lib.Promise<js.html.Blob>;
	/**
		
		     * Returns an object that exposes an API for drawing on the OffscreenCanvas object. contextId specifies the desired API: "2d", "bitmaprenderer", "webgl", or "webgl2". options is handled by that API.
		     *
		     * This specification defines the "2d" context below, which is similar but distinct from the "2d" context that is created from a canvas element. The WebGL specifications define the "webgl" and "webgl2" contexts. [WEBGL]
		     *
		     * Returns null if the canvas has already been initialized with another context type (e.g., trying to get a "2d" context after getting a "webgl" context).
		     *
		     * [MDN Reference](https://developer.mozilla.org/docs/Web/API/OffscreenCanvas/getContext)
		     
	**/
	function getContext(contextId:js.html.webgl.OffscreenRenderingContextId, ?options:Dynamic):js.html.webgl.OffscreenRenderingContext;
	/**
		
		     * Returns a newly created ImageBitmap object with the image in the OffscreenCanvas object. The image in the OffscreenCanvas object is replaced with a new blank image.
		     *
		     * [MDN Reference](https://developer.mozilla.org/docs/Web/API/OffscreenCanvas/transferToImageBitmap)
		     
	**/
	function transferToImageBitmap():js.html.ImageBitmap;
	override function addEventListener(type:String, listener:js.html.EventListenerOrEventListenerObject, ?options:haxe.extern.EitherType<Bool, js.html.AddEventListenerOptions>):Void;
	override function removeEventListener(type:String, listener:js.html.EventListenerOrEventListenerObject, ?options:haxe.extern.EitherType<Bool, js.html.EventListenerOptions>):Void;
}
package easeljs.display;

/**
 * A Bitmap represents an Image, Canvas, or Video in the display list. A Bitmap can be instantiated using an existing
 * HTML element, or a string.
 *
 * <h4>Example</h4>
 *
 * 	var bitmap = new createjs.Bitmap("imagePath.jpg");
 *
 * <strong>Notes:</strong>
 * <ol>
 * 	<li>When using a video source that may loop or seek, use a {{#crossLink "VideoBuffer"}}{{/crossLink}} object to
 * 	 prevent blinking / flashing.
 * 	<li>When a string path or image tag that is not yet loaded is used, the stage may need to be redrawn before it
 * 	 will be displayed.</li>
 * 	<li>Bitmaps with an SVG source currently will not respect an alpha value other than 0 or 1. To get around this,
 * 	the Bitmap can be cached.</li>
 * 	<li>Bitmaps with an SVG source will taint the canvas with cross-origin data, which prevents interactivity. This
 * 	happens in all browsers except recent Firefox builds.</li>
 * 	<li>Images loaded cross-origin will throw cross-origin security errors when interacted with using a mouse, using
 * 	methods such as `getObjectUnderPoint`, or using filters, or caching. You can get around this by setting
 * 	`crossOrigin` flags on your images before passing them to EaselJS, eg: `img.crossOrigin="Anonymous";`</li>
 * </ol>
 */
/**
	
	 * A Bitmap represents an Image, Canvas, or Video in the display list. A Bitmap can be instantiated using an existing
	 * HTML element, or a string.
	 * 
	 * <h4>Example</h4>
	 * 
	 * 	var bitmap = new createjs.Bitmap("imagePath.jpg");
	 * 
	 * <strong>Notes:</strong>
	 * <ol>
	 * 	<li>When using a video source that may loop or seek, use a {{#crossLink "VideoBuffer"}}{{/crossLink}} object to
	 * 	 prevent blinking / flashing.
	 * 	<li>When a string path or image tag that is not yet loaded is used, the stage may need to be redrawn before it
	 * 	 will be displayed.</li>
	 * 	<li>Bitmaps with an SVG source currently will not respect an alpha value other than 0 or 1. To get around this,
	 * 	the Bitmap can be cached.</li>
	 * 	<li>Bitmaps with an SVG source will taint the canvas with cross-origin data, which prevents interactivity. This
	 * 	happens in all browsers except recent Firefox builds.</li>
	 * 	<li>Images loaded cross-origin will throw cross-origin security errors when interacted with using a mouse, using
	 * 	methods such as `getObjectUnderPoint`, or using filters, or caching. You can get around this by setting
	 * 	`crossOrigin` flags on your images before passing them to EaselJS, eg: `img.crossOrigin="Anonymous";`</li>
	 * </ol>
	 
**/
@:native('createjs.Bitmap') extern class Bitmap extends easeljs.display.DisplayObject {
	function new(imageOrUri:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.ImageElement, js.html.CanvasElement>>):Void;
	/**
		
			 * The source image to display. This can be a CanvasImageSource
			 * (image, video, canvas), an object with a `getImage` method that returns a CanvasImageSource, or a string URL to an image.
			 * If the latter, a new Image instance with the URL as its src will be used.
			 
	**/
	var image : haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.ImageElement, js.html.CanvasElement>>;
	/**
		
			 * Specifies an area of the source image to draw. If omitted, the whole image will be drawn.
			 * Notes:
			 * <ul>
			 *     <li>that video sources must have a width / height set to work correctly with `sourceRect`</li>
			 *     <li>Cached objects will ignore the `sourceRect` property</li>
			 * </ul>
			 
	**/
	var sourceRect : easeljs.geom.Rectangle;
	/**
		
			 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
			 * This does not account for whether it would be visible within the boundaries of the stage.
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function isVisible():Bool;
	/**
		
			 * Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
			 * Returns true if the draw was handled (useful for overriding functionality).
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	/**
		
			 * Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
			 * You should <b>not</b> cache Bitmap instances as it can degrade performance.
			 * 
			 * <strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
			 * To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
			 * method.
			 
	**/
	override function cache(x:Float, y:Float, width:Float, height:Float, ?scale:Float, ?options:Dynamic):Void;
	/**
		
			 * Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
			 * You should <b>not</b> cache Bitmap instances as it can degrade performance.
			 * 
			 * <strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
			 * To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
			 * method.
			 
	**/
	override function updateCache(compositeOperation:String):Void;
	/**
		
			 * Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
			 * You should <b>not</b> cache Bitmap instances as it can degrade performance.
			 * 
			 * <strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
			 * To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
			 * method.
			 
	**/
	override function uncache():Void;
	/**
		
			 * Returns a clone of the Bitmap instance.
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}
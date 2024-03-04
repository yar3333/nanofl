package easeljs.display;

typedef SpriteAnimationendEvent = {
	var name : String;
	var next : String;
	var target : Dynamic;
	var type : String;
};

typedef SpriteChangeEvent = {
	var target : Dynamic;
	var type : String;
};

/**
 * Displays a frame or sequence of frames (ie. an animation) from a SpriteSheet instance. A sprite sheet is a series of
 * images (usually animation frames) combined into a single image. For example, an animation consisting of 8 100x100
 * images could be combined into a 400x200 sprite sheet (4 frames across by 2 high). You can display individual frames,
 * play frames as an animation, and even sequence animations together.
 *
 * See the {{#crossLink "SpriteSheet"}}{{/crossLink}} class for more information on setting up frames and animations.
 *
 * <h4>Example</h4>
 *
 *      var instance = new createjs.Sprite(spriteSheet);
 *      instance.gotoAndStop("frameName");
 *
 * Until {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}} is called,
 * only the first defined frame defined in the sprite sheet will be displayed.
 */
/**
	
	 * Displays a frame or sequence of frames (ie. an animation) from a SpriteSheet instance. A sprite sheet is a series of
	 * images (usually animation frames) combined into a single image. For example, an animation consisting of 8 100x100
	 * images could be combined into a 400x200 sprite sheet (4 frames across by 2 high). You can display individual frames,
	 * play frames as an animation, and even sequence animations together.
	 * 
	 * See the {{#crossLink "SpriteSheet"}}{{/crossLink}} class for more information on setting up frames and animations.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var instance = new createjs.Sprite(spriteSheet);
	 *      instance.gotoAndStop("frameName");
	 * 
	 * Until {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}} is called,
	 * only the first defined frame defined in the sprite sheet will be displayed.
	 
**/
@:native('createjs.Sprite') extern class Sprite extends easeljs.display.DisplayObject {
	function new(spriteSheet:easeljs.display.SpriteSheet, ?frameOrAnimation:Dynamic):Void;
	/**
		
			 * The frame index that will be drawn when draw is called. Note that with some {{#crossLink "SpriteSheet"}}{{/crossLink}}
			 * definitions, this will advance non-sequentially. This will always be an integer value.
			 
	**/
	var currentFrame : Float;
	/**
		
			 * Returns the name of the currently playing animation.
			 
	**/
	var currentAnimation : String;
	/**
		
			 * Prevents the animation from advancing each tick automatically. For example, you could create a sprite
			 * sheet of icons, set paused to true, and display the appropriate icon by setting <code>currentFrame</code>.
			 
	**/
	var paused : Bool;
	/**
		
			 * The SpriteSheet instance to play back. This includes the source image, frame dimensions, and frame
			 * data. See {{#crossLink "SpriteSheet"}}{{/crossLink}} for more information.
			 
	**/
	var spriteSheet : easeljs.display.SpriteSheet;
	/**
		
			 * Specifies the current frame index within the currently playing animation. When playing normally, this will increase
			 * from 0 to n-1, where n is the number of frames in the current animation.
			 * 
			 * This could be a non-integer value if
			 * using time-based playback (see {{#crossLink "Sprite/framerate"}}{{/crossLink}}, or if the animation's speed is
			 * not an integer.
			 
	**/
	var currentAnimationFrame : Float;
	/**
		
			 * By default Sprite instances advance one frame per tick. Specifying a framerate for the Sprite (or its related
			 * SpriteSheet) will cause it to advance based on elapsed time between ticks as appropriate to maintain the target
			 * framerate.
			 * 
			 * For example, if a Sprite with a framerate of 10 is placed on a Stage being updated at 40fps, then the Sprite will
			 * advance roughly one frame every 4 ticks. This will not be exact, because the time between each tick will
			 * vary slightly between frames.
			 * 
			 * This feature is dependent on the tick event object (or an object with an appropriate "delta" property) being
			 * passed into {{#crossLink "Stage/update"}}{{/crossLink}}.
			 
	**/
	var framerate : Float;
	/**
		
			 * Returns true or false indicating whether the display object would be visible if drawn to a canvas.
			 * This does not account for whether it would be visible within the boundaries of the stage.
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function isVisible():Bool;
	/**
		
			 * Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
			 * Returns true if the draw was handled (useful for overriding functionality).
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	/**
		
			 * Because the content of a Sprite is already in a raster format, cache is unnecessary for Sprite instances.
			 * You should not cache Sprite instances as it can degrade performance.
			 
	**/
	override function cache(x:Float, y:Float, width:Float, height:Float, ?scale:Float, ?options:Dynamic):Void;
	/**
		
			 * Because the content of a Sprite is already in a raster format, cache is unnecessary for Sprite instances.
			 * You should not cache Sprite instances as it can degrade performance.
			 
	**/
	override function updateCache(compositeOperation:String):Void;
	/**
		
			 * Because the content of a Sprite is already in a raster format, cache is unnecessary for Sprite instances.
			 * You should not cache Sprite instances as it can degrade performance.
			 
	**/
	override function uncache():Void;
	/**
		
			 * Play (unpause) the current animation. The Sprite will be paused if either {{#crossLink "Sprite/stop"}}{{/crossLink}}
			 * or {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} is called. Single frame animations will remain
			 * unchanged.
			 
	**/
	function play():Void;
	/**
		
			 * Stop playing a running animation. The Sprite will be playing if {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}}
			 * is called. Note that calling {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}} or {{#crossLink "Sprite/play"}}{{/crossLink}}
			 * will resume playback.
			 
	**/
	function stop():Void;
	/**
		
			 * Sets paused to false and plays the specified animation name, named frame, or frame number.
			 
	**/
	function gotoAndPlay(frameOrAnimation:Dynamic):Void;
	/**
		
			 * Sets paused to true and seeks to the specified animation name, named frame, or frame number.
			 
	**/
	function gotoAndStop(frameOrAnimation:Dynamic):Void;
	/**
		
			 * Advances the playhead. This occurs automatically each tick by default.
			 
	**/
	@:native("advance")
	function advanceNative(?time:Float):Void;
	/**
		
			 * Returns a {{#crossLink "Rectangle"}}{{/crossLink}} instance defining the bounds of the current frame relative to
			 * the origin. For example, a 90 x 70 frame with <code>regX=50</code> and <code>regY=40</code> would return a
			 * rectangle with [x=-50, y=-40, width=90, height=70]. This ignores transformations on the display object.
			 * 
			 * Also see the SpriteSheet {{#crossLink "SpriteSheet/getFrameBounds"}}{{/crossLink}} method.
			 
	**/
	override function getBounds():easeljs.geom.Rectangle;
	/**
		
			 * Returns a clone of the Sprite instance. Note that the same SpriteSheet is shared between cloned
			 * instances.
			 
	**/
	override function clone(?recursive:Bool):easeljs.display.DisplayObject;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	override function toString():String;
}
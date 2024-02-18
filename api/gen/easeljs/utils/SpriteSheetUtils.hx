package easeljs.utils;

/**
 * The SpriteSheetUtils class is a collection of static methods for working with {{#crossLink "SpriteSheet"}}{{/crossLink}}s.
 * A sprite sheet is a series of images (usually animation frames) combined into a single image on a regular grid. For
 * example, an animation consisting of 8 100x100 images could be combined into a 400x200 sprite sheet (4 frames across
 * by 2 high). The SpriteSheetUtils class uses a static interface and should not be instantiated.
 */
/**
	
	 * The SpriteSheetUtils class is a collection of static methods for working with {{#crossLink "SpriteSheet"}}{{/crossLink}}s.
	 * A sprite sheet is a series of images (usually animation frames) combined into a single image on a regular grid. For
	 * example, an animation consisting of 8 100x100 images could be combined into a 400x200 sprite sheet (4 frames across
	 * by 2 high). The SpriteSheetUtils class uses a static interface and should not be instantiated.
	 
**/
@:native('createjs.SpriteSheetUtils') extern class SpriteSheetUtils {
	/**
		
			 * Returns a single frame of the specified sprite sheet as a new PNG image. An example of when this may be useful is
			 * to use a spritesheet frame as the source for a bitmap fill.
			 * 
			 * <strong>WARNING:</strong> In almost all cases it is better to display a single frame using a {{#crossLink "Sprite"}}{{/crossLink}}
			 * with a {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} call than it is to slice out a frame using this
			 * method and display it with a Bitmap instance. You can also crop an image using the {{#crossLink "Bitmap/sourceRect"}}{{/crossLink}}
			 * property of {{#crossLink "Bitmap"}}{{/crossLink}}.
			 * 
			 * The extractFrame method may cause cross-domain warnings since it accesses pixels directly on the canvas.
			 
	**/
	static function extractFrame(spriteSheet:easeljs.display.SpriteSheet, frameOrAnimation:Dynamic):js.html.ImageElement;
}
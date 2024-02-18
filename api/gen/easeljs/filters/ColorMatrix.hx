package easeljs.filters;

/**
 * Provides helper functions for assembling a matrix for use with the {{#crossLink "ColorMatrixFilter"}}{{/crossLink}}.
 * Most methods return the instance to facilitate chained calls.
 *
 * <h4>Example</h4>
 *
 *      myColorMatrix.adjustHue(20).adjustBrightness(50);
 *
 * See {{#crossLink "Filter"}}{{/crossLink}} for an example of how to apply filters, or {{#crossLink "ColorMatrixFilter"}}{{/crossLink}}
 * for an example of how to use ColorMatrix to change a DisplayObject's color.
 */
/**
	
	 * Provides helper functions for assembling a matrix for use with the {{#crossLink "ColorMatrixFilter"}}{{/crossLink}}.
	 * Most methods return the instance to facilitate chained calls.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      myColorMatrix.adjustHue(20).adjustBrightness(50);
	 * 
	 * See {{#crossLink "Filter"}}{{/crossLink}} for an example of how to apply filters, or {{#crossLink "ColorMatrixFilter"}}{{/crossLink}}
	 * for an example of how to use ColorMatrix to change a DisplayObject's color.
	 
**/
@:native('createjs.ColorMatrix') extern class ColorMatrix {
	function new(brightness:Float, contrast:Float, saturation:Float, hue:Float):Void;
	/**
		
			 * Resets the instance with the specified values.
			 
	**/
	function setColor(brightness:Float, contrast:Float, saturation:Float, hue:Float):easeljs.filters.ColorMatrix;
	/**
		
			 * Resets the matrix to identity values.
			 
	**/
	function reset():easeljs.filters.ColorMatrix;
	/**
		
			 * Shortcut method to adjust brightness, contrast, saturation and hue.
			 * Equivalent to calling adjustHue(hue), adjustContrast(contrast),
			 * adjustBrightness(brightness), adjustSaturation(saturation), in that order.
			 
	**/
	function adjustColor(brightness:Float, contrast:Float, saturation:Float, hue:Float):easeljs.filters.ColorMatrix;
	/**
		
			 * Adjusts the brightness of pixel color by adding the specified value to the red, green and blue channels.
			 * Positive values will make the image brighter, negative values will make it darker.
			 
	**/
	function adjustBrightness(value:Float):easeljs.filters.ColorMatrix;
	/**
		
			 * Adjusts the contrast of pixel color.
			 * Positive values will increase contrast, negative values will decrease contrast.
			 
	**/
	function adjustContrast(value:Float):easeljs.filters.ColorMatrix;
	/**
		
			 * Adjusts the color saturation of the pixel.
			 * Positive values will increase saturation, negative values will decrease saturation (trend towards greyscale).
			 
	**/
	function adjustSaturation(value:Float):easeljs.filters.ColorMatrix;
	/**
		
			 * Adjusts the hue of the pixel color.
			 
	**/
	function adjustHue(value:Float):easeljs.filters.ColorMatrix;
	/**
		
			 * Concatenates (multiplies) the specified matrix with this one.
			 
	**/
	function concat(matrix:Array<Dynamic>):easeljs.filters.ColorMatrix;
	/**
		
			 * Returns a clone of this ColorMatrix.
			 
	**/
	function clone():easeljs.filters.ColorMatrix;
	/**
		
			 * Return a length 25 (5x5) array instance containing this matrix's values.
			 
	**/
	function toArray():Array<Float>;
	/**
		
			 * Copy the specified matrix's values to this matrix.
			 
	**/
	function copy(matrix:Array<Float>):easeljs.filters.ColorMatrix;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	function toString():String;
}
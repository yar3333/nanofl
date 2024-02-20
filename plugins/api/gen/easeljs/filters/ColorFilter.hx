package easeljs.filters;

/**
 * Applies a color transform to DisplayObjects.
 *
 * <h4>Example</h4>
 * This example draws a red circle, and then transforms it to Blue. This is accomplished by multiplying all the channels
 * to 0 (except alpha, which is set to 1), and then adding 255 to the blue channel.
 *
 *      var shape = new createjs.Shape().set({x:100,y:100});
 *      shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
 *
 *      shape.filters = [
 *          new createjs.ColorFilter(0,0,0,1, 0,0,255,0)
 *      ];
 *      shape.cache(-50, -50, 100, 100);
 *
 * See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
 */
/**
	
	 * Applies a color transform to DisplayObjects.
	 * 
	 * <h4>Example</h4>
	 * This example draws a red circle, and then transforms it to Blue. This is accomplished by multiplying all the channels
	 * to 0 (except alpha, which is set to 1), and then adding 255 to the blue channel.
	 * 
	 *      var shape = new createjs.Shape().set({x:100,y:100});
	 *      shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
	 * 
	 *      shape.filters = [
	 *          new createjs.ColorFilter(0,0,0,1, 0,0,255,0)
	 *      ];
	 *      shape.cache(-50, -50, 100, 100);
	 * 
	 * See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
	 
**/
@:native('createjs.ColorFilter') extern class ColorFilter extends easeljs.filters.Filter {
	function new(?redMultiplier:Float, ?greenMultiplier:Float, ?blueMultiplier:Float, ?alphaMultiplier:Float, ?redOffset:Float, ?greenOffset:Float, ?blueOffset:Float, ?alphaOffset:Float):Void;
	/**
		
			 * Red channel multiplier.
			 
	**/
	var redMultiplier : Float;
	/**
		
			 * Green channel multiplier.
			 
	**/
	var greenMultiplier : Float;
	/**
		
			 * Blue channel multiplier.
			 
	**/
	var blueMultiplier : Float;
	/**
		
			 * Alpha channel multiplier.
			 
	**/
	var alphaMultiplier : Float;
	/**
		
			 * Red channel offset (added to value).
			 
	**/
	var redOffset : Float;
	/**
		
			 * Green channel offset (added to value).
			 
	**/
	var greenOffset : Float;
	/**
		
			 * Blue channel offset (added to value).
			 
	**/
	var blueOffset : Float;
	/**
		
			 * Alpha channel offset (added to value).
			 
	**/
	var alphaOffset : Float;
}
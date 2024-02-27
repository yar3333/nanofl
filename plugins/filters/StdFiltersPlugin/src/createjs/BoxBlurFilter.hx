package createjs;

/**
 * Applies a box blur to DisplayObjects. Note that this filter is fairly CPU intensive, particularly if the quality is
 * set higher than 1.
 * 
 * <h4>Example</h4>
 * This example creates a red circle, and then applies a 5 pixel blur to it. It uses the {{#crossLink "Filter/getBounds"}}{{/crossLink}}
 * method to account for the spread that the blur causes.
 * 
 *      var shape = new easeljs.display.Shape().set({x:100,y:100});
 *      shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
 * 
 *      var blurFilter = new easeljs.filters.BoxBlurFilter(5, 5, 1);
 *      shape.filters = [blurFilter];
 *      var bounds = blurFilter.getBounds();
 * 
 *      shape.cache(-50+bounds.x, -50+bounds.y, 100+bounds.width, 100+bounds.height);
 * 
 * See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
 */
extern class BoxBlurFilter extends easeljs.filters.Filter
{
	private static function __init__() : Void
	{
		haxe.macro.Compiler.includeFile("createjs/BoxBlurFilter.js", "inline");
	}
	
	/**
	 * Horizontal blur radius in pixels
	 */
	var blurX : Float;
	/**
	 * Vertical blur radius in pixels
	 */
	var blurY : Float;
	/**
	 * Number of blur iterations. For example, a value of 1 will produce a rough blur. A value of 2 will produce a
	 * smoother blur, but take twice as long to run.
	 */
	var quality : Float;

	function new(?blurX:Float, ?blurY:Float, ?quality:Float) : Void;
}
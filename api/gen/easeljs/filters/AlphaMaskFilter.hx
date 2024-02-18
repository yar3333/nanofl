package easeljs.filters;

/**
 * Applies the alpha from the mask image (or canvas) to the target, such that the alpha channel of the result will
 * be derived from the mask, and the RGB channels will be copied from the target. This can be used, for example, to
 * apply an alpha mask to a display object. This can also be used to combine a JPG compressed RGB image with a PNG32
 * alpha mask, which can result in a much smaller file size than a single PNG32 containing ARGB.
 *
 * <b>IMPORTANT NOTE: This filter currently does not support the targetCtx, or targetX/Y parameters correctly.</b>
 *
 * <h4>Example</h4>
 * This example draws a gradient box, then caches it and uses the "cacheCanvas" as the alpha mask on a 100x100 image.
 *
 *      var box = new createjs.Shape();
 *      box.graphics.beginLinearGradientFill(["#000000", "rgba(0, 0, 0, 0)"], [0, 1], 0, 0, 100, 100)
 *      box.graphics.drawRect(0, 0, 100, 100);
 *      box.cache(0, 0, 100, 100);
 *
 *      var bmp = new createjs.Bitmap("path/to/image.jpg");
 *      bmp.filters = [
 *          new createjs.AlphaMaskFilter(box.cacheCanvas)
 *      ];
 *      bmp.cache(0, 0, 100, 100);
 *
 * See {{#crossLink "Filter"}}{{/crossLink}} for more information on applying filters.
 */
/**
	
	 * Applies the alpha from the mask image (or canvas) to the target, such that the alpha channel of the result will
	 * be derived from the mask, and the RGB channels will be copied from the target. This can be used, for example, to
	 * apply an alpha mask to a display object. This can also be used to combine a JPG compressed RGB image with a PNG32
	 * alpha mask, which can result in a much smaller file size than a single PNG32 containing ARGB.
	 * 
	 * <b>IMPORTANT NOTE: This filter currently does not support the targetCtx, or targetX/Y parameters correctly.</b>
	 * 
	 * <h4>Example</h4>
	 * This example draws a gradient box, then caches it and uses the "cacheCanvas" as the alpha mask on a 100x100 image.
	 * 
	 *      var box = new createjs.Shape();
	 *      box.graphics.beginLinearGradientFill(["#000000", "rgba(0, 0, 0, 0)"], [0, 1], 0, 0, 100, 100)
	 *      box.graphics.drawRect(0, 0, 100, 100);
	 *      box.cache(0, 0, 100, 100);
	 * 
	 *      var bmp = new createjs.Bitmap("path/to/image.jpg");
	 *      bmp.filters = [
	 *          new createjs.AlphaMaskFilter(box.cacheCanvas)
	 *      ];
	 *      bmp.cache(0, 0, 100, 100);
	 * 
	 * See {{#crossLink "Filter"}}{{/crossLink}} for more information on applying filters.
	 
**/
@:native('createjs.AlphaMaskFilter') extern class AlphaMaskFilter extends easeljs.filters.Filter {
	function new(mask:haxe.extern.EitherType<js.html.ImageElement, js.html.CanvasElement>):Void;
	/**
		
			 * The image (or canvas) to use as the mask.
			 
	**/
	var mask : haxe.extern.EitherType<js.html.ImageElement, js.html.CanvasElement>;
	/**
		
			 * Applies the filter to the specified context.
			 * 
			 * <strong>IMPORTANT NOTE: This filter currently does not support the targetCtx, or targetX/Y parameters
			 * correctly.</strong>
			 
	**/
	override function applyFilter(ctx:js.html.CanvasRenderingContext2D, x:Int, y:Int, width:Int, height:Int, ?targetCtx:js.html.CanvasRenderingContext2D, ?targetX:Int, ?targetY:Int):Bool;
}
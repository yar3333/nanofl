package easeljs.filters;

/**
 * Base class that all filters should inherit from. Filters need to be applied to objects that have been cached using
 * the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method. If an object changes, please cache it again, or use
 * {{#crossLink "DisplayObject/updateCache"}}{{/crossLink}}. Note that the filters must be applied before caching.
 *
 * <h4>Example</h4>
 *
 *      myInstance.filters = [
 *          new createjs.ColorFilter(0, 0, 0, 1, 255, 0, 0),
 *          new createjs.BlurFilter(5, 5, 10)
 *      ];
 *      myInstance.cache(0,0, 100, 100);
 *
 * Note that each filter can implement a {{#crossLink "Filter/getBounds"}}{{/crossLink}} method, which returns the
 * margins that need to be applied in order to fully display the filter. For example, the {{#crossLink "BlurFilter"}}{{/crossLink}}
 * will cause an object to feather outwards, resulting in a margin around the shape.
 *
 * <h4>EaselJS Filters</h4>
 * EaselJS comes with a number of pre-built filters:
 * <ul><li>{{#crossLink "AlphaMapFilter"}}{{/crossLink}} : Map a greyscale image to the alpha channel of a display object</li>
 *      <li>{{#crossLink "AlphaMaskFilter"}}{{/crossLink}}: Map an image's alpha channel to the alpha channel of a display object</li>
 *      <li>{{#crossLink "BlurFilter"}}{{/crossLink}}: Apply vertical and horizontal blur to a display object</li>
 *      <li>{{#crossLink "ColorFilter"}}{{/crossLink}}: Color transform a display object</li>
 *      <li>{{#crossLink "ColorMatrixFilter"}}{{/crossLink}}: Transform an image using a {{#crossLink "ColorMatrix"}}{{/crossLink}}</li>
 * </ul>
 */
/**
	
	 * Base class that all filters should inherit from. Filters need to be applied to objects that have been cached using
	 * the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method. If an object changes, please cache it again, or use
	 * {{#crossLink "DisplayObject/updateCache"}}{{/crossLink}}. Note that the filters must be applied before caching.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      myInstance.filters = [
	 *          new createjs.ColorFilter(0, 0, 0, 1, 255, 0, 0),
	 *          new createjs.BlurFilter(5, 5, 10)
	 *      ];
	 *      myInstance.cache(0,0, 100, 100);
	 * 
	 * Note that each filter can implement a {{#crossLink "Filter/getBounds"}}{{/crossLink}} method, which returns the
	 * margins that need to be applied in order to fully display the filter. For example, the {{#crossLink "BlurFilter"}}{{/crossLink}}
	 * will cause an object to feather outwards, resulting in a margin around the shape.
	 * 
	 * <h4>EaselJS Filters</h4>
	 * EaselJS comes with a number of pre-built filters:
	 * <ul><li>{{#crossLink "AlphaMapFilter"}}{{/crossLink}} : Map a greyscale image to the alpha channel of a display object</li>
	 *      <li>{{#crossLink "AlphaMaskFilter"}}{{/crossLink}}: Map an image's alpha channel to the alpha channel of a display object</li>
	 *      <li>{{#crossLink "BlurFilter"}}{{/crossLink}}: Apply vertical and horizontal blur to a display object</li>
	 *      <li>{{#crossLink "ColorFilter"}}{{/crossLink}}: Color transform a display object</li>
	 *      <li>{{#crossLink "ColorMatrixFilter"}}{{/crossLink}}: Transform an image using a {{#crossLink "ColorMatrix"}}{{/crossLink}}</li>
	 * </ul>
	 
**/
@:native('createjs.Filter') extern class Filter {
	function new():Void;
	/**
		
			 * A flag stating that this filter uses a context draw mode and cannot be batched into imageData processing.
			 
	**/
	var usesContext : Bool;
	/**
		
			 * Pre-processed template shader code. It will be parsed before being fed in into the shader compiler.
			 * This should be based upon StageGL.SHADER_VERTEX_BODY_REGULAR
			 
	**/
	var VTX_SHADER : String;
	/**
		
			 * Pre-processed template shader code. It will be parsed before being fed in into the shader compiler.
			 * This should be based upon StageGL.SHADER_FRAGMENT_BODY_REGULAR
			 
	**/
	var FRAG_SHADER : String;
	/**
		
			 * Provides padding values for this filter. That is, how much the filter will extend the visual bounds of an object it is applied to.
			 
	**/
	function getBounds(?rect:easeljs.geom.Rectangle):easeljs.geom.Rectangle;
	/**
		
			 * Assign any unique uniforms or other setup functionality here.
			 
	**/
	function shaderParamSetup(gl:js.html.webgl.WebGL2RenderingContext, stage:easeljs.display.StageGL, shaderProgram:Dynamic):Void;
	/**
		
			 * Applies the filter to the specified context.
			 
	**/
	function applyFilter(ctx:js.html.CanvasRenderingContext2D, x:Int, y:Int, width:Int, height:Int, ?targetCtx:js.html.CanvasRenderingContext2D, ?targetX:Int, ?targetY:Int):Bool;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	function toString():String;
	/**
		
			 * Returns a clone of this Filter instance.
			 
	**/
	function clone():easeljs.filters.Filter;
}
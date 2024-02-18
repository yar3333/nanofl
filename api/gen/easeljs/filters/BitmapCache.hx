package easeljs.filters;

/**
 * The BitmapCache is an internal representation of all the cache properties and logic required in order to "cache"
 * an object. This information and functionality used to be located on a {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
 * method in {{#crossLink "DisplayObject"}}{{/crossLink}}, but was moved to its own class.
 *
 * Caching in this context is purely visual, and will render the DisplayObject out into an image to be used instead
 * of the object. The actual cache itself is still stored on the target with the {{#crossLink "DisplayObject/cacheCanvas:property"}}{{/crossLink}}.
 * Working with a singular image like a {{#crossLink "Bitmap"}}{{/crossLink}} there is little benefit to performing
 * a cache as it is already a single image. Caching is best done on containers containing multiple complex parts that
 * do not move often, so that rendering the image instead will improve overall rendering speed. A cached object will
 * not visually update until explicitly told to do so with a call to update, much like a Stage. If a cache is being
 * updated every frame it is likely not improving rendering performance. Cache are best used when updates will be sparse.
 *
 * Caching is also a co-requisite for applying filters to prevent expensive filters running constantly without need,
 * and to physically enable some effects. The BitmapCache is also responsible for applying filters to objects and
 * reads each {{#crossLink "Filter"}}{{/crossLink}} due to this relationship. Real-time Filters are not recommended
 * performance wise when dealing with a Context2D canvas. For best performance and to still allow for some visual
 * effects use a compositeOperation when possible.
 */
/**
	
	 * The BitmapCache is an internal representation of all the cache properties and logic required in order to "cache"
	 * an object. This information and functionality used to be located on a {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
	 * method in {{#crossLink "DisplayObject"}}{{/crossLink}}, but was moved to its own class.
	 * 
	 * Caching in this context is purely visual, and will render the DisplayObject out into an image to be used instead
	 * of the object. The actual cache itself is still stored on the target with the {{#crossLink "DisplayObject/cacheCanvas:property"}}{{/crossLink}}.
	 * Working with a singular image like a {{#crossLink "Bitmap"}}{{/crossLink}} there is little benefit to performing 
	 * a cache as it is already a single image. Caching is best done on containers containing multiple complex parts that 
	 * do not move often, so that rendering the image instead will improve overall rendering speed. A cached object will 
	 * not visually update until explicitly told to do so with a call to update, much like a Stage. If a cache is being 
	 * updated every frame it is likely not improving rendering performance. Cache are best used when updates will be sparse.
	 * 
	 * Caching is also a co-requisite for applying filters to prevent expensive filters running constantly without need, 
	 * and to physically enable some effects. The BitmapCache is also responsible for applying filters to objects and 
	 * reads each {{#crossLink "Filter"}}{{/crossLink}} due to this relationship. Real-time Filters are not recommended 
	 * performance wise when dealing with a Context2D canvas. For best performance and to still allow for some visual 
	 * effects use a compositeOperation when possible.
	 
**/
@:native('createjs.BitmapCache') extern class BitmapCache {
	function new():Void;
	/**
		
			 * Track how many times the cache has been updated, mostly used for preventing duplicate cacheURLs.
			 * This can be useful to see if a cache has been updated.
			 
	**/
	var cacheID : Int;
	/**
		
		     * Width of the cache relative to the target object.
		     * @property width
		     * @protected
		     * @type {Number}
		     * @default undefined
		     
	**/
	var width : Float;
	/**
		
		     * Height of the cache relative to the target object.
		     * @property height
		     * @protected
		     * @type {Number}
		     * @default undefined
		     * @todo Should the width and height be protected?
		     
	**/
	var height : Float;
	/**
		
		     * Horizontal position of the cache relative to the target's origin.
		     * @property x
		     * @protected
		     * @type {Number}
		     * @default undefined
		     
	**/
	var x : Float;
	/**
		
		     * Vertical position of the cache relative to target's origin.
		     * @property y
		     * @protected
		     * @type {Number}
		     * @default undefined
		     
	**/
	var y : Float;
	/**
		
		     * The internal scale of the cache image, does not affects display size. This is useful to both increase and
		     * decrease render quality. Objects with increased scales are more likely to look good when scaled up or rotated.
		     * Objects with decreased scales can save on rendering performance.
		     * @property scale
		     * @protected
		     * @type {Number}
		     * @default 1
		     
	**/
	var scale : Float;
	/**
		
		     * The x offset used for drawing into the cache itself, accounts for both transforms applied.
		     * @property offX
		     * @protected
		     * @type {Number}
		     * @default 0
		     
	**/
	var offX : Float;
	/**
		
		     * The y offset used for drawing into the cache itself, accounts for both transforms applied.
		     * @property offY
		     * @protected
		     * @type {Number}
		     * @default 0
		     
	**/
	var offY : Float;
	/**
		
		     * The relative offset of the filter's x position, used for drawing the cache onto its container.
		     * Re-calculated every update call before drawing.
		     * @property _filterOffY
		     * @protected
		     * @type {Number}
		     * @default 0
		     
	**/
	var _filterOffX : Float;
	/**
		
		     * The relative offset of the filter's y position, used for drawing the cache onto its container.
		     * Re-calculated every update call before drawing.
		     * @property _filterOffY
		     * @protected
		     * @type {Number}
		     * @default 0
		     
	**/
	var _filterOffY : Float;
	/**
		
		     * If options.useGL is set to "new" a StageGL is created and contained on this for use when rendering the cache.
		     * If options.useGL is set to "stage" if the current stage is a StageGL it will be used. If not then it will default to "new".
		     * If options.useGL is a StageGL instance it will not create one but use the one provided.
		     * If options.useGL is undefined a Context 2D cache will be performed.
		     
	**/
	function define(x:Int, y:Int, width:Int, height:Int, ?scale:Float, ?options:{ @:optional
	public var useGL(default, default) : haxe.extern.EitherType<String, easeljs.display.StageGL>; }):Void;
	/**
		
			 * Returns a string representation of this object.
			 
	**/
	function toString():String;
	/**
		
			 * Actually create the correct cache surface and properties associated with it. Caching and it's benefits are discussed
			 * by the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} function and this class description. Here are the detailed
			 * specifics of how to use the options object.
			 * 
			 * - If options.useGL is set to "new" a StageGL is created and contained on this for use when rendering the cache.
			 * - If options.useGL is set to "stage" if the current stage is a StageGL it will be used. If not then it will default to "new".
			 * - If options.useGL is a StageGL instance it will not create one but use the one provided.
			 * - If options.useGL is undefined a Context 2D cache will be performed.
			 * 
			 * This means you can use any combination of StageGL and 2D with either, neither, or both the stage and cache being
			 * WebGL. Using "new" with a StageGL display list is highly unrecommended, but still an option. It should be avoided
			 * due to negative performance reasons and the Image loading limitation noted in the class complications above.
			 * 
			 * When "options.useGL" is set to the parent stage of the target and WebGL, performance is increased by using
			 * "RenderTextures" instead of canvas elements. These are internal Textures on the graphics card stored in the GPU.
			 * Because they are no longer canvases you cannot perform operations you could with a regular canvas. The benefit
			 * is that this avoids the slowdown of copying the texture back and forth from the GPU to a Canvas element.
			 * This means "stage" is the recommended option when available.
			 * 
			 * A StageGL cache does not infer the ability to draw objects a StageGL cannot currently draw, i.e. do not use a
			 * WebGL context cache when caching a Shape, Text, etc.
			 * <h4>WebGL cache with a 2D context</h4>
			 * 
			 *     var stage = new createjs.Stage();
			 *     var bmp = new createjs.Bitmap(src);
			 *     bmp.cache(0, 0, bmp.width, bmp.height, 1, {gl: "new"});          // no StageGL to use, so make one
			 * 
			 *     var shape = new createjs.Shape();
			 *     shape.graphics.clear().fill("red").drawRect(0,0,20,20);
			 *     shape.cache(0, 0, 20, 20, 1);                             // cannot use WebGL cache
			 * 
			 * <h4>WebGL cache with a WebGL context</h4>
			 * 
			 *     var stageGL = new createjs.StageGL();
			 *     var bmp = new createjs.Bitmap(src);
			 *     bmp.cache(0, 0, bmp.width, bmp.height, 1, {gl: "stage"});       // use our StageGL to cache
			 * 
			 *     var shape = new createjs.Shape();
			 *     shape.graphics.clear().fill("red").drawRect(0,0,20,20);
			 *     shape.cache(0, 0, 20, 20, 1);                             // cannot use WebGL cache
			 * 
			 * You may wish to create your own StageGL instance to control factors like clear color, transparency, AA, and
			 * others. If you do, pass a new instance in instead of "true", the library will automatically set the
			 * {{#crossLink "StageGL/isCacheControlled"}}{{/crossLink}} to true on your instance. This will trigger it to behave
			 * correctly, and not assume your main context is WebGL.
			 
	**/
	function cache(x:Int, y:Int, width:Int, height:Int, ?scale:Float, ?options:Dynamic):Void;
	/**
		
			 * Directly called via {{#crossLink "DisplayObject/updateCache:method"}}{{/crossLink}}, but also internally. This
			 * has the dual responsibility of making sure the surface is ready to be drawn to, and performing the draw. For
			 * full details of each behaviour, check the protected functions {{#crossLink "BitmapCache/_updateSurface"}}{{/crossLink}}
			 * and {{#crossLink "BitmapCache/_drawToCache"}}{{/crossLink}} respectively.
			 
	**/
	function update(?compositeOperation:String):Void;
	/**
		
			 * Reset and release all the properties and memory associated with this cache.
			 
	**/
	function release():Void;
	/**
		
			 * Returns a data URL for the cache, or `null` if this display object is not cached.
			 * Uses {{#crossLink "BitmapCache/cacheID:property"}}{{/crossLink}} to ensure a new data URL is not generated if the
			 * cache has not changed.
			 
	**/
	function getCacheDataURL():String;
	/**
		
			 * Use context2D drawing commands to display the cache canvas being used.
			 
	**/
	function draw(ctx:js.html.CanvasRenderingContext2D):Bool;
	/**
		
			 * Returns the bounds that surround all applied filters, relies on each filter to describe how it changes bounds.
			 
	**/
	static function getFilterBounds(target:easeljs.display.DisplayObject, ?output:easeljs.geom.Rectangle):easeljs.geom.Rectangle;
}
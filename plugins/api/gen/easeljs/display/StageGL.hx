package easeljs.display;

/**
 * A StageGL instance is the root level {{#crossLink "Container"}}{{/crossLink}} for an WebGL-optimized display list,
 * which is used in place of the usual {{#crossLink "Stage"}}{{/crossLink}}. This class should behave identically to
 * a {{#crossLink "Stage"}}{{/crossLink}} except for WebGL-specific functionality.
 *
 * Each time the {{#crossLink "Stage/tick"}}{{/crossLink}} method is called, the display list is rendered to the
 * target &lt;canvas/&gt; instance, ignoring non-WebGL-compatible display objects. On devices and browsers that don't
 * support WebGL, content will automatically be rendered to canvas 2D context instead.
 *
 * <h4>Limitations</h4>
 * - {{#crossLink "Shape"}}{{/crossLink}}, {{#crossLink "Shadow"}}{{/crossLink}}, and {{#crossLink "Text"}}{{/crossLink}}
 * 	are not rendered when added to the display list.
 * - To display something StageGL cannot render, {{#crossLink "displayObject/cache"}}{{/crossLink}} the object.
 * 	Caches can be rendered regardless of source.
 * - Images are wrapped as a webGL "Texture". Each graphics card has a limit to its concurrent Textures, too many
 * Textures will noticeably slow performance.
 * - Each cache counts as an individual Texture. As such {{#crossLink "SpriteSheet"}}{{/crossLink}} and
 * {{#crossLink "SpriteSheetBuilder"}}{{/crossLink}} are recommended practices to help keep texture counts low.
 * - To use any image node (DOM Image/Canvas Element) between multiple StageGL instances it must be a
 * {{#crossLink "Bitmap/clone"}}{{/crossLink}}, otherwise the GPU texture loading and tracking will get confused.
 * - to avoid an up/down scaled render you must call {{#crossLink "StageGL/updateViewport"}}{{/crossLink}} if you
 * resize your canvas after making a StageGL instance, this will properly size the WebGL context stored in memory.
 * - Best performance in demanding scenarios will come from manual management of texture memory, but it is handled
 * automatically by default. See {{#crossLink "StageGL/releaseTexture"}}{{/crossLink}} for details.
 *
 * <h4>Example</h4>
 * This example creates a StageGL instance, adds a child to it, then uses the EaselJS {{#crossLink "Ticker"}}{{/crossLink}}
 * to update the child and redraw the stage.
 *
 *      var stage = new createjs.StageGL("canvasElementId");
 *
 *      var image = new createjs.Bitmap("imagePath.png");
 *      stage.addChild(image);
 *
 *      createjs.Ticker.on("tick", handleTick);
 *
 *      function handleTick(event) {
 *          image.x += 10;
 *          stage.update();
 *      }
 *
 * <h4>Notes</h4>
 * - StageGL is not currently included in the minified version of EaselJS.
 * - {{#crossLink "SpriteContainer"}}{{/crossLink}} (the previous approach to WebGL with EaselJS) has been deprecated.
 * - Earlier versions of WebGL support in EaselJS (SpriteStage and SpriteContainer) had hard limitations on images
 * 	per container, which have been solved.
 */
/**
	
	 * A StageGL instance is the root level {{#crossLink "Container"}}{{/crossLink}} for an WebGL-optimized display list,
	 * which is used in place of the usual {{#crossLink "Stage"}}{{/crossLink}}. This class should behave identically to
	 * a {{#crossLink "Stage"}}{{/crossLink}} except for WebGL-specific functionality.
	 * 
	 * Each time the {{#crossLink "Stage/tick"}}{{/crossLink}} method is called, the display list is rendered to the
	 * target &lt;canvas/&gt; instance, ignoring non-WebGL-compatible display objects. On devices and browsers that don't
	 * support WebGL, content will automatically be rendered to canvas 2D context instead.
	 * 
	 * <h4>Limitations</h4>
	 * - {{#crossLink "Shape"}}{{/crossLink}}, {{#crossLink "Shadow"}}{{/crossLink}}, and {{#crossLink "Text"}}{{/crossLink}}
	 * 	are not rendered when added to the display list.
	 * - To display something StageGL cannot render, {{#crossLink "displayObject/cache"}}{{/crossLink}} the object.
	 * 	Caches can be rendered regardless of source.
	 * - Images are wrapped as a webGL "Texture". Each graphics card has a limit to its concurrent Textures, too many 
	 * Textures will noticeably slow performance.
	 * - Each cache counts as an individual Texture. As such {{#crossLink "SpriteSheet"}}{{/crossLink}} and 
	 * {{#crossLink "SpriteSheetBuilder"}}{{/crossLink}} are recommended practices to help keep texture counts low.
	 * - To use any image node (DOM Image/Canvas Element) between multiple StageGL instances it must be a 
	 * {{#crossLink "Bitmap/clone"}}{{/crossLink}}, otherwise the GPU texture loading and tracking will get confused.
	 * - to avoid an up/down scaled render you must call {{#crossLink "StageGL/updateViewport"}}{{/crossLink}} if you
	 * resize your canvas after making a StageGL instance, this will properly size the WebGL context stored in memory.
	 * - Best performance in demanding scenarios will come from manual management of texture memory, but it is handled
	 * automatically by default. See {{#crossLink "StageGL/releaseTexture"}}{{/crossLink}} for details.
	 * 
	 * <h4>Example</h4>
	 * This example creates a StageGL instance, adds a child to it, then uses the EaselJS {{#crossLink "Ticker"}}{{/crossLink}}
	 * to update the child and redraw the stage.
	 * 
	 *      var stage = new createjs.StageGL("canvasElementId");
	 * 
	 *      var image = new createjs.Bitmap("imagePath.png");
	 *      stage.addChild(image);
	 * 
	 *      createjs.Ticker.on("tick", handleTick);
	 * 
	 *      function handleTick(event) {
	 *          image.x += 10;
	 *          stage.update();
	 *      }
	 * 
	 * <h4>Notes</h4>
	 * - StageGL is not currently included in the minified version of EaselJS.
	 * - {{#crossLink "SpriteContainer"}}{{/crossLink}} (the previous approach to WebGL with EaselJS) has been deprecated.
	 * - Earlier versions of WebGL support in EaselJS (SpriteStage and SpriteContainer) had hard limitations on images
	 * 	per container, which have been solved.
	 
**/
@:native('createjs.StageGL') extern class StageGL extends easeljs.display.Stage {
	function new(canvas:Dynamic, options:Dynamic):Void;
	/**
		
			 * Console log potential issues and problems. This is designed to have <em>minimal</em> performance impact, so
			 * if extensive debugging information is required, this may be inadequate. See {{#crossLink "WebGLInspector"}}{{/crossLink}}
			 
	**/
	var vocalDebug : Bool;
	/**
		
			 * Indicates whether WebGL is being used for rendering. For example, this would be `false` if WebGL is not
			 * supported in the browser.
			 
	**/
	var isWebGL : Bool;
	/**
		
			 * Draws the stage into the supplied context if possible. Many WebGL properties only exist on their context. As such
			 * you cannot share contexts among many StageGLs and each context requires a unique StageGL instance. Contexts that
			 * don't match the context managed by this StageGL will be treated as a 2D context.
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	override function draw(context:Dynamic, ?ignoreCache:Bool):Bool;
	/**
		
			 * Draws the target into the correct context, be it a canvas or Render Texture using WebGL.
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	function cacheDraw(target:easeljs.display.DisplayObject, filters:Array<Dynamic>, manager:easeljs.filters.BitmapCache):Bool;
	/**
		
			 * Blocks, or frees a texture "slot" on the GPU. Can be useful if you are overflowing textures. When overflowing
			 * textures they are re-uploaded to the GPU every time they're encountered, this can be expensive with large textures.
			 * By blocking the slot you reduce available slots, potentially increasing draw calls, but mostly you prevent a
			 * texture being re-uploaded if it would have moved slots due to overflow.
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 * For example, block the slot a background image is stored in so there is less re-loading of that image.
			 
	**/
	function protectTextureSlot(id:Int, ?lock:Bool):Void;
	/**
		
			 * Render textures can't draw into themselves so any item being used for renderTextures needs two to alternate between.
			 * This function creates, gets, and toggles the render surface between the two.
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	function getTargetRenderTexture(target:easeljs.display.DisplayObject, w:Float, h:Float):Dynamic;
	/**
		
			 * For every image encountered StageGL registers and tracks it automatically. This tracking can cause memory leaks 
			 * if not purged. StageGL, by default, automatically purges them. This does have a cost and may unfortunately find
			 * false positives. This function is for manual management of this memory instead of the automatic system controlled
			 * by the {{#crossLink "StageGL/autoPurge:property"}}{{/crossLink}} property.
			 * 
			 * This function will recursively remove all textures found on the object, its children, cache, etc. It will uncache 
			 * objects and remove any texture it finds REGARDLESS of whether it is currently in use elsewhere. It is up to the
			 * developer to ensure that a texture in use is not removed.
			 * 
			 * Textures in use, or to be used again shortly, should not be removed. This is simply for performance reasons.
			 * Removing a texture in use will cause the texture to have to be re-uploaded slowing rendering.
			 
	**/
	function releaseTexture(item:Dynamic):Void;
	/**
		
			 * Similar to {{#crossLink "releaseTexture"}}{{/crossLink}}, but this function differs by searching for textures to
			 * release. It works by assuming that it can purge any texture which was last used more than "count" draw calls ago.
			 * Because this process is unaware of the objects and whether they may be used on your stage, false positives can
			 * occur. It is recommended to manually manage your memory with {{#crossLink "StageGL/releaseTexture"}}{{/crossLink}},
			 * however, there are many use cases where this is simpler and error-free. This process is also run by default under
			 * the hood to prevent leaks. To disable it see the {{#crossLink "StageGL/autoPurge:property"}}{{/crossLink}} property.
			 
	**/
	function purgeTextures(?count:Float):Void;
	/**
		
			 * Try to set the max textures the system can handle. It should default to the hardware maximum, and lower values
			 * may limit performance. Some devices have been known to mis-report their max textures, or you may need a standard
			 * baseline cross devices for testing. Barring the previous suggestions, there is little need to call this function
			 * as the library will automatically try to find the best value.
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	function updateSimultaneousTextureCount(?count:Float):Void;
	/**
		
			 * Update the WebGL viewport. Note that this does <strong>not</strong> update the canvas element's width/height, but
			 * the render surface's instead. This is necessary after manually resizing the canvas element on the DOM to avoid a
			 * up/down scaled render.
			 
	**/
	function updateViewport(width:Int, height:Int):Void;
	/**
		
			 * Fetches the shader compiled and set up to work with the provided filter/object. The shader is compiled on first
			 * use and returned on subsequent calls.
			 
	**/
	function getFilterShader(filter:Dynamic):js.html.webgl.Program;
	/**
		
			 * Returns a base texture that has no image or data loaded. Not intended for loading images. It may return `null`
			 * in some error cases, and trying to use a "null" texture can cause renders to fail.
			 
	**/
	function getBaseTexture(?w:Int, ?h:Int):Void;
	/**
		
			 * Returns a base texture (see {{#crossLink "StageGL/getBaseTexture"}}{{/crossLink}}) for details. Also includes an
			 * attached and linked render buffer in `texture._frameBuffer`. RenderTextures can be thought of as an internal
			 * canvas on the GPU that can be drawn to.
			 
	**/
	function getRenderBufferTexture(w:Float, h:Float):js.html.webgl.Texture;
	/**
		
			 * Common utility function used to apply the correct texture processing parameters for the bound texture.
			 
	**/
	function setTextureParams(gl:js.html.webgl.WebGL2RenderingContext, ?isPOT:Bool):Void;
	/**
		
			 * Changes the webGL clear, aka "background" color to the provided value. A transparent clear is recommended, as
			 * non-transparent colours may create undesired boxes around some visuals.
			 * 
			 * The clear color will also be used for filters and other "render textures". The stage background will ignore the
			 * transparency value and display a solid color normally. For the stage to recognize and use transparency it must be
			 * created with the transparent flag set to `true` (see {{#crossLink "StageGL/constructor"}}{{/crossLink}})).
			 * 
			 * Using "transparent white" to demonstrate, the valid data formats are as follows:
			 * <ul>
			 *     <li>"#FFF"</li>
			 *     <li>"#FFFFFF"</li>
			 *     <li>"#FFFFFF00"</li>
			 *     <li>"rgba(255,255,255,0.0)"</li>
			 * </ul>
			 
	**/
	function setClearColor(?color:Dynamic):Void;
	/**
		
			 * The number of properties defined per vertex (x, y, textureU, textureV, textureIndex, alpha)
			 
	**/
	static var VERTEX_PROPERTY_COUNT : Float;
	/**
		
			 * The number of triangle indices it takes to form a Card. 3 per triangle, 2 triangles.
			 
	**/
	static var INDICIES_PER_CARD : Float;
	/**
		
			 * The default value for the maximum number of cards we want to process in a batch. See
			 * {{#crossLink "StageGL/WEBGL_MAX_INDEX_NUM:property"}}{{/crossLink}} for a hard limit.
			 
	**/
	static var DEFAULT_MAX_BATCH_SIZE : Float;
	/**
		
			 * The maximum size WebGL allows for element index numbers. Uses a 16 bit unsigned integer. It takes 6 indices to
			 * make a unique card.
			 
	**/
	static var WEBGL_MAX_INDEX_NUM : Float;
	/**
		
			 * Default U/V rect for dealing with full coverage from an image source.
			 
	**/
	static var UV_RECT : Dynamic;
	/**
		
			 * Vertex positions for a card that covers the entire render. Used with render targets primarily.
			 
	**/
	static var COVER_VERT : js.lib.Float32Array;
	/**
		
			 * U/V for {{#crossLink "StageGL/COVER_VERT:property"}}{{/crossLink}}.
			 
	**/
	static var COVER_UV : js.lib.Float32Array;
	/**
		
			 * Flipped U/V for {{#crossLink "StageGL:COVER_VERT:property"}}{{/crossLink}}.
			 
	**/
	static var COVER_UV_FLIP : js.lib.Float32Array;
	/**
		
			 * Portion of the shader that contains the "varying" properties required in both vertex and fragment shaders. The
			 * regular shader is designed to render all expected objects. Shader code may contain templates that are replaced
			 * pre-compile.
			 
	**/
	static var REGULAR_VARYING_HEADER : String;
	/**
		
			 * Actual full header for the vertex shader. Includes the varying header. The regular shader is designed to render
			 * all expected objects. Shader code may contain templates that are replaced pre-compile.
			 
	**/
	static var REGULAR_VERTEX_HEADER : String;
	/**
		
			 * Actual full header for the fragment shader. Includes the varying header. The regular shader is designed to render
			 * all expected objects. Shader code may contain templates that are replaced pre-compile.
			 
	**/
	static var REGULAR_FRAGMENT_HEADER : String;
	/**
		
			 * Body of the vertex shader. The regular shader is designed to render all expected objects. Shader code may contain
			 * templates that are replaced pre-compile.
			 
	**/
	static var REGULAR_VERTEX_BODY : String;
	/**
		
			 * Body of the fragment shader. The regular shader is designed to render all expected objects. Shader code may
			 * contain templates that are replaced pre-compile.
			 
	**/
	static var REGULAR_FRAGMENT_BODY : String;
	static var PARTICLE_VERTEX_BODY : String;
	static var PARTICLE_FRAGMENT_BODY : String;
	/**
		
			 * Portion of the shader that contains the "varying" properties required in both vertex and fragment shaders. The
			 * cover shader is designed to be a simple vertex/uv only texture render that covers the render surface. Shader
			 * code may contain templates that are replaced pre-compile.
			 
	**/
	static var COVER_VARYING_HEADER : String;
	/**
		
			 * Actual full header for the vertex shader. Includes the varying header. The cover shader is designed to be a
			 * simple vertex/uv only texture render that covers the render surface. Shader code may contain templates that are
			 * replaced pre-compile.
			 
	**/
	static var COVER_VERTEX_HEADER : String;
	/**
		
			 * Actual full header for the fragment shader. Includes the varying header. The cover shader is designed to be a
			 * simple vertex/uv only texture render that covers the render surface. Shader code may contain templates that are
			 * replaced pre-compile.
			 
	**/
	static var COVER_FRAGMENT_HEADER : String;
	/**
		
			 * Body of the vertex shader. The cover shader is designed to be a simple vertex/uv only texture render that covers
			 * the render surface. Shader code may contain templates that are replaced pre-compile.
			 
	**/
	static var COVER_VERTEX_BODY : String;
	/**
		
			 * Body of the fragment shader. The cover shader is designed to be a simple vertex/uv only texture render that
			 * covers the render surface. Shader code may contain templates that are replaced pre-compile.
			 
	**/
	static var COVER_FRAGMENT_BODY : String;
	/**
		
			 * Calculate the U/V co-ordinate based info for sprite frames. Instead of pixel count it uses a 0-1 space. Also includes
			 * the ability to get info back for a specific frame, or only calculate that one frame.
			 * 
			 *     //generate UV rects for all entries
			 *     StageGL.buildUVRects( spriteSheetA );
			 *     //generate all, fetch the first
			 *     var firstFrame = StageGL.buildUVRects( spriteSheetB, 0 );
			 *     //generate the rect for just a single frame for performance's sake
			 *     var newFrame = StageGL.buildUVRects( dynamicSpriteSheet, newFrameIndex, true );
			 * 
			 * NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
			 
	**/
	static function buildUVRects(spritesheet:easeljs.display.SpriteSheet, ?target:Int, ?onlyTarget:Bool):Dynamic;
	/**
		
			 * Test a context to see if it has WebGL enabled on it.
			 
	**/
	static function isWebGLActive(ctx:js.html.CanvasRenderingContext2D):Bool;
}
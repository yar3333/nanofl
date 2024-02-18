package js.html.webgl.extension;

/**
 The `WEBGL_debug_renderer_info` extension is part of the WebGL API and exposes two constants with information about the graphics driver for debugging purposes.
 
 Documentation [WEBGL_debug_renderer_info](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_debug_renderer_info) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_debug_renderer_info$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_debug_renderer_info>
 */
/**
	
		The `WEBGL_debug_renderer_info` extension is part of the WebGL API and exposes two constants with information about the graphics driver for debugging purposes.
	
		Documentation [WEBGL_debug_renderer_info](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_debug_renderer_info) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_debug_renderer_info$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_debug_renderer_info>
	
**/
@:native("WEBGL_debug_renderer_info") extern class WEBGLDebugRendererInfo {
	static var UNMASKED_VENDOR_WEBGL(default, never) : Int;
	static var UNMASKED_RENDERER_WEBGL(default, never) : Int;
}
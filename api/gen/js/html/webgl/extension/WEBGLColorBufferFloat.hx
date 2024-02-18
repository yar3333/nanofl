package js.html.webgl.extension;

/**
 The `WEBGL_color_buffer_float` extension is part of the WebGL API and adds the ability to render to 32-bit floating-point color buffers.
 
 Documentation [WEBGL_color_buffer_float](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_color_buffer_float) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_color_buffer_float$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_color_buffer_float>
 */
/**
	
		The `WEBGL_color_buffer_float` extension is part of the WebGL API and adds the ability to render to 32-bit floating-point color buffers.
	
		Documentation [WEBGL_color_buffer_float](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_color_buffer_float) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_color_buffer_float$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_color_buffer_float>
	
**/
@:native("WEBGL_color_buffer_float") extern class WEBGLColorBufferFloat {
	/**
		
				RGBA 32-bit floating-point color-renderable format.
			
	**/
	static var RGBA32F_EXT(default, never) : Int;
	/**
		
				RGB 32-bit floating-point color-renderable format.
			
	**/
	static var RGB32F_EXT(default, never) : Int;
	/**
		
				?
			
	**/
	static var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE_EXT(default, never) : Int;
	/**
		
				?
			
	**/
	static var UNSIGNED_NORMALIZED_EXT(default, never) : Int;
}
package js.html.webgl.extension;

/**
 The `EXT_color_buffer_half_float` extension is part of the WebGL API and adds the ability to render to 16-bit floating-point color buffers.
 
 Documentation [EXT_color_buffer_half_float](https://developer.mozilla.org/en-US/docs/Web/API/EXT_color_buffer_half_float) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_color_buffer_half_float$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_color_buffer_half_float>
 */
/**
	
		The `EXT_color_buffer_half_float` extension is part of the WebGL API and adds the ability to render to 16-bit floating-point color buffers.
	
		Documentation [EXT_color_buffer_half_float](https://developer.mozilla.org/en-US/docs/Web/API/EXT_color_buffer_half_float) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_color_buffer_half_float$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_color_buffer_half_float>
	
**/
@:native("EXT_color_buffer_half_float") extern class EXTColorBufferHalfFloat {
	/**
		
				RGBA 16-bit floating-point color-renderable format.
			
	**/
	static var RGBA16F_EXT(default, never) : Int;
	/**
		
				RGB 16-bit floating-point color-renderable format.
			
	**/
	static var RGB16F_EXT(default, never) : Int;
	/**
		
				?
			
	**/
	static var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE_EXT(default, never) : Int;
	/**
		
				?
			
	**/
	static var UNSIGNED_NORMALIZED_EXT(default, never) : Int;
}
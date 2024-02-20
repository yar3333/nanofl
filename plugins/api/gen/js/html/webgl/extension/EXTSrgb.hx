package js.html.webgl.extension;

/**
 The `EXT_sRGB` extension is part of the WebGL API and adds sRGB support to textures and framebuffer objects.
 
 Documentation [EXT_sRGB](https://developer.mozilla.org/en-US/docs/Web/API/EXT_sRGB) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_sRGB$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_sRGB>
 */
/**
	
		The `EXT_sRGB` extension is part of the WebGL API and adds sRGB support to textures and framebuffer objects.
	
		Documentation [EXT_sRGB](https://developer.mozilla.org/en-US/docs/Web/API/EXT_sRGB) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_sRGB$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_sRGB>
	
**/
@:native("EXT_sRGB") extern class EXTSrgb {
	/**
		
				Unsized sRGB format that leaves the precision up to the driver.
			
	**/
	static var SRGB_EXT(default, never) : Int;
	/**
		
				Unsized sRGB format with unsized alpha component.
			
	**/
	static var SRGB_ALPHA_EXT(default, never) : Int;
	/**
		
				Sized (8-bit) sRGB and alpha formats.
			
	**/
	static var SRGB8_ALPHA8_EXT(default, never) : Int;
	/**
		
				Returns the framebuffer color encoding (`gl.LINEAR` or `ext.SRGB_EXT`).
			
	**/
	static var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING_EXT(default, never) : Int;
}
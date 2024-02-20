package js.html.webgl.extension;

/**
 The `WEBGL_compressed_texture_atc` extension is part of the WebGL API and exposes 3 ATC compressed texture formats. ATC is a proprietary compression algorithm for compressing textures on handheld devices.
 
 Documentation [WEBGL_compressed_texture_atc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_atc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_atc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_atc>
 */
/**
	
		The `WEBGL_compressed_texture_atc` extension is part of the WebGL API and exposes 3 ATC compressed texture formats. ATC is a proprietary compression algorithm for compressing textures on handheld devices.
	
		Documentation [WEBGL_compressed_texture_atc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_atc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_atc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_atc>
	
**/
@:native("WEBGL_compressed_texture_atc") extern class WEBGLCompressedTextureAtc {
	/**
		
				Compresses RGB textures with no alpha channel.
			
	**/
	static var COMPRESSED_RGB_ATC_WEBGL(default, never) : Int;
	/**
		
				Compresses RGBA textures using explicit alpha encoding (useful when alpha transitions are sharp).
			
	**/
	static var COMPRESSED_RGBA_ATC_EXPLICIT_ALPHA_WEBGL(default, never) : Int;
	/**
		
				Compresses RGBA textures using interpolated alpha encoding (useful when alpha transitions are gradient).
			
	**/
	static var COMPRESSED_RGBA_ATC_INTERPOLATED_ALPHA_WEBGL(default, never) : Int;
}
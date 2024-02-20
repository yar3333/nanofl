package js.html.webgl.extension;

/**
 The `WEBGL_compressed_texture_pvrtc` extension is part of the WebGL API and exposes four PVRTC compressed texture formats.
 
 Documentation [WEBGL_compressed_texture_pvrtc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_pvrtc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_pvrtc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_pvrtc>
 */
/**
	
		The `WEBGL_compressed_texture_pvrtc` extension is part of the WebGL API and exposes four PVRTC compressed texture formats.
	
		Documentation [WEBGL_compressed_texture_pvrtc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_pvrtc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_pvrtc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_pvrtc>
	
**/
@:native("WEBGL_compressed_texture_pvrtc") extern class WEBGLCompressedTexturePvrtc {
	/**
		
				RGB compression in 4-bit mode. One block for each 4×4 pixels.
			
	**/
	static var COMPRESSED_RGB_PVRTC_4BPPV1_IMG(default, never) : Int;
	/**
		
				RGB compression in 2-bit mode. One block for each 8×4 pixels.
			
	**/
	static var COMPRESSED_RGB_PVRTC_2BPPV1_IMG(default, never) : Int;
	/**
		
				RGBA compression in 4-bit mode. One block for each 4×4 pixels.
			
	**/
	static var COMPRESSED_RGBA_PVRTC_4BPPV1_IMG(default, never) : Int;
	/**
		
				RGBA compression in 2-bit mode. One block for each 8×4 pixels.
			
	**/
	static var COMPRESSED_RGBA_PVRTC_2BPPV1_IMG(default, never) : Int;
}
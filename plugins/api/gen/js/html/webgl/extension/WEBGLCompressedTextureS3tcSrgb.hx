package js.html.webgl.extension;

/**
 The `WEBGL_compressed_texture_s3tc_srgb` extension is part of the WebGL API and exposes four S3TC compressed texture formats for the sRGB colorspace.
 
 Documentation [WEBGL_compressed_texture_s3tc_srgb](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc_srgb) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc_srgb$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc_srgb>
 */
/**
	
		The `WEBGL_compressed_texture_s3tc_srgb` extension is part of the WebGL API and exposes four S3TC compressed texture formats for the sRGB colorspace.
	
		Documentation [WEBGL_compressed_texture_s3tc_srgb](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc_srgb) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc_srgb$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc_srgb>
	
**/
@:native("WEBGL_compressed_texture_s3tc_srgb") extern class WEBGLCompressedTextureS3tcSrgb {
	/**
		
				A DXT1-compressed image in an sRGB image format.
			
	**/
	static var COMPRESSED_SRGB_S3TC_DXT1_EXT(default, never) : Int;
	/**
		
				A DXT1-compressed image in an sRGB image format with a simple on/off alpha value.
			
	**/
	static var COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT(default, never) : Int;
	/**
		
				A DXT3-compressed image in an sRGBA image format.
			
	**/
	static var COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT(default, never) : Int;
	/**
		
				A DXT5-compressed image in an sRGBA image format.
			
	**/
	static var COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT(default, never) : Int;
}
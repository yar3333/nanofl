package js.html.webgl.extension;

/**
 The `WEBGL_compressed_texture_s3tc` extension is part of the WebGL API and exposes four S3TC compressed texture formats.
 
 Documentation [WEBGL_compressed_texture_s3tc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc>
 */
/**
	
		The `WEBGL_compressed_texture_s3tc` extension is part of the WebGL API and exposes four S3TC compressed texture formats.
	
		Documentation [WEBGL_compressed_texture_s3tc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_s3tc>
	
**/
@:native("WEBGL_compressed_texture_s3tc") extern class WEBGLCompressedTextureS3tc {
	/**
		
				A DXT1-compressed image in an RGB image format.
			
	**/
	static var COMPRESSED_RGB_S3TC_DXT1_EXT(default, never) : Int;
	/**
		
				A DXT1-compressed image in an RGB image format with a simple on/off alpha value.
			
	**/
	static var COMPRESSED_RGBA_S3TC_DXT1_EXT(default, never) : Int;
	/**
		
				A DXT3-compressed image in an RGBA image format. Compared to a 32-bit RGBA texture, it offers 4:1 compression.
			
	**/
	static var COMPRESSED_RGBA_S3TC_DXT3_EXT(default, never) : Int;
	/**
		
				A DXT5-compressed image in an RGBA image format. It also provides a 4:1 compression, but differs to the DXT3 compression in how the alpha compression is done.
			
	**/
	static var COMPRESSED_RGBA_S3TC_DXT5_EXT(default, never) : Int;
}
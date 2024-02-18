package js.html.webgl.extension;

/**
 The `WEBGL_compressed_texture_etc` extension is part of the WebGL API and exposes 10 ETC/EAC compressed texture formats.
 
 Documentation [WEBGL_compressed_texture_etc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_etc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_etc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_etc>
 */
/**
	
		The `WEBGL_compressed_texture_etc` extension is part of the WebGL API and exposes 10 ETC/EAC compressed texture formats.
	
		Documentation [WEBGL_compressed_texture_etc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_etc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_etc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_etc>
	
**/
@:native("WEBGL_compressed_texture_etc") extern class WEBGLCompressedTextureEtc {
	/**
		
				One-channel (red) unsigned format compression.
			
	**/
	static var COMPRESSED_R11_EAC(default, never) : Int;
	/**
		
				One-channel (red) signed format compression.
			
	**/
	static var COMPRESSED_SIGNED_R11_EAC(default, never) : Int;
	/**
		
				Two-channel (red and green) unsigned format compression.
			
	**/
	static var COMPRESSED_RG11_EAC(default, never) : Int;
	/**
		
				Two-channel (red and green) signed format compression.
			
	**/
	static var COMPRESSED_SIGNED_RG11_EAC(default, never) : Int;
	/**
		
				Compresses RGB8 data with no alpha channel.
			
	**/
	static var COMPRESSED_RGB8_ETC2(default, never) : Int;
	/**
		
				Compresses sRGB8 data with no alpha channel.
			
	**/
	static var COMPRESSED_SRGB8_ETC2(default, never) : Int;
	/**
		
				Similar to `RGB8_ETC`, but with ability to punch through the alpha channel, which means to make it completely opaque or transparent.
			
	**/
	static var COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2(default, never) : Int;
	/**
		
				Similar to `SRGB8_ETC`, but with ability to punch through the alpha channel, which means to make it completely opaque or transparent.
			
	**/
	static var COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2(default, never) : Int;
	/**
		
				Compresses RGBA8 data. The RGB part is encoded the same as `RGB_ETC2`, but the alpha part is encoded separately.
			
	**/
	static var COMPRESSED_RGBA8_ETC2_EAC(default, never) : Int;
	/**
		
				Compresses sRGBA8 data. The sRGB part is encoded the same as `SRGB_ETC2`, but the alpha part is encoded separately.
			
	**/
	static var COMPRESSED_SRGB8_ALPHA8_ETC2_EAC(default, never) : Int;
}
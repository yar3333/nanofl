package js.html.webgl.extension;

/**
 The `WEBGL_compressed_texture_astc` extension is part of the WebGL API and exposes Adaptive Scalable Texture Compression (ASTC) compressed texture formats to WebGL.
 
 Documentation [WEBGL_compressed_texture_astc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_astc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_astc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_astc>
 */
/**
	
		The `WEBGL_compressed_texture_astc` extension is part of the WebGL API and exposes Adaptive Scalable Texture Compression (ASTC) compressed texture formats to WebGL.
	
		Documentation [WEBGL_compressed_texture_astc](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_astc) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_astc$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_compressed_texture_astc>
	
**/
@:native("WEBGL_compressed_texture_astc") extern class WEBGLCompressedTextureAstc {
	function getSupportedProfiles():Array<String>;
	static var COMPRESSED_RGBA_ASTC_4x4_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_5x4_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_5x5_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_6x5_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_6x6_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_8x5_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_8x6_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_8x8_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_10x5_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_10x6_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_10x8_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_10x10_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_12x10_KHR(default, never) : Int;
	static var COMPRESSED_RGBA_ASTC_12x12_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_4x4_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_5x4_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_5x5_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_6x5_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_6x6_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x5_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x6_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_8x8_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x5_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x6_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x8_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_10x10_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_12x10_KHR(default, never) : Int;
	static var COMPRESSED_SRGB8_ALPHA8_ASTC_12x12_KHR(default, never) : Int;
}
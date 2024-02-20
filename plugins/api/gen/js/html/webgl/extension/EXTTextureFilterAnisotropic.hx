package js.html.webgl.extension;

/**
 The `EXT_texture_filter_anisotropic` extension is part of the WebGL API and exposes two constants for anisotropic filtering (AF).
 
 Documentation [EXT_texture_filter_anisotropic](https://developer.mozilla.org/en-US/docs/Web/API/EXT_texture_filter_anisotropic) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_texture_filter_anisotropic$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
 
 @see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_texture_filter_anisotropic>
 */
/**
	
		The `EXT_texture_filter_anisotropic` extension is part of the WebGL API and exposes two constants for anisotropic filtering (AF).
	
		Documentation [EXT_texture_filter_anisotropic](https://developer.mozilla.org/en-US/docs/Web/API/EXT_texture_filter_anisotropic) by [Mozilla Contributors](https://developer.mozilla.org/en-US/docs/Web/API/EXT_texture_filter_anisotropic$history), licensed under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/).
	
		@see <https://developer.mozilla.org/en-US/docs/Web/API/EXT_texture_filter_anisotropic>
	
**/
@:native("EXT_texture_filter_anisotropic") extern class EXTTextureFilterAnisotropic {
	/**
		
				This is the `pname` argument to the `WebGLRenderingContext.getTexParameter` and `WebGLRenderingContext.texParameterf` / `WebGLRenderingContext.texParameteri` calls and sets the desired maximum anisotropy for a texture.
			
	**/
	static var TEXTURE_MAX_ANISOTROPY_EXT(default, never) : Int;
	/**
		
				This is the `pname` argument to the `WebGLRenderingContext.getParameter` call, and it returns the maximum available anisotropy.
			
	**/
	static var MAX_TEXTURE_MAX_ANISOTROPY_EXT(default, never) : Int;
}
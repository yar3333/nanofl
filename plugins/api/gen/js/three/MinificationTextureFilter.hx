package js.three;

/**
 * Texture Minification Filter Modes.
 * For use with a texture's {@link THREE.Texture.minFilter | minFilter} property,
 * these define the texture minifying function that is used whenever the pixel being textured maps to an area greater than one texture element (texel).
 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
 * @see {@link https://sbcode.net/threejs/mipmaps/ | Texture Mipmaps (non-official)}
 */
/**
	
	 * Texture Minification Filter Modes.
	 * For use with a texture's {@link THREE.Texture.minFilter | minFilter} property,
	 * these define the texture minifying function that is used whenever the pixel being textured maps to an area greater than one texture element (texel).
	 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
	 * @see {@link https://sbcode.net/threejs/mipmaps/ | Texture Mipmaps (non-official)}
	 
**/
@:enum @:native("THREE") typedef MinificationTextureFilter = Int;
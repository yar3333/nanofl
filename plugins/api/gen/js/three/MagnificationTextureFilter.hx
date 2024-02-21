package js.three;

/**
 * Texture Magnification Filter Modes.
 * For use with a texture's {@link THREE.Texture.magFilter | magFilter} property,
 * these define the texture magnification function to be used when the pixel being textured maps to an area less than or equal to one texture element (texel).
 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
 * @see {@link https://sbcode.net/threejs/mipmaps/ | Texture Mipmaps (non-official)}
 */
/**
	
	* Texture Magnification Filter Modes.
	* For use with a texture's {@link THREE.Texture.magFilter | magFilter} property,
	* these define the texture magnification function to be used when the pixel being textured maps to an area less than or equal to one texture element (texel).
	* @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
	* @see {@link https://sbcode.net/threejs/mipmaps/ | Texture Mipmaps (non-official)}
	
**/
@:enum @:native("THREE") typedef MagnificationTextureFilter = Int;
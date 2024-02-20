package js.three;

/**
 * All Possible Texture Pixel Formats Modes. For any Type or SubType of Textures.
 * @remarks Note that the texture must have the correct {@link THREE.Texture.type} set, as described in {@link TextureDataType}.
 * @see {@link WebGLRenderingContext.texImage2D} for details.
 * @see {@link PixelFormat} and {@link DepthTexturePixelFormat} and {@link CompressedPixelFormat}
 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
 */
/**
	
	 * All Possible Texture Pixel Formats Modes. For any Type or SubType of Textures.
	 * @remarks Note that the texture must have the correct {@link THREE.Texture.type} set, as described in {@link TextureDataType}.
	 * @see {@link WebGLRenderingContext.texImage2D} for details.
	 * @see {@link PixelFormat} and {@link DepthTexturePixelFormat} and {@link CompressedPixelFormat}
	 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
	 
**/
typedef AnyPixelFormat = haxe.extern.EitherType<js.three.PixelFormat, haxe.extern.EitherType<js.three.DepthTexturePixelFormat, js.three.CompressedPixelFormat>>;
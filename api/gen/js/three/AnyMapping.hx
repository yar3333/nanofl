package js.three;

/**
 * Texture Mapping Modes for any type of Textures
 * @see {@link Mapping} and {@link CubeTextureMapping}
 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
 */
/**
	
	 * Texture Mapping Modes for any type of Textures
	 * @see {@link Mapping} and {@link CubeTextureMapping}
	 * @see {@link https://threejs.org/docs/index.html#api/en/constants/Textures | Texture Constants}
	 
**/
typedef AnyMapping = haxe.extern.EitherType<js.three.Mapping, js.three.CubeTextureMapping>;
package js.three.textures;

/**
 * Creates a texture based on data in compressed form, for example from a {@link https://en.wikipedia.org/wiki/DirectDraw_Surface | DDS} file.
 * @remarks For use with the {@link THREE.CompressedTextureLoader | CompressedTextureLoader}.
 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CompressedTexture | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CompressedTexture.js | Source}
 */
/**
	
	 * Creates a texture based on data in compressed form, for example from a {@link https://en.wikipedia.org/wiki/DirectDraw_Surface | DDS} file.
	 * @remarks For use with the {@link THREE.CompressedTextureLoader | CompressedTextureLoader}.
	 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CompressedTexture | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CompressedTexture.js | Source}
	 
**/
@:native("THREE.CompressedTexture") extern class CompressedTexture extends js.three.textures.Texture {
	/**
		
			 * Creates a texture based on data in compressed form, for example from a {@link https://en.wikipedia.org/wiki/DirectDraw_Surface | DDS} file.
			 * @remarks For use with the {@link THREE.CompressedTextureLoader | CompressedTextureLoader}.
			 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CompressedTexture | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CompressedTexture.js | Source}
			 
	**/
	function new(mipmaps:Array<js.html.ImageData>, width:Float, height:Float, format:js.three.CompressedPixelFormat, ?type:js.three.TextureDataType, ?mapping:js.three.Mapping, ?wrapS:js.three.Wrapping, ?wrapT:js.three.Wrapping, ?magFilter:js.three.MagnificationTextureFilter, ?minFilter:js.three.MinificationTextureFilter, ?anisotropy:Int, ?colorSpace:js.three.ColorSpace):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link CompressedTexture}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isCompressedTexture(default, null) : Bool;
}
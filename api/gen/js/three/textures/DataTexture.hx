package js.three.textures;

/**
 * Creates a texture directly from raw data, width and height.
 * @example
 * ```typescript
 * // create a buffer with color data
 * const width = 512;
 * const height = 512;
 * const size = width * height;
 * const data = new Uint8Array(4 * size);
 * const color = new THREE.Color(0xffffff);
 * const r = Math.floor(color.r * 255);
 * const g = Math.floor(color.g * 255);
 * const b = Math.floor(color.b * 255);
 * for (let i = 0; i & lt; size; i++) {
 *     const stride = i * 4;
 *     data[stride] = r;
 *     data[stride + 1] = g;
 *     data[stride + 2] = b;
 *     data[stride + 3] = 255;
 * }
 * // used the buffer to create a [name]
 * const texture = new THREE.DataTexture(data, width, height);
 * texture.needsUpdate = true;
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/textures/DataTexture | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/DataTexture.js | Source}
 */
/**
	
	 * Creates a texture directly from raw data, width and height.
	 * @example
	 * ```typescript
	 * // create a buffer with color data
	 * const width = 512;
	 * const height = 512;
	 * const size = width * height;
	 * const data = new Uint8Array(4 * size);
	 * const color = new THREE.Color(0xffffff);
	 * const r = Math.floor(color.r * 255);
	 * const g = Math.floor(color.g * 255);
	 * const b = Math.floor(color.b * 255);
	 * for (let i = 0; i & lt; size; i++) {
	 *     const stride = i * 4;
	 *     data[stride] = r;
	 *     data[stride + 1] = g;
	 *     data[stride + 2] = b;
	 *     data[stride + 3] = 255;
	 * }
	 * // used the buffer to create a [name]
	 * const texture = new THREE.DataTexture(data, width, height);
	 * texture.needsUpdate = true;
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/textures/DataTexture | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/DataTexture.js | Source}
	 
**/
@:native("THREE.DataTexture") extern class DataTexture extends js.three.textures.Texture {
	/**
		
			 * Creates a texture directly from raw data, width and height.
			 * @example
			 * ```typescript
			 * // create a buffer with color data
			 * const width = 512;
			 * const height = 512;
			 * const size = width * height;
			 * const data = new Uint8Array(4 * size);
			 * const color = new THREE.Color(0xffffff);
			 * const r = Math.floor(color.r * 255);
			 * const g = Math.floor(color.g * 255);
			 * const b = Math.floor(color.b * 255);
			 * for (let i = 0; i & lt; size; i++) {
			 *     const stride = i * 4;
			 *     data[stride] = r;
			 *     data[stride + 1] = g;
			 *     data[stride + 2] = b;
			 *     data[stride + 3] = 255;
			 * }
			 * // used the buffer to create a [name]
			 * const texture = new THREE.DataTexture(data, width, height);
			 * texture.needsUpdate = true;
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/textures/DataTexture | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/DataTexture.js | Source}
			 
	**/
	function new(?data:js.lib.BufferSource, ?width:Float, ?height:Float, ?format:js.three.PixelFormat, ?type:js.three.TextureDataType, ?mapping:js.three.Mapping, ?wrapS:js.three.Wrapping, ?wrapT:js.three.Wrapping, ?magFilter:js.three.MagnificationTextureFilter, ?minFilter:js.three.MinificationTextureFilter, ?anisotropy:Int, ?colorSpace:js.three.ColorSpace):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link DataTexture}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isDataTexture(default, null) : Bool;
}
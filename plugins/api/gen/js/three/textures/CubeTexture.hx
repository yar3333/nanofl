package js.three.textures;

/**
 * Creates a cube texture made up of six images.
 * @remarks
 * {@link CubeTexture} is almost equivalent in functionality and usage to {@link Texture}.
 * The only differences are that the images are an array of _6_ images as opposed to a single image,
 * and the mapping options are {@link THREE.CubeReflectionMapping} (default) or {@link THREE.CubeRefractionMapping}
 * @example
 * ```typescript
 * const loader = new THREE.CubeTextureLoader();
 * loader.setPath('textures/cube/pisa/');
 * const textureCube = loader.load(['px.png', 'nx.png', 'py.png', 'ny.png', 'pz.png', 'nz.png']);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffffff,
 *     envMap: textureCube
 * });
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CubeTexture | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CubeTexture.js | Source}
 */
/**
	
	 * Creates a cube texture made up of six images.
	 * @remarks
	 * {@link CubeTexture} is almost equivalent in functionality and usage to {@link Texture}.
	 * The only differences are that the images are an array of _6_ images as opposed to a single image,
	 * and the mapping options are {@link THREE.CubeReflectionMapping} (default) or {@link THREE.CubeRefractionMapping}
	 * @example
	 * ```typescript
	 * const loader = new THREE.CubeTextureLoader();
	 * loader.setPath('textures/cube/pisa/');
	 * const textureCube = loader.load(['px.png', 'nx.png', 'py.png', 'ny.png', 'pz.png', 'nz.png']);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffffff,
	 *     envMap: textureCube
	 * });
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CubeTexture | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CubeTexture.js | Source}
	 
**/
@:native("THREE.CubeTexture") extern class CubeTexture extends js.three.textures.Texture {
	/**
		
			 * Creates a cube texture made up of six images.
			 * @remarks
			 * {@link CubeTexture} is almost equivalent in functionality and usage to {@link Texture}.
			 * The only differences are that the images are an array of _6_ images as opposed to a single image,
			 * and the mapping options are {@link THREE.CubeReflectionMapping} (default) or {@link THREE.CubeRefractionMapping}
			 * @example
			 * ```typescript
			 * const loader = new THREE.CubeTextureLoader();
			 * loader.setPath('textures/cube/pisa/');
			 * const textureCube = loader.load(['px.png', 'nx.png', 'py.png', 'ny.png', 'pz.png', 'nz.png']);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffffff,
			 *     envMap: textureCube
			 * });
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/textures/CubeTexture | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/textures/CubeTexture.js | Source}
			 
	**/
	function new(?images:Array<Dynamic>, ?mapping:js.three.CubeTextureMapping, ?wrapS:js.three.Wrapping, ?wrapT:js.three.Wrapping, ?magFilter:js.three.MagnificationTextureFilter, ?minFilter:js.three.MinificationTextureFilter, ?format:js.three.PixelFormat, ?type:js.three.TextureDataType, ?anisotropy:Int, ?colorSpace:js.three.ColorSpace):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link CubeTexture}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isCubeTexture(default, null) : Bool;
}
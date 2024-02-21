package js.three.lights;

/**
 * This light globally illuminates all objects in the scene equally.
 * @remarks This light cannot be used to cast shadows as it does not have a direction.
 * @example
 * ```typescript
 * const light = new THREE.AmbientLight(0x404040); // soft white light
 * scene.add(light);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/lights/AmbientLight | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/AmbientLight.js | Source}
 */
/**
	
	 * This light globally illuminates all objects in the scene equally.
	 * @remarks This light cannot be used to cast shadows as it does not have a direction.
	 * @example
	 * ```typescript
	 * const light = new THREE.AmbientLight(0x404040); // soft white light
	 * scene.add(light);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/lights/AmbientLight | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/AmbientLight.js | Source}
	 
**/
@:native("THREE.AmbientLight") extern class AmbientLight extends js.three.lights.Light<{ }> {
	/**
		
			 * This light globally illuminates all objects in the scene equally.
			 * @remarks This light cannot be used to cast shadows as it does not have a direction.
			 * @example
			 * ```typescript
			 * const light = new THREE.AmbientLight(0x404040); // soft white light
			 * scene.add(light);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/lights/AmbientLight | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/AmbientLight.js | Source}
			 
	**/
	function new(?color:js.three.math.ColorRepresentation, ?intensity:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link AmbientLight}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isAmbientLight(default, null) : Bool;
}
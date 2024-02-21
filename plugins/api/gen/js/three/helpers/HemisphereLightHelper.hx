package js.three.helpers;

/**
 * Creates a visual aid consisting of a spherical {@link THREE.Mesh | Mesh} for a {@link THREE.HemisphereLight | HemisphereLight}.
 * @example
 * ```typescript
 * const light = new THREE.HemisphereLight(0xffffbb, 0x080820, 1);
 * const helper = new THREE.HemisphereLightHelper(light, 5);
 * scene.add(helper);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/HemisphereLightHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/HemisphereLightHelper.js | Source}
 */
/**
	
	 * Creates a visual aid consisting of a spherical {@link THREE.Mesh | Mesh} for a {@link THREE.HemisphereLight | HemisphereLight}.
	 * @example
	 * ```typescript
	 * const light = new THREE.HemisphereLight(0xffffbb, 0x080820, 1);
	 * const helper = new THREE.HemisphereLightHelper(light, 5);
	 * scene.add(helper);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/HemisphereLightHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/HemisphereLightHelper.js | Source}
	 
**/
@:native("THREE.HemisphereLightHelper") extern class HemisphereLightHelper extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
			 * Creates a visual aid consisting of a spherical {@link THREE.Mesh | Mesh} for a {@link THREE.HemisphereLight | HemisphereLight}.
			 * @example
			 * ```typescript
			 * const light = new THREE.HemisphereLight(0xffffbb, 0x080820, 1);
			 * const helper = new THREE.HemisphereLightHelper(light, 5);
			 * scene.add(helper);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/HemisphereLightHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/HemisphereLightHelper.js | Source}
			 
	**/
	function new(light:js.three.lights.HemisphereLight, size:Float, ?color:js.three.math.ColorRepresentation):Void;
	/**
		
			 * Reference to the HemisphereLight being visualized.
			 
	**/
	var light : js.three.lights.HemisphereLight;
	/**
		
		     * Is set to `false`, as the helper is using the {@link THREE.HemisphereLight.matrixWorld | light.matrixWorld}.
		     * @see {@link THREE.Object3D.matrixAutoUpdate | Object3D.matrixAutoUpdate}.
		     * @defaultValue `false`.
		     
	**/
	var material : js.three.materials.MeshBasicMaterial;
	/**
		
			 * The color parameter passed in the constructor.
			 * @remarks If this is changed, the helper's color will update the next time {@link update} is called.
			 * @defaultValue `undefined`
			 
	**/
	var color : haxe.extern.EitherType<js.three.math.ColorRepresentation, { }>;
	/**
		
			 * Updates the helper to match the position and direction of the {@link .light | HemisphereLight}.
			 
	**/
	function update():Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
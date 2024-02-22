package js.three.helpers;

/**
 * Helper object to assist with visualizing a {@link THREE.DirectionalLight | DirectionalLight}'s effect on the scene
 * @remarks
 * This consists of plane and a line representing the light's position and direction.
 * @example
 * ```typescript
 * const light = new THREE.DirectionalLight(0xFFFFFF);
 * scene.add(light);
 *
 * const helper = new THREE.DirectionalLightHelper(light, 5);
 * scene.add(helper);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/DirectionalLightHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/DirectionalLightHelper.js | Source}
 */
/**
	
	 * Helper object to assist with visualizing a {@link THREE.DirectionalLight | DirectionalLight}'s effect on the scene
	 * @remarks
	 * This consists of plane and a line representing the light's position and direction.
	 * @example
	 * ```typescript
	 * const light = new THREE.DirectionalLight(0xFFFFFF);
	 * scene.add(light);
	 * 
	 * const helper = new THREE.DirectionalLightHelper(light, 5);
	 * scene.add(helper);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/DirectionalLightHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/DirectionalLightHelper.js | Source}
	 
**/
@:native("THREE.DirectionalLightHelper") extern class DirectionalLightHelper extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
			 * Helper object to assist with visualizing a {@link THREE.DirectionalLight | DirectionalLight}'s effect on the scene
			 * @remarks
			 * This consists of plane and a line representing the light's position and direction.
			 * @example
			 * ```typescript
			 * const light = new THREE.DirectionalLight(0xFFFFFF);
			 * scene.add(light);
			 * 
			 * const helper = new THREE.DirectionalLightHelper(light, 5);
			 * scene.add(helper);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/DirectionalLightHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/DirectionalLightHelper.js | Source}
			 
	**/
	function new(light:js.three.lights.DirectionalLight, ?size:Float, ?color:js.three.math.ColorRepresentation):Void;
	/**
		
			 * Contains the line mesh showing the location of the directional light.
			 
	**/
	var lightPlane : js.three.objects.Line<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap>;
	/**
		
			 * Reference to the {@link THREE.DirectionalLight | directionalLight} being visualized.
			 
	**/
	var light : js.three.lights.DirectionalLight;
	/**
		
			 * The color parameter passed in the constructor.
			 * @remarks If this is changed, the helper's color will update the next time {@link update} is called.
			 * @defaultValue `undefined`
			 
	**/
	var color : haxe.extern.EitherType<js.three.math.ColorRepresentation, { }>;
	var targetLine : js.three.objects.Line<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap>;
	/**
		
			 * Updates the helper to match the position and direction of the {@link light | DirectionalLight} being visualized.
			 
	**/
	function update():Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
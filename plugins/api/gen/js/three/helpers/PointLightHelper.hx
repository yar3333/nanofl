package js.three.helpers;

/**
 * This displays a helper object consisting of a spherical {@link THREE.Mesh | Mesh} for visualizing a {@link THREE.PointLight | PointLight}.
 * @example
 * ```typescript
 * const pointLight = new THREE.PointLight(0xff0000, 1, 100);
 * pointLight.position.set(10, 10, 10);
 * scene.add(pointLight);
 * const sphereSize = 1;
 * const {@link PointLightHelper} = new THREE.PointLightHelper(pointLight, sphereSize);
 * scene.add(pointLightHelper);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | WebGL / helpers}
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/PointLightHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/PointLightHelper.js | Source}
 */
/**
	
	 * This displays a helper object consisting of a spherical {@link THREE.Mesh | Mesh} for visualizing a {@link THREE.PointLight | PointLight}.
	 * @example
	 * ```typescript
	 * const pointLight = new THREE.PointLight(0xff0000, 1, 100);
	 * pointLight.position.set(10, 10, 10);
	 * scene.add(pointLight);
	 * const sphereSize = 1;
	 * const {@link PointLightHelper} = new THREE.PointLightHelper(pointLight, sphereSize);
	 * scene.add(pointLightHelper);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | WebGL / helpers}
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/PointLightHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/PointLightHelper.js | Source}
	 
**/
@:native("THREE.PointLightHelper") extern class PointLightHelper extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
			 * This displays a helper object consisting of a spherical {@link THREE.Mesh | Mesh} for visualizing a {@link THREE.PointLight | PointLight}.
			 * @example
			 * ```typescript
			 * const pointLight = new THREE.PointLight(0xff0000, 1, 100);
			 * pointLight.position.set(10, 10, 10);
			 * scene.add(pointLight);
			 * const sphereSize = 1;
			 * const {@link PointLightHelper} = new THREE.PointLightHelper(pointLight, sphereSize);
			 * scene.add(pointLightHelper);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | WebGL / helpers}
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/PointLightHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/PointLightHelper.js | Source}
			 
	**/
	function new(light:js.three.lights.PointLight, ?sphereSize:Float, ?color:js.three.math.ColorRepresentation):Void;
	/**
		
			 * The {@link THREE.PointLight | PointLight} that is being visualized.
			 
	**/
	var light : js.three.lights.PointLight;
	/**
		
			 * The color parameter passed in the constructor.
			 * @remarks If this is changed, the helper's color will update the next time {@link update} is called.
			 * @defaultValue `undefined`
			 
	**/
	var color : js.three.math.ColorRepresentation;
	/**
		
			 * Updates the helper to match the position of the {@link THREE..light | .light}.
			 
	**/
	function update():Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
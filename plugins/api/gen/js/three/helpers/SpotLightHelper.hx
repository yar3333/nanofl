package js.three.helpers;

/**
 * This displays a cone shaped helper object for a {@link THREE.SpotLight | SpotLight}.
 * @example
 * ```typescript
 * const spotLight = new THREE.SpotLight(0xffffff);
 * spotLight.position.set(10, 10, 10);
 * scene.add(spotLight);
 * const {@link SpotLightHelper} = new THREE.SpotLightHelper(spotLight);
 * scene.add(spotLightHelper);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlights | WebGL/ lights / spotlights }
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/SpotLightHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/SpotLightHelper.js | Source}
 */
/**
	
	 * This displays a cone shaped helper object for a {@link THREE.SpotLight | SpotLight}.
	 * @example
	 * ```typescript
	 * const spotLight = new THREE.SpotLight(0xffffff);
	 * spotLight.position.set(10, 10, 10);
	 * scene.add(spotLight);
	 * const {@link SpotLightHelper} = new THREE.SpotLightHelper(spotLight);
	 * scene.add(spotLightHelper);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlights | WebGL/ lights / spotlights }
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/SpotLightHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/SpotLightHelper.js | Source}
	 
**/
@:native("THREE.SpotLightHelper") extern class SpotLightHelper extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
			 * This displays a cone shaped helper object for a {@link THREE.SpotLight | SpotLight}.
			 * @example
			 * ```typescript
			 * const spotLight = new THREE.SpotLight(0xffffff);
			 * spotLight.position.set(10, 10, 10);
			 * scene.add(spotLight);
			 * const {@link SpotLightHelper} = new THREE.SpotLightHelper(spotLight);
			 * scene.add(spotLightHelper);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlights | WebGL/ lights / spotlights }
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/SpotLightHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/SpotLightHelper.js | Source}
			 
	**/
	function new(light:js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>>, ?color:js.three.math.ColorRepresentation):Void;
	/**
		
			 * {@link THREE.LineSegments | LineSegments} used to visualize the light.
			 
	**/
	var cone : js.three.objects.LineSegments<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap>;
	/**
		
			 * Reference to the {@link THREE.SpotLight | SpotLight} being visualized.
			 
	**/
	var light : js.three.lights.Light<haxe.extern.EitherType<js.three.lights.LightShadow<js.three.cameras.Camera>, { }>>;
	/**
		
			 * The color parameter passed in the constructor.
			 * If this is changed, the helper's color will update the next time {@link SpotLightHelper.update | update} is called.
			 * @defaultValue `undefined`
			 
	**/
	var color : haxe.extern.EitherType<js.three.math.ColorRepresentation, { }>;
	/**
		
			 * Updates the light helper.
			 
	**/
	function update():Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
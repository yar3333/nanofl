package js.three.lights;

/**
 * A light source positioned directly above the scene, with color fading from the sky color to the ground color.
 * @remarks This light cannot be used to cast shadows.
 * @example
 * ```typescript
 * const light = new THREE.HemisphereLight(0xffffbb, 0x080820, 1);
 * scene.add(light);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_blending | animation / skinning / blending }
 * @see Example: {@link https://threejs.org/examples/#webgl_lights_hemisphere | lights / hemisphere }
 * @see Example: {@link https://threejs.org/examples/#misc_controls_pointerlock | controls / pointerlock }
 * @see Example: {@link https://threejs.org/examples/#webgl_loader_collada_kinematics | loader / collada / kinematics }
 * @see Example: {@link https://threejs.org/examples/#webgl_loader_stl | loader / stl }
 * @see {@link https://threejs.org/docs/index.html#api/en/lights/HemisphereLight | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/HemisphereLight.js | Source}
 */
/**
	
	 * A light source positioned directly above the scene, with color fading from the sky color to the ground color.
	 * @remarks This light cannot be used to cast shadows.
	 * @example
	 * ```typescript
	 * const light = new THREE.HemisphereLight(0xffffbb, 0x080820, 1);
	 * scene.add(light);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_blending | animation / skinning / blending }
	 * @see Example: {@link https://threejs.org/examples/#webgl_lights_hemisphere | lights / hemisphere }
	 * @see Example: {@link https://threejs.org/examples/#misc_controls_pointerlock | controls / pointerlock }
	 * @see Example: {@link https://threejs.org/examples/#webgl_loader_collada_kinematics | loader / collada / kinematics }
	 * @see Example: {@link https://threejs.org/examples/#webgl_loader_stl | loader / stl }
	 * @see {@link https://threejs.org/docs/index.html#api/en/lights/HemisphereLight | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/HemisphereLight.js | Source}
	 
**/
@:native("THREE.HemisphereLight") extern class HemisphereLight extends js.three.lights.Light<{ }> {
	/**
		
			 * A light source positioned directly above the scene, with color fading from the sky color to the ground color.
			 * @remarks This light cannot be used to cast shadows.
			 * @example
			 * ```typescript
			 * const light = new THREE.HemisphereLight(0xffffbb, 0x080820, 1);
			 * scene.add(light);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_blending | animation / skinning / blending }
			 * @see Example: {@link https://threejs.org/examples/#webgl_lights_hemisphere | lights / hemisphere }
			 * @see Example: {@link https://threejs.org/examples/#misc_controls_pointerlock | controls / pointerlock }
			 * @see Example: {@link https://threejs.org/examples/#webgl_loader_collada_kinematics | loader / collada / kinematics }
			 * @see Example: {@link https://threejs.org/examples/#webgl_loader_stl | loader / stl }
			 * @see {@link https://threejs.org/docs/index.html#api/en/lights/HemisphereLight | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/HemisphereLight.js | Source}
			 
	**/
	function new(?skyColor:js.three.math.ColorRepresentation, ?groundColor:js.three.math.ColorRepresentation, ?intensity:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link HemisphereLight}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isHemisphereLight(default, null) : Bool;
	/**
		
			 * The light's ground color, as passed in the constructor.
			 * @defaultValue `new THREE.Color()` set to white _(0xffffff)_.
			 
	**/
	var groundColor : js.three.math.Color;
}
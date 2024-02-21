package js.three.lights;

/**
 * A light that gets emitted from a single point in all directions
 * @remarks
 * A common use case for this is to replicate the light emitted from a bare lightbulb.
 * @example
 * ```typescript
 * const light = new THREE.PointLight(0xff0000, 1, 100);
 * light.position.set(50, 50, 50);
 * scene.add(light);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_lights_pointlights | lights / pointlights }
 * @see Example: {@link https://threejs.org/examples/#webgl_effects_anaglyph | effects / anaglyph }
 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_text | geometry / text }
 * @see Example: {@link https://threejs.org/examples/#webgl_lensflares | lensflares }
 * @see {@link https://threejs.org/docs/index.html#api/en/lights/PointLight | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/PointLight.js | Source}
 */
/**
	
	 * A light that gets emitted from a single point in all directions
	 * @remarks
	 * A common use case for this is to replicate the light emitted from a bare lightbulb.
	 * @example
	 * ```typescript
	 * const light = new THREE.PointLight(0xff0000, 1, 100);
	 * light.position.set(50, 50, 50);
	 * scene.add(light);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_lights_pointlights | lights / pointlights }
	 * @see Example: {@link https://threejs.org/examples/#webgl_effects_anaglyph | effects / anaglyph }
	 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_text | geometry / text }
	 * @see Example: {@link https://threejs.org/examples/#webgl_lensflares | lensflares }
	 * @see {@link https://threejs.org/docs/index.html#api/en/lights/PointLight | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/PointLight.js | Source}
	 
**/
@:native("THREE.PointLight") extern class PointLight extends js.three.lights.Light<js.three.lights.PointLightShadow> {
	/**
		
			 * A light that gets emitted from a single point in all directions
			 * @remarks
			 * A common use case for this is to replicate the light emitted from a bare lightbulb.
			 * @example
			 * ```typescript
			 * const light = new THREE.PointLight(0xff0000, 1, 100);
			 * light.position.set(50, 50, 50);
			 * scene.add(light);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_lights_pointlights | lights / pointlights }
			 * @see Example: {@link https://threejs.org/examples/#webgl_effects_anaglyph | effects / anaglyph }
			 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_text | geometry / text }
			 * @see Example: {@link https://threejs.org/examples/#webgl_lensflares | lensflares }
			 * @see {@link https://threejs.org/docs/index.html#api/en/lights/PointLight | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/PointLight.js | Source}
			 
	**/
	function new(?color:js.three.math.ColorRepresentation, ?intensity:Float, ?distance:Float, ?decay:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link PointLight}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isPointLight(default, null) : Bool;
	/**
		
			 * When **Default mode** — When distance is zero, light does not attenuate. When distance is non-zero,
			 * light will attenuate linearly from maximum intensity at the light's position down to zero at this distance from the light.
			 * 
			 * When **{@link WebGLRenderer.useLegacyLights | legacy lighting mode} is disabled** — When distance is zero,
			 * light will attenuate according to inverse-square law to infinite distance.
			 * When distance is non-zero, light will attenuate according to inverse-square law until near the distance cutoff,
			 * where it will then attenuate quickly and smoothly to 0. Inherently, cutoffs are not physically correct.
			 * 
			 * @defaultValue `0.0`
			 * @remarks Expects a `Float`
			 
	**/
	var distance : Float;
	/**
		
			 * The amount the light dims along the distance of the light.
			 * In context of physically-correct rendering the default value should not be changed.
			 * @remarks Expects a `Float`
			 * @defaultValue `2`
			 
	**/
	var decay : Float;
	/**
		
			 * The light's power.
			 * When **{@link WebGLRenderer.useLegacyLights | legacy lighting mode} is disabled** — power is the luminous power of the light measured in lumens (lm).
			 * @remarks Changing the power will also change the light's intensity.
			 * @remarks Expects a `Float`
			 
	**/
	var power : Float;
}
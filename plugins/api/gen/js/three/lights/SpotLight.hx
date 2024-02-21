package js.three.lights;

/**
 * This light gets emitted from a single point in one direction, along a cone that increases in size the further from the light it gets.
 * @example
 * ```typescript
 * // white {@link SpotLight} shining from the side, modulated by a texture, casting a shadow
 * const {@link SpotLight} = new THREE.SpotLight(0xffffff);
 * spotLight.position.set(100, 1000, 100);
 * spotLight.map = new THREE.TextureLoader().load(url);
 * spotLight.castShadow = true;
 * spotLight.shadow.mapSize.width = 1024;
 * spotLight.shadow.mapSize.height = 1024;
 * spotLight.shadow.camera.near = 500;
 * spotLight.shadow.camera.far = 4000;
 * spotLight.shadow.camera.fov = 30;
 * scene.add(spotLight);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlight | lights / {@link SpotLight} }
 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlights | lights / spotlights }
 * @see {@link https://threejs.org/docs/index.html#api/en/lights/SpotLight | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/SpotLight.js | Source}
 */
/**
	
	 * This light gets emitted from a single point in one direction, along a cone that increases in size the further from the light it gets.
	 * @example
	 * ```typescript
	 * // white {@link SpotLight} shining from the side, modulated by a texture, casting a shadow
	 * const {@link SpotLight} = new THREE.SpotLight(0xffffff);
	 * spotLight.position.set(100, 1000, 100);
	 * spotLight.map = new THREE.TextureLoader().load(url);
	 * spotLight.castShadow = true;
	 * spotLight.shadow.mapSize.width = 1024;
	 * spotLight.shadow.mapSize.height = 1024;
	 * spotLight.shadow.camera.near = 500;
	 * spotLight.shadow.camera.far = 4000;
	 * spotLight.shadow.camera.fov = 30;
	 * scene.add(spotLight);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlight | lights / {@link SpotLight} }
	 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlights | lights / spotlights }
	 * @see {@link https://threejs.org/docs/index.html#api/en/lights/SpotLight | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/SpotLight.js | Source}
	 
**/
@:native("THREE.SpotLight") extern class SpotLight extends js.three.lights.Light<js.three.lights.SpotLightShadow> {
	/**
		
			 * This light gets emitted from a single point in one direction, along a cone that increases in size the further from the light it gets.
			 * @example
			 * ```typescript
			 * // white {@link SpotLight} shining from the side, modulated by a texture, casting a shadow
			 * const {@link SpotLight} = new THREE.SpotLight(0xffffff);
			 * spotLight.position.set(100, 1000, 100);
			 * spotLight.map = new THREE.TextureLoader().load(url);
			 * spotLight.castShadow = true;
			 * spotLight.shadow.mapSize.width = 1024;
			 * spotLight.shadow.mapSize.height = 1024;
			 * spotLight.shadow.camera.near = 500;
			 * spotLight.shadow.camera.far = 4000;
			 * spotLight.shadow.camera.fov = 30;
			 * scene.add(spotLight);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlight | lights / {@link SpotLight} }
			 * @see Example: {@link https://threejs.org/examples/#webgl_lights_spotlights | lights / spotlights }
			 * @see {@link https://threejs.org/docs/index.html#api/en/lights/SpotLight | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/SpotLight.js | Source}
			 
	**/
	function new(?color:js.three.math.ColorRepresentation, ?intensity:Float, ?distance:Float, ?angle:Float, ?penumbra:Float, ?decay:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link SpotLight}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isSpotLight(default, null) : Bool;
	/**
		
			 * The {@link SpotLight} points from its {@link SpotLight.position | position} to target.position.
			 * @remarks
			 * **Note**: For the target's position to be changed to anything other than the default,
			 * it must be added to the {@link Scene | scene} using
			 * 
			 * ```typescript
			 * scene.add( light.target );
			 * ```
			 * 
			 * This is so that the target's {@link Object3D.matrixWorld | matrixWorld} gets automatically updated each frame.
			 * It is also possible to set the target to be another object in the scene (anything with a {@link THREE.Object3D.position | position} property), like so:
			 * ```typescript
			 * const targetObject = new THREE.Object3D();
			 * scene.add(targetObject);
			 * light.target = targetObject;
			 * ```
			 * The {@link SpotLight} will now track the target object.
			 * @defaultValue `new THREE.Object3D()` _The default position of the target is *(0, 0, 0)*._
			 
	**/
	var target : js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * When **Default mode** — When distance is zero, light does not attenuate. When distance is non-zero,
			 * light will attenuate linearly from maximum intensity at the light's position down to zero at this distance from the light.
			 * 
			 * When **{@link WebGLRenderer.useLegacyLights | legacy lighting mode} is disabled** — When distance is zero,
			 * light will attenuate according to inverse-square law to infinite distance.
			 * When distance is non-zero, light will attenuate according to inverse-square law until near the distance cutoff,
			 * where it will then attenuate quickly and smoothly to `0`. Inherently, cutoffs are not physically correct.
			 * @remarks Expects a `Float`
			 * @defaultValue `0.0`
			 
	**/
	var distance : Float;
	/**
		
			 * Maximum extent of the spotlight, in radians, from its direction.
			 * @remarks Should be no more than `Math.PI/2`.
			 * @remarks Expects a `Float`
			 * @defaultValue `Math.PI / 3`
			 
	**/
	var angle : Float;
	/**
		
			 * The amount the light dims along the distance of the light.
			 * In context of physically-correct rendering the default value should not be changed.
			 * @remarks Expects a `Float`
			 * @defaultValue `2`
			 
	**/
	var decay : Float;
	/**
		
			 * The light's power.
			 * @remarks Changing the power will also change the light's intensity.
			 * When **{@link WebGLRenderer.useLegacyLights | legacy lighting mode} is disabled** —  power is the luminous power of the light measured in lumens (lm).
			 * @remarks Expects a `Float`
			 
	**/
	var power : Float;
	/**
		
			 * Percent of the {@link SpotLight} cone that is attenuated due to penumbra.
			 * @remarks Takes values between zero and 1.
			 * @remarks Expects a `Float`
			 * @defaultValue `0.0`
			 
	**/
	var penumbra : Float;
	/**
		
			 * A {@link THREE.Texture | Texture} used to modulate the color of the light.
			 * The spot light color is mixed with the _RGB_ value of this texture, with a ratio corresponding to its alpha value.
			 * The cookie-like masking effect is reproduced using pixel values (0, 0, 0, 1-cookie_value).
			 * @remarks **Warning**: {@link SpotLight.map} is disabled if {@link SpotLight.castShadow} is `false`.
			 
	**/
	var map : js.three.textures.Texture;
}
package js.three.lights;

/**
 * A light that gets emitted in a specific direction
 * @remarks
 * This light will behave as though it is infinitely far away and the rays produced from it are all parallel
 * The common use case for this is to simulate daylight; the sun is far enough away that its position can be considered to be infinite, and all light rays coming from it are parallel.
 * A common point of confusion for directional lights is that setting the rotation has no effect
 * @remarks
 * This is because three.js's {@link DirectionalLight} is the equivalent to what is often called a 'Target Direct Light' in other applications.
 * This means that its direction is calculated as pointing from the light's {@link THREE.Object3D.position | position} to the {@link THREE.DirectionalLight.target | target}'s
 * position (as opposed to a 'Free Direct Light' that just has a rotation component).
 * See the {@link THREE.DirectionalLight.target | target} property below for details on updating the target.
 * @example
 * ```typescript
 * // White directional light at half intensity shining from the top.
 * const {@link DirectionalLight} = new THREE.DirectionalLight(0xffffff, 0.5);
 * scene.add(directionalLight);
 * ```
 * @see Example: {@link https://threejs.org/examples/#misc_controls_fly | controls / fly }
 * @see Example: {@link https://threejs.org/examples/#webgl_effects_parallaxbarrier | effects / parallaxbarrier }
 * @see Example: {@link https://threejs.org/examples/#webgl_effects_stereo | effects / stereo }
 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | geometry / extrude / splines }
 * @see Example: {@link https://threejs.org/examples/#webgl_materials_bumpmap | materials / bumpmap }
 * @see {@link https://threejs.org/docs/index.html#api/en/lights/DirectionalLight | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/DirectionalLight.js | Source}
 */
/**
	
	 * A light that gets emitted in a specific direction
	 * @remarks
	 * This light will behave as though it is infinitely far away and the rays produced from it are all parallel
	 * The common use case for this is to simulate daylight; the sun is far enough away that its position can be considered to be infinite, and all light rays coming from it are parallel.
	 * A common point of confusion for directional lights is that setting the rotation has no effect
	 * @remarks
	 * This is because three.js's {@link DirectionalLight} is the equivalent to what is often called a 'Target Direct Light' in other applications.
	 * This means that its direction is calculated as pointing from the light's {@link THREE.Object3D.position | position} to the {@link THREE.DirectionalLight.target | target}'s
	 * position (as opposed to a 'Free Direct Light' that just has a rotation component).
	 * See the {@link THREE.DirectionalLight.target | target} property below for details on updating the target.
	 * @example
	 * ```typescript
	 * // White directional light at half intensity shining from the top.
	 * const {@link DirectionalLight} = new THREE.DirectionalLight(0xffffff, 0.5);
	 * scene.add(directionalLight);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#misc_controls_fly | controls / fly }
	 * @see Example: {@link https://threejs.org/examples/#webgl_effects_parallaxbarrier | effects / parallaxbarrier }
	 * @see Example: {@link https://threejs.org/examples/#webgl_effects_stereo | effects / stereo }
	 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | geometry / extrude / splines }
	 * @see Example: {@link https://threejs.org/examples/#webgl_materials_bumpmap | materials / bumpmap }
	 * @see {@link https://threejs.org/docs/index.html#api/en/lights/DirectionalLight | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/DirectionalLight.js | Source}
	 
**/
@:native("THREE.DirectionalLight") extern class DirectionalLight extends js.three.lights.Light<js.three.lights.DirectionalLightShadow> {
	/**
		
			 * A light that gets emitted in a specific direction
			 * @remarks
			 * This light will behave as though it is infinitely far away and the rays produced from it are all parallel
			 * The common use case for this is to simulate daylight; the sun is far enough away that its position can be considered to be infinite, and all light rays coming from it are parallel.
			 * A common point of confusion for directional lights is that setting the rotation has no effect
			 * @remarks
			 * This is because three.js's {@link DirectionalLight} is the equivalent to what is often called a 'Target Direct Light' in other applications.
			 * This means that its direction is calculated as pointing from the light's {@link THREE.Object3D.position | position} to the {@link THREE.DirectionalLight.target | target}'s
			 * position (as opposed to a 'Free Direct Light' that just has a rotation component).
			 * See the {@link THREE.DirectionalLight.target | target} property below for details on updating the target.
			 * @example
			 * ```typescript
			 * // White directional light at half intensity shining from the top.
			 * const {@link DirectionalLight} = new THREE.DirectionalLight(0xffffff, 0.5);
			 * scene.add(directionalLight);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#misc_controls_fly | controls / fly }
			 * @see Example: {@link https://threejs.org/examples/#webgl_effects_parallaxbarrier | effects / parallaxbarrier }
			 * @see Example: {@link https://threejs.org/examples/#webgl_effects_stereo | effects / stereo }
			 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | geometry / extrude / splines }
			 * @see Example: {@link https://threejs.org/examples/#webgl_materials_bumpmap | materials / bumpmap }
			 * @see {@link https://threejs.org/docs/index.html#api/en/lights/DirectionalLight | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/DirectionalLight.js | Source}
			 
	**/
	function new(?color:js.three.math.ColorRepresentation, ?intensity:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link DirectionalLight}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isDirectionalLight(default, null) : Bool;
	/**
		
			 * The {@link DirectionalLight} points from its {@link DirectionalLight.position | position} to target.position.
			 * @remarks **Note**: For the target's position to be changed to anything other than the default,
			 * it must be added to the {@link THREE.Scene | scene} using
			 * ```typescript
			 * Scene.add( light.target );
			 * ```
			 * This is so that the target's {@link THREE.Object3D.matrixWorld | matrixWorld} gets automatically updated each frame.
			 * 
			 * It is also possible to set the target to be another object in the scene (anything with a {@link THREE.Object3D.position | position} property),
			 * like so:
			 * ```typescript
			 * const targetObject = new THREE.Object3D();
			 * scene.add(targetObject);
			 * light.target = targetObject;
			 * ```
			 * The {@link DirectionalLight} will now track the target object.
			 * @defaultValue `new THREE.Object3D()` at _(0, 0, 0)_
			 
	**/
	var target : js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	override function dispose():Void;
}
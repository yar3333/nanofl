package js.three.lights;

/**
 * This is used internally by {@link DirectionalLight | DirectionalLights} for calculating shadows.
 * Unlike the other shadow classes, this uses an {@link THREE.OrthographicCamera | OrthographicCamera} to calculate the shadows,
 * rather than a {@link THREE.PerspectiveCamera | PerspectiveCamera}
 * @remarks
 * This is because light rays from a {@link THREE.DirectionalLight | DirectionalLight} are parallel.
 * @example
 * ```typescript
 * //Create a WebGLRenderer and turn on shadows in the renderer
 * const renderer = new THREE.WebGLRenderer();
 * renderer.shadowMap.enabled = true;
 * renderer.shadowMap.type = THREE.PCFSoftShadowMap; // default THREE.PCFShadowMap
 * //Create a DirectionalLight and turn on shadows for the light
 * const light = new THREE.DirectionalLight(0xffffff, 1);
 * light.position.set(0, 1, 0); //default; light shining from top
 * light.castShadow = true; // default false
 * scene.add(light);
 * //Set up shadow properties for the light
 * light.shadow.mapSize.width = 512; // default
 * light.shadow.mapSize.height = 512; // default
 * light.shadow.camera.near = 0.5; // default
 * light.shadow.camera.far = 500; // default
 * //Create a sphere that cast shadows (but does not receive them)
 * const sphereGeometry = new THREE.SphereGeometry(5, 32, 32);
 * const sphereMaterial = new THREE.MeshStandardMaterial({
 *     color: 0xff0000
 * });
 * const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
 * sphere.castShadow = true; //default is false
 * sphere.receiveShadow = false; //default
 * scene.add(sphere);
 * //Create a plane that receives shadows (but does not cast them)
 * const planeGeometry = new THREE.PlaneGeometry(20, 20, 32, 32);
 * const planeMaterial = new THREE.MeshStandardMaterial({
 *     color: 0x00ff00
 * })
 * const plane = new THREE.Mesh(planeGeometry, planeMaterial);
 * plane.receiveShadow = true;
 * scene.add(plane);
 * //Create a helper for the shadow camera (optional)
 * const helper = new THREE.CameraHelper(light.shadow.camera);
 * scene.add(helper);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/lights/shadows/DirectionalLightShadow | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/DirectionalLightShadow.js | Source}
 */
/**
	
	 * This is used internally by {@link DirectionalLight | DirectionalLights} for calculating shadows.
	 * Unlike the other shadow classes, this uses an {@link THREE.OrthographicCamera | OrthographicCamera} to calculate the shadows,
	 * rather than a {@link THREE.PerspectiveCamera | PerspectiveCamera}
	 * @remarks
	 * This is because light rays from a {@link THREE.DirectionalLight | DirectionalLight} are parallel.
	 * @example
	 * ```typescript
	 * //Create a WebGLRenderer and turn on shadows in the renderer
	 * const renderer = new THREE.WebGLRenderer();
	 * renderer.shadowMap.enabled = true;
	 * renderer.shadowMap.type = THREE.PCFSoftShadowMap; // default THREE.PCFShadowMap
	 * //Create a DirectionalLight and turn on shadows for the light
	 * const light = new THREE.DirectionalLight(0xffffff, 1);
	 * light.position.set(0, 1, 0); //default; light shining from top
	 * light.castShadow = true; // default false
	 * scene.add(light);
	 * //Set up shadow properties for the light
	 * light.shadow.mapSize.width = 512; // default
	 * light.shadow.mapSize.height = 512; // default
	 * light.shadow.camera.near = 0.5; // default
	 * light.shadow.camera.far = 500; // default
	 * //Create a sphere that cast shadows (but does not receive them)
	 * const sphereGeometry = new THREE.SphereGeometry(5, 32, 32);
	 * const sphereMaterial = new THREE.MeshStandardMaterial({
	 *     color: 0xff0000
	 * });
	 * const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
	 * sphere.castShadow = true; //default is false
	 * sphere.receiveShadow = false; //default
	 * scene.add(sphere);
	 * //Create a plane that receives shadows (but does not cast them)
	 * const planeGeometry = new THREE.PlaneGeometry(20, 20, 32, 32);
	 * const planeMaterial = new THREE.MeshStandardMaterial({
	 *     color: 0x00ff00
	 * })
	 * const plane = new THREE.Mesh(planeGeometry, planeMaterial);
	 * plane.receiveShadow = true;
	 * scene.add(plane);
	 * //Create a helper for the shadow camera (optional)
	 * const helper = new THREE.CameraHelper(light.shadow.camera);
	 * scene.add(helper);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/lights/shadows/DirectionalLightShadow | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/DirectionalLightShadow.js | Source}
	 
**/
@:native("THREE.DirectionalLightShadow") extern class DirectionalLightShadow extends js.three.lights.LightShadow<js.three.cameras.OrthographicCamera> {
	/**
		
			 * This is used internally by {@link DirectionalLight | DirectionalLights} for calculating shadows.
			 * Unlike the other shadow classes, this uses an {@link THREE.OrthographicCamera | OrthographicCamera} to calculate the shadows,
			 * rather than a {@link THREE.PerspectiveCamera | PerspectiveCamera}
			 * @remarks
			 * This is because light rays from a {@link THREE.DirectionalLight | DirectionalLight} are parallel.
			 * @example
			 * ```typescript
			 * //Create a WebGLRenderer and turn on shadows in the renderer
			 * const renderer = new THREE.WebGLRenderer();
			 * renderer.shadowMap.enabled = true;
			 * renderer.shadowMap.type = THREE.PCFSoftShadowMap; // default THREE.PCFShadowMap
			 * //Create a DirectionalLight and turn on shadows for the light
			 * const light = new THREE.DirectionalLight(0xffffff, 1);
			 * light.position.set(0, 1, 0); //default; light shining from top
			 * light.castShadow = true; // default false
			 * scene.add(light);
			 * //Set up shadow properties for the light
			 * light.shadow.mapSize.width = 512; // default
			 * light.shadow.mapSize.height = 512; // default
			 * light.shadow.camera.near = 0.5; // default
			 * light.shadow.camera.far = 500; // default
			 * //Create a sphere that cast shadows (but does not receive them)
			 * const sphereGeometry = new THREE.SphereGeometry(5, 32, 32);
			 * const sphereMaterial = new THREE.MeshStandardMaterial({
			 *     color: 0xff0000
			 * });
			 * const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
			 * sphere.castShadow = true; //default is false
			 * sphere.receiveShadow = false; //default
			 * scene.add(sphere);
			 * //Create a plane that receives shadows (but does not cast them)
			 * const planeGeometry = new THREE.PlaneGeometry(20, 20, 32, 32);
			 * const planeMaterial = new THREE.MeshStandardMaterial({
			 *     color: 0x00ff00
			 * })
			 * const plane = new THREE.Mesh(planeGeometry, planeMaterial);
			 * plane.receiveShadow = true;
			 * scene.add(plane);
			 * //Create a helper for the shadow camera (optional)
			 * const helper = new THREE.CameraHelper(light.shadow.camera);
			 * scene.add(helper);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/lights/shadows/DirectionalLightShadow | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/lights/DirectionalLightShadow.js | Source}
			 
	**/
	function new():Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link DirectionalLightShadow}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isDirectionalLightShadow(default, null) : Bool;
}
package js.three.cameras;

/**
 * Creates **6** {@link THREE.PerspectiveCamera | cameras} that render to a {@link THREE.WebGLCubeRenderTarget | WebGLCubeRenderTarget}.
 * @remarks The cameras are added to the {@link children} array.
 * @example
 * ```typescript
 * // Create cube render target
 * const cubeRenderTarget = new THREE.WebGLCubeRenderTarget( 128, { generateMipmaps: true, minFilter: THREE.LinearMipmapLinearFilter } );
 *
 * // Create cube camera
 * const cubeCamera = new THREE.CubeCamera( 1, 100000, cubeRenderTarget );
 * scene.add( cubeCamera );
 *
 * // Create car
 * const chromeMaterial = new THREE.MeshLambertMaterial( { color: 0xffffff, envMap: cubeRenderTarget.texture } );
 * const car = new THREE.Mesh( carGeometry, chromeMaterial );
 * scene.add( car );
 *
 * // Update the render target cube
 * car.visible = false;
 * cubeCamera.position.copy( car.position );
 * cubeCamera.update( renderer, scene );
 *
 * // Render the scene
 * car.visible = true;
 * renderer.render( scene, camera );
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_materials_cubemap_dynamic | materials / cubemap / dynamic }
 * @see {@link https://threejs.org/docs/index.html#api/en/cameras/CubeCamera | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/cameras/CubeCamera.js | Source}
 */
/**
	
	 * Creates **6** {@link THREE.PerspectiveCamera | cameras} that render to a {@link THREE.WebGLCubeRenderTarget | WebGLCubeRenderTarget}.
	 * @remarks The cameras are added to the {@link children} array.
	 * @example
	 * ```typescript
	 * // Create cube render target
	 * const cubeRenderTarget = new THREE.WebGLCubeRenderTarget( 128, { generateMipmaps: true, minFilter: THREE.LinearMipmapLinearFilter } );
	 * 
	 * // Create cube camera
	 * const cubeCamera = new THREE.CubeCamera( 1, 100000, cubeRenderTarget );
	 * scene.add( cubeCamera );
	 * 
	 * // Create car
	 * const chromeMaterial = new THREE.MeshLambertMaterial( { color: 0xffffff, envMap: cubeRenderTarget.texture } );
	 * const car = new THREE.Mesh( carGeometry, chromeMaterial );
	 * scene.add( car );
	 * 
	 * // Update the render target cube
	 * car.visible = false;
	 * cubeCamera.position.copy( car.position );
	 * cubeCamera.update( renderer, scene );
	 * 
	 * // Render the scene
	 * car.visible = true;
	 * renderer.render( scene, camera );
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_materials_cubemap_dynamic | materials / cubemap / dynamic }
	 * @see {@link https://threejs.org/docs/index.html#api/en/cameras/CubeCamera | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/cameras/CubeCamera.js | Source}
	 
**/
@:native("THREE.CubeCamera") extern class CubeCamera extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
			 * Creates **6** {@link THREE.PerspectiveCamera | cameras} that render to a {@link THREE.WebGLCubeRenderTarget | WebGLCubeRenderTarget}.
			 * @remarks The cameras are added to the {@link children} array.
			 * @example
			 * ```typescript
			 * // Create cube render target
			 * const cubeRenderTarget = new THREE.WebGLCubeRenderTarget( 128, { generateMipmaps: true, minFilter: THREE.LinearMipmapLinearFilter } );
			 * 
			 * // Create cube camera
			 * const cubeCamera = new THREE.CubeCamera( 1, 100000, cubeRenderTarget );
			 * scene.add( cubeCamera );
			 * 
			 * // Create car
			 * const chromeMaterial = new THREE.MeshLambertMaterial( { color: 0xffffff, envMap: cubeRenderTarget.texture } );
			 * const car = new THREE.Mesh( carGeometry, chromeMaterial );
			 * scene.add( car );
			 * 
			 * // Update the render target cube
			 * car.visible = false;
			 * cubeCamera.position.copy( car.position );
			 * cubeCamera.update( renderer, scene );
			 * 
			 * // Render the scene
			 * car.visible = true;
			 * renderer.render( scene, camera );
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_materials_cubemap_dynamic | materials / cubemap / dynamic }
			 * @see {@link https://threejs.org/docs/index.html#api/en/cameras/CubeCamera | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/cameras/CubeCamera.js | Source}
			 
	**/
	function new(near:Float, far:Float, renderTarget:js.three.renderers.WebGLCubeRenderTarget):Void;
	/**
		
			 * The destination cube render target.
			 
	**/
	var renderTarget : js.three.renderers.WebGLCubeRenderTarget;
	var coordinateSystem : js.three.CoordinateSystem;
	var activeMipmapLevel : Float;
	function updateCoordinateSystem():Void;
	/**
		
			 * Call this to update the {@link CubeCamera.renderTarget | renderTarget}.
			 
	**/
	function update(renderer:js.three.renderers.WebGLRenderer, scene:js.three.core.Object3D<js.three.core.Object3DEventMap>):Void;
}
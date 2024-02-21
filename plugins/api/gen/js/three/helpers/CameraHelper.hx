package js.three.helpers;

/**
 * This helps with visualizing what a camera contains in its frustum
 * @remarks
 * It visualizes the frustum of a camera using a {@link THREE.LineSegments | LineSegments}.
 * @remarks {@link CameraHelper} must be a child of the scene.
 * @example
 * ```typescript
 * const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
 * const helper = new THREE.CameraHelper(camera);
 * scene.add(helper);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_camera | WebGL / camera}
 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | WebGL / extrude / splines}
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/CameraHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/CameraHelper.js | Source}
 */
/**
	
	 * This helps with visualizing what a camera contains in its frustum
	 * @remarks
	 * It visualizes the frustum of a camera using a {@link THREE.LineSegments | LineSegments}.
	 * @remarks {@link CameraHelper} must be a child of the scene.
	 * @example
	 * ```typescript
	 * const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
	 * const helper = new THREE.CameraHelper(camera);
	 * scene.add(helper);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_camera | WebGL / camera}
	 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | WebGL / extrude / splines}
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/CameraHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/CameraHelper.js | Source}
	 
**/
@:native("THREE.CameraHelper") extern class CameraHelper extends js.three.objects.LineSegments<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap> {
	/**
		
			 * This helps with visualizing what a camera contains in its frustum
			 * @remarks
			 * It visualizes the frustum of a camera using a {@link THREE.LineSegments | LineSegments}.
			 * @remarks {@link CameraHelper} must be a child of the scene.
			 * @example
			 * ```typescript
			 * const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
			 * const helper = new THREE.CameraHelper(camera);
			 * scene.add(helper);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_camera | WebGL / camera}
			 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | WebGL / extrude / splines}
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/CameraHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/CameraHelper.js | Source}
			 
	**/
	function new(camera:js.three.cameras.Camera):Void;
	/**
		
			 * The camera being visualized.
			 
	**/
	var camera : js.three.cameras.Camera;
	/**
		
			 * This contains the points used to visualize the camera.
			 
	**/
	var pointMap : Dynamic<Array<Float>>;
	/**
		
			 * Defines the colors of the helper.
			 
	**/
	function setColors(frustum:js.three.math.Color, cone:js.three.math.Color, up:js.three.math.Color, target:js.three.math.Color, cross:js.three.math.Color):js.three.helpers.CameraHelper;
	/**
		
			 * Updates the helper based on the projectionMatrix of the camera.
			 
	**/
	function update():Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
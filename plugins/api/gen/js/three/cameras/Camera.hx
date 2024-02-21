package js.three.cameras;

/**
 * Abstract base class for cameras
 * @remarks
 * This class should always be inherited when you build a new camera.
 * @see {@link https://threejs.org/docs/index.html#api/en/cameras/Camera | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/cameras/Camera.js | Source}
 */
/**
	
	 * Abstract base class for cameras
	 * @remarks
	 * This class should always be inherited when you build a new camera.
	 * @see {@link https://threejs.org/docs/index.html#api/en/cameras/Camera | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/cameras/Camera.js | Source}
	 
**/
@:native("THREE.Camera") extern class Camera extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
			 * Abstract base class for cameras
			 * @remarks
			 * This class should always be inherited when you build a new camera.
			 * @see {@link https://threejs.org/docs/index.html#api/en/cameras/Camera | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/cameras/Camera.js | Source}
			 
	**/
	function new():Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link Camera}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isCamera(default, null) : Bool;
	/**
		
			 * This is the inverse of matrixWorld.
			 * @remarks MatrixWorld contains the Matrix which has the world transform of the {@link Camera} .
			 * @defaultValue {@link THREE.Matrix4 | `new THREE.Matrix4()`}
			 
	**/
	var matrixWorldInverse : js.three.math.Matrix4;
	/**
		
			 * This is the matrix which contains the projection.
			 * @defaultValue {@link THREE.Matrix4 | `new THREE.Matrix4()`}
			 
	**/
	var projectionMatrix : js.three.math.Matrix4;
	/**
		
			 * This is the inverse of projectionMatrix.
			 * @defaultValue {@link THREE.Matrix4 | `new THREE.Matrix4()`}
			 
	**/
	var projectionMatrixInverse : js.three.math.Matrix4;
	var coordinateSystem : js.three.CoordinateSystem;
	/**
		
			 * Returns a {@link THREE.Vector3 | Vector3} representing the world space direction in which the {@link Camera} is looking.
			 * @remarks Note: A {@link Camera} looks down its local, negative z-axis.
			 
	**/
	override function getWorldDirection(target:js.three.math.Vector3):js.three.math.Vector3;
}
package js.three.extras.curves;

/**
 * Create a smooth **3D** {@link http://en.wikipedia.org/wiki/B%C3%A9zier_curve#mediaviewer/File:Bezier_curve.svg | cubic bezier curve},
 * defined by a start point, endpoint and two control points.
 * @example
 * ```typescript
 * const curve = new THREE.CubicBezierCurve(
 * new THREE.Vector2(-10, 0),
 * new THREE.Vector2(-5, 15),
 * new THREE.Vector2(20, 15),
 * new THREE.Vector2(10, 0));
 * const points = curve.getPoints(50);
 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
 * const material = new THREE.LineBasicMaterial({
 *     color: 0xff0000
 * });
 * // Create the final object to add to the scene
 * const curveObject = new THREE.Line(geometry, material);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/CubicBezierCurve | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/CubicBezierCurve.js | Source}
 */
/**
	
	 * Create a smooth **3D** {@link http://en.wikipedia.org/wiki/B%C3%A9zier_curve#mediaviewer/File:Bezier_curve.svg | cubic bezier curve},
	 * defined by a start point, endpoint and two control points.
	 * @example
	 * ```typescript
	 * const curve = new THREE.CubicBezierCurve(
	 * new THREE.Vector2(-10, 0),
	 * new THREE.Vector2(-5, 15),
	 * new THREE.Vector2(20, 15),
	 * new THREE.Vector2(10, 0));
	 * const points = curve.getPoints(50);
	 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
	 * const material = new THREE.LineBasicMaterial({
	 *     color: 0xff0000
	 * });
	 * // Create the final object to add to the scene
	 * const curveObject = new THREE.Line(geometry, material);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/CubicBezierCurve | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/CubicBezierCurve.js | Source}
	 
**/
@:native("THREE.CubicBezierCurve3") extern class CubicBezierCurve3 extends js.three.extras.core.Curve<js.three.math.Vector3> {
	/**
		
			 * Create a smooth **3D** {@link http://en.wikipedia.org/wiki/B%C3%A9zier_curve#mediaviewer/File:Bezier_curve.svg | cubic bezier curve},
			 * defined by a start point, endpoint and two control points.
			 * @example
			 * ```typescript
			 * const curve = new THREE.CubicBezierCurve(
			 * new THREE.Vector2(-10, 0),
			 * new THREE.Vector2(-5, 15),
			 * new THREE.Vector2(20, 15),
			 * new THREE.Vector2(10, 0));
			 * const points = curve.getPoints(50);
			 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
			 * const material = new THREE.LineBasicMaterial({
			 *     color: 0xff0000
			 * });
			 * // Create the final object to add to the scene
			 * const curveObject = new THREE.Line(geometry, material);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/CubicBezierCurve | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/CubicBezierCurve.js | Source}
			 
	**/
	function new(?v0:js.three.math.Vector3, ?v1:js.three.math.Vector3, ?v2:js.three.math.Vector3, ?v3:js.three.math.Vector3):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link CubicBezierCurve3}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isCubicBezierCurve3(default, null) : Dynamic;
	/**
		
			 * The starting point.
			 * @defaultValue `new THREE.Vector3()`.
			 
	**/
	var v0 : js.three.math.Vector3;
	/**
		
			 * The first control point.
			 * @defaultValue `new THREE.Vector3()`.
			 
	**/
	var v1 : js.three.math.Vector3;
	/**
		
			 * The second control point.
			 * @defaultValue `new THREE.Vector3()`.
			 
	**/
	var v2 : js.three.math.Vector3;
	/**
		
			 * The ending point.
			 * @defaultValue `new THREE.Vector3()`.
			 
	**/
	var v3 : js.three.math.Vector3;
}
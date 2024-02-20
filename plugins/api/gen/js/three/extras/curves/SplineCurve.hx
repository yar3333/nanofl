package js.three.extras.curves;

/**
 * Create a smooth **2D** spline curve from a series of points.
 * @example
 * ```typescript
 * // Create a sine-like wave
 * const curve = new THREE.SplineCurve([
 * new THREE.Vector2(-10, 0),
 * new THREE.Vector2(-5, 5),
 * new THREE.Vector2(0, 0),
 * new THREE.Vector2(5, -5),
 * new THREE.Vector2(10, 0)]);
 * const points = curve.getPoints(50);
 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
 * const material = new THREE.LineBasicMaterial({
 *     color: 0xff0000
 * });
 * // Create the final object to add to the scene
 * const splineObject = new THREE.Line(geometry, material);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/SplineCurve | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/SplineCurve.js | Source}
 */
/**
	
	 * Create a smooth **2D** spline curve from a series of points.
	 * @example
	 * ```typescript
	 * // Create a sine-like wave
	 * const curve = new THREE.SplineCurve([
	 * new THREE.Vector2(-10, 0),
	 * new THREE.Vector2(-5, 5),
	 * new THREE.Vector2(0, 0),
	 * new THREE.Vector2(5, -5),
	 * new THREE.Vector2(10, 0)]);
	 * const points = curve.getPoints(50);
	 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
	 * const material = new THREE.LineBasicMaterial({
	 *     color: 0xff0000
	 * });
	 * // Create the final object to add to the scene
	 * const splineObject = new THREE.Line(geometry, material);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/SplineCurve | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/SplineCurve.js | Source}
	 
**/
@:native("THREE.SplineCurve") extern class SplineCurve extends js.three.extras.core.Curve<js.three.math.Vector2> {
	/**
		
			 * Create a smooth **2D** spline curve from a series of points.
			 * @example
			 * ```typescript
			 * // Create a sine-like wave
			 * const curve = new THREE.SplineCurve([
			 * new THREE.Vector2(-10, 0),
			 * new THREE.Vector2(-5, 5),
			 * new THREE.Vector2(0, 0),
			 * new THREE.Vector2(5, -5),
			 * new THREE.Vector2(10, 0)]);
			 * const points = curve.getPoints(50);
			 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
			 * const material = new THREE.LineBasicMaterial({
			 *     color: 0xff0000
			 * });
			 * // Create the final object to add to the scene
			 * const splineObject = new THREE.Line(geometry, material);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/SplineCurve | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/SplineCurve.js | Source}
			 
	**/
	function new(?points:Array<js.three.math.Vector2>):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link SplineCurve}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isSplineCurve(default, null) : Dynamic;
	/**
		
			 * The array of {@link THREE.Vector2 | Vector2} points that define the curve.
			 * @defaultValue `[]`
			 
	**/
	var points : Array<js.three.math.Vector2>;
}
package js.three.extras.curves;

/**
 * Create a smooth **3D** spline curve from a series of points using the {@link https://en.wikipedia.org/wiki/Centripetal_Catmull-Rom_spline | Catmull-Rom} algorithm.
 * @example
 * ```typescript
 * //Create a closed wavey loop
 * const curve = new THREE.CatmullRomCurve3([
 * new THREE.Vector3(-10, 0, 10),
 * new THREE.Vector3(-5, 5, 5),
 * new THREE.Vector3(0, 0, 0),
 * new THREE.Vector3(5, -5, 5),
 * new THREE.Vector3(10, 0, 10)]);
 * const points = curve.getPoints(50);
 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
 * const material = new THREE.LineBasicMaterial({
 *     color: 0xff0000
 * });
 * // Create the final object to add to the scene
 * const curveObject = new THREE.Line(geometry, material);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | WebGL / geometry / extrude / splines}
 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/CatmullRomCurve3 | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/CatmullRomCurve3.js | Source}
 */
/**
	
	 * Create a smooth **3D** spline curve from a series of points using the {@link https://en.wikipedia.org/wiki/Centripetal_Catmull-Rom_spline | Catmull-Rom} algorithm.
	 * @example
	 * ```typescript
	 * //Create a closed wavey loop
	 * const curve = new THREE.CatmullRomCurve3([
	 * new THREE.Vector3(-10, 0, 10),
	 * new THREE.Vector3(-5, 5, 5),
	 * new THREE.Vector3(0, 0, 0),
	 * new THREE.Vector3(5, -5, 5),
	 * new THREE.Vector3(10, 0, 10)]);
	 * const points = curve.getPoints(50);
	 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
	 * const material = new THREE.LineBasicMaterial({
	 *     color: 0xff0000
	 * });
	 * // Create the final object to add to the scene
	 * const curveObject = new THREE.Line(geometry, material);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | WebGL / geometry / extrude / splines}
	 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/CatmullRomCurve3 | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/CatmullRomCurve3.js | Source}
	 
**/
@:native("THREE.CatmullRomCurve3") extern class CatmullRomCurve3 extends js.three.extras.core.Curve<js.three.math.Vector3> {
	/**
		
			 * Create a smooth **3D** spline curve from a series of points using the {@link https://en.wikipedia.org/wiki/Centripetal_Catmull-Rom_spline | Catmull-Rom} algorithm.
			 * @example
			 * ```typescript
			 * //Create a closed wavey loop
			 * const curve = new THREE.CatmullRomCurve3([
			 * new THREE.Vector3(-10, 0, 10),
			 * new THREE.Vector3(-5, 5, 5),
			 * new THREE.Vector3(0, 0, 0),
			 * new THREE.Vector3(5, -5, 5),
			 * new THREE.Vector3(10, 0, 10)]);
			 * const points = curve.getPoints(50);
			 * const geometry = new THREE.BufferGeometry().setFromPoints(points);
			 * const material = new THREE.LineBasicMaterial({
			 *     color: 0xff0000
			 * });
			 * // Create the final object to add to the scene
			 * const curveObject = new THREE.Line(geometry, material);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_geometry_extrude_splines | WebGL / geometry / extrude / splines}
			 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/CatmullRomCurve3 | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/CatmullRomCurve3.js | Source}
			 
	**/
	function new(?points:Array<js.three.math.Vector3>, ?closed:Bool, ?curveType:js.three.extras.curves.CurveType, ?tension:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link CatmullRomCurve3}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isCatmullRomCurve3(default, null) : Bool;
	/**
		
			 * The curve will loop back onto itself when this is true.
			 * @defaultValue `false`
			 
	**/
	var closed : Bool;
	/**
		
			 * The array of {@link THREE.Vector3 | Vector3} points that define the curve.
			 * @remarks It needs at least two entries.
			 * @defaultValue `[]`
			 
	**/
	var points : Array<js.three.math.Vector3>;
	/**
		
			 * Possible values are `centripetal`, `chordal` and `catmullrom`.
			 * @defaultValue `centripetal`
			 
	**/
	var curveType : js.three.extras.curves.CurveType;
	/**
		
			 * When {@link .curveType} is `catmullrom`, defines catmullrom's tension.
			 * @remarks Expects a `Float`
			 
	**/
	var tension : Float;
}
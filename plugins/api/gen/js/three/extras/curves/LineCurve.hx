package js.three.extras.curves;

/**
 * A curve representing a **2D** line segment.
 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/LineCurve | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/LineCurve.js | Source}
 */
/**
	
	 * A curve representing a **2D** line segment.
	 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/LineCurve | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/LineCurve.js | Source}
	 
**/
@:native("THREE.LineCurve") extern class LineCurve extends js.three.extras.core.Curve<js.three.math.Vector2> {
	/**
		
			 * A curve representing a **2D** line segment.
			 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/LineCurve | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/LineCurve.js | Source}
			 
	**/
	function new(?v1:js.three.math.Vector2, ?v2:js.three.math.Vector2):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link LineCurve}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isLineCurve(default, null) : Bool;
	/**
		
			 * The start point.
			 * @defaultValue `new THREE.Vector2()`
			 
	**/
	var v1 : js.three.math.Vector2;
	/**
		
			 * The end point
			 * @defaultValue `new THREE.Vector2()`
			 
	**/
	var v2 : js.three.math.Vector2;
}
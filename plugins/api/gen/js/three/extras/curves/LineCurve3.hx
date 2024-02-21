package js.three.extras.curves;

/**
 * A curve representing a **3D** line segment.
 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/LineCurve3 | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/LineCurve3.js | Source}
 */
/**
	
	 * A curve representing a **3D** line segment.
	 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/LineCurve3 | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/LineCurve3.js | Source}
	 
**/
@:native("THREE.LineCurve3") extern class LineCurve3 extends js.three.extras.core.Curve<js.three.math.Vector3> {
	/**
		
			 * A curve representing a **3D** line segment.
			 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/LineCurve3 | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/LineCurve3.js | Source}
			 
	**/
	function new(?v1:js.three.math.Vector3, ?v2:js.three.math.Vector3):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link LineCurve3}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isLineCurve3(default, null) : Dynamic;
	/**
		
			 * The start point.
			 * @defaultValue `new THREE.Vector3()`.
			 
	**/
	var v1 : js.three.math.Vector3;
	/**
		
			 * The end point.
			 * @defaultValue `new THREE.Vector3()`.
			 
	**/
	var v2 : js.three.math.Vector3;
}
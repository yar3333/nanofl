package js.three.extras.curves;

/**
 * Alias for {@link THREE.EllipseCurve | EllipseCurve}.
 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/ArcCurve | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/ArcCurve.js | Source}
 */
/**
	
	 * Alias for {@link THREE.EllipseCurve | EllipseCurve}.
	 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/ArcCurve | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/ArcCurve.js | Source}
	 
**/
@:native("THREE.ArcCurve") extern class ArcCurve extends js.three.extras.curves.EllipseCurve {
	/**
		
			 * Alias for {@link THREE.EllipseCurve | EllipseCurve}.
			 * @see {@link https://threejs.org/docs/index.html#api/en/extras/curves/ArcCurve | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/curves/ArcCurve.js | Source}
			 
	**/
	function new(?aX:Float, ?aY:Float, ?aRadius:Float, ?aStartAngle:Float, ?aEndAngle:Float, ?aClockwise:Bool):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link ArcCurve}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isArcCurve(default, null) : Bool;
}
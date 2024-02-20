package js.three.extras.core;

/**
 * Curved Path - a curve path is simply a array of connected curves, but retains the api of a curve.
 * @remarks
 * A {@link CurvePath} is simply an array of connected curves, but retains the api of a curve.
 * @see {@link https://threejs.org/docs/index.html#api/en/extras/core/CurvePath | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/core/CurvePath.js | Source}
 */
/**
	
	 * Curved Path - a curve path is simply a array of connected curves, but retains the api of a curve.
	 * @remarks
	 * A {@link CurvePath} is simply an array of connected curves, but retains the api of a curve.
	 * @see {@link https://threejs.org/docs/index.html#api/en/extras/core/CurvePath | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/core/CurvePath.js | Source}
	 
**/
@:native("THREE.CurvePath") extern class CurvePath<TVector:(haxe.extern.EitherType<js.three.math.Vector2, js.three.math.Vector3>)> extends js.three.extras.core.Curve<TVector> {
	/**
		
			 * Curved Path - a curve path is simply a array of connected curves, but retains the api of a curve.
			 * @remarks
			 * A {@link CurvePath} is simply an array of connected curves, but retains the api of a curve.
			 * @see {@link https://threejs.org/docs/index.html#api/en/extras/core/CurvePath | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/extras/core/CurvePath.js | Source}
			 
	**/
	function new():Void;
	/**
		
			 * The array of {@link Curve | Curves}.
			 * @defaultValue `[]`
			 
	**/
	var curves : Array<js.three.extras.core.Curve<TVector>>;
	/**
		
			 * Whether or not to automatically close the path.
			 * @defaultValue false
			 
	**/
	var autoClose : Bool;
	/**
		
			 * Add a curve to the {@link .curves} array.
			 
	**/
	function add(curve:js.three.extras.core.Curve<TVector>):Void;
	/**
		
			 * Adds a {@link LineCurve | lineCurve} to close the path.
			 
	**/
	function closePath():js.three.extras.core.CurvePath<TVector>;
	override function getPoint(t:Float, ?optionalTarget:TVector):TVector;
	/**
		
			 * Get list of cumulative curve lengths of the curves in the {@link .curves} array.
			 
	**/
	function getCurveLengths():Array<Float>;
}
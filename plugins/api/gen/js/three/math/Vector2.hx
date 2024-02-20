package js.three.math;

typedef Vector2Tuple = Array<Float>;

/**
 * 2D vector.
 */
/**
	
	 * 2D vector.
	 
**/
@:native("THREE.Vector2") extern class Vector2 {
	/**
		
			 * 2D vector.
			 
	**/
	function new(?x:Float, ?y:Float):Void;
	/**
		
			 * @default 0
			 
	**/
	var x : Float;
	/**
		
			 * @default 0
			 
	**/
	var y : Float;
	var width : Float;
	var height : Float;
	var isVector2(default, null) : Bool;
	/**
		
			 * Sets value of this vector.
			 
	**/
	function set(x:Float, y:Float):js.three.math.Vector2;
	/**
		
			 * Sets the x and y values of this vector both equal to scalar.
			 
	**/
	function setScalar(scalar:Float):js.three.math.Vector2;
	/**
		
			 * Sets X component of this vector.
			 
	**/
	function setX(x:Float):js.three.math.Vector2;
	/**
		
			 * Sets Y component of this vector.
			 
	**/
	function setY(y:Float):js.three.math.Vector2;
	/**
		
			 * Sets a component of this vector.
			 
	**/
	function setComponent(index:Int, value:Float):js.three.math.Vector2;
	/**
		
			 * Gets a component of this vector.
			 
	**/
	function getComponent(index:Int):Float;
	/**
		
			 * Returns a new Vector2 instance with the same `x` and `y` values.
			 
	**/
	function clone():js.three.math.Vector2;
	/**
		
			 * Copies value of v to this vector.
			 
	**/
	function copy(v:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * Adds v to this vector.
			 
	**/
	function add(v:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * Adds the scalar value s to this vector's x and y values.
			 
	**/
	function addScalar(s:Float):js.three.math.Vector2;
	/**
		
			 * Sets this vector to a + b.
			 
	**/
	function addVectors(a:js.three.math.Vector2Like, b:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * Adds the multiple of v and s to this vector.
			 
	**/
	function addScaledVector(v:js.three.math.Vector2Like, s:Float):js.three.math.Vector2;
	/**
		
			 * Subtracts v from this vector.
			 
	**/
	function sub(v:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * Subtracts s from this vector's x and y components.
			 
	**/
	function subScalar(s:Float):js.three.math.Vector2;
	/**
		
			 * Sets this vector to a - b.
			 
	**/
	function subVectors(a:js.three.math.Vector2Like, b:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * Multiplies this vector by v.
			 
	**/
	function multiply(v:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * Multiplies this vector by scalar s.
			 
	**/
	function multiplyScalar(scalar:Float):js.three.math.Vector2;
	/**
		
			 * Divides this vector by v.
			 
	**/
	function divide(v:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * Divides this vector by scalar s.
			 * Set vector to ( 0, 0 ) if s == 0.
			 
	**/
	function divideScalar(s:Float):js.three.math.Vector2;
	/**
		
			 * Multiplies this vector (with an implicit 1 as the 3rd component) by m.
			 
	**/
	function applyMatrix3(m:js.three.math.Matrix3):js.three.math.Vector2;
	/**
		
			 * If this vector's x or y value is greater than v's x or y value, replace that value with the corresponding min value.
			 
	**/
	function min(v:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * If this vector's x or y value is less than v's x or y value, replace that value with the corresponding max value.
			 
	**/
	function max(v:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * If this vector's x or y value is greater than the max vector's x or y value, it is replaced by the corresponding value.
			 * If this vector's x or y value is less than the min vector's x or y value, it is replaced by the corresponding value.
			 
	**/
	function clamp(min:js.three.math.Vector2Like, max:js.three.math.Vector2Like):js.three.math.Vector2;
	/**
		
			 * If this vector's x or y values are greater than the max value, they are replaced by the max value.
			 * If this vector's x or y values are less than the min value, they are replaced by the min value.
			 
	**/
	function clampScalar(min:Float, max:Float):js.three.math.Vector2;
	/**
		
			 * If this vector's length is greater than the max value, it is replaced by the max value.
			 * If this vector's length is less than the min value, it is replaced by the min value.
			 
	**/
	function clampLength(min:Float, max:Float):js.three.math.Vector2;
	/**
		
			 * The components of the vector are rounded down to the nearest integer value.
			 
	**/
	function floor():js.three.math.Vector2;
	/**
		
			 * The x and y components of the vector are rounded up to the nearest integer value.
			 
	**/
	function ceil():js.three.math.Vector2;
	/**
		
			 * The components of the vector are rounded to the nearest integer value.
			 
	**/
	function round():js.three.math.Vector2;
	/**
		
			 * The components of the vector are rounded towards zero (up if negative, down if positive) to an integer value.
			 
	**/
	function roundToZero():js.three.math.Vector2;
	/**
		
			 * Inverts this vector.
			 
	**/
	function negate():js.three.math.Vector2;
	/**
		
			 * Computes dot product of this vector and v.
			 
	**/
	function dot(v:js.three.math.Vector2Like):Float;
	/**
		
			 * Computes cross product of this vector and v.
			 
	**/
	function cross(v:js.three.math.Vector2Like):Float;
	/**
		
			 * Computes squared length of this vector.
			 
	**/
	function lengthSq():Float;
	/**
		
			 * Computes length of this vector.
			 
	**/
	function length():Float;
	/**
		
			 * Computes the Manhattan length of this vector.
			 * 
			 * see {@link http://en.wikipedia.org/wiki/Taxicab_geometry|Wikipedia: Taxicab Geometry}
			 
	**/
	function manhattanLength():Float;
	/**
		
			 * Normalizes this vector.
			 
	**/
	function normalize():js.three.math.Vector2;
	/**
		
			 * computes the angle in radians with respect to the positive x-axis
			 
	**/
	function angle():Float;
	/**
		
			 * Returns the angle between this vector and vector {@link Vector2 | v} in radians.
			 
	**/
	function angleTo(v:js.three.math.Vector2):Float;
	/**
		
			 * Computes distance of this vector to v.
			 
	**/
	function distanceTo(v:js.three.math.Vector2Like):Float;
	/**
		
			 * Computes squared distance of this vector to v.
			 
	**/
	function distanceToSquared(v:js.three.math.Vector2Like):Float;
	/**
		
			 * Computes the Manhattan length (distance) from this vector to the given vector v
			 * 
			 * see {@link http://en.wikipedia.org/wiki/Taxicab_geometry|Wikipedia: Taxicab Geometry}
			 
	**/
	function manhattanDistanceTo(v:js.three.math.Vector2Like):Float;
	/**
		
			 * Normalizes this vector and multiplies it by l.
			 
	**/
	function setLength(length:Float):js.three.math.Vector2;
	/**
		
			 * Linearly interpolates between this vector and v, where alpha is the distance along the line - alpha = 0 will be this vector, and alpha = 1 will be v.
			 
	**/
	function lerp(v:js.three.math.Vector2Like, alpha:Float):js.three.math.Vector2;
	/**
		
			 * Sets this vector to be the vector linearly interpolated between v1 and v2 where alpha is the distance along the line connecting the two vectors - alpha = 0 will be v1, and alpha = 1 will be v2.
			 
	**/
	function lerpVectors(v1:js.three.math.Vector2Like, v2:js.three.math.Vector2Like, alpha:Float):js.three.math.Vector2;
	/**
		
			 * Checks for strict equality of this vector and v.
			 
	**/
	function equals(v:js.three.math.Vector2Like):Bool;
	/**
		
			 * Sets this vector's x and y value from the provided array or array-like.
			 
	**/
	function fromArray(array:haxe.extern.EitherType<Array<Float>, js.three.ArrayLike<Float>>, ?offset:Float):js.three.math.Vector2;
	/**
		
			 * Returns an array [x, y], or copies x and y into the provided array.
			 * @return The created or provided array.
			 * Copies x and y into the provided array-like.
			 * @return The provided array-like.
			 
	**/
	@:overload(function(array:js.three.ArrayLike<Float>, ?offset:Float):js.three.ArrayLike<Float> { })
	@:overload(function(?array:js.three.math.Vector2.Vector2Tuple, ?offset:Int):js.three.math.Vector2.Vector2Tuple { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	/**
		
			 * Sets this vector's x and y values from the attribute.
			 
	**/
	function fromBufferAttribute(attribute:js.three.core.BufferAttribute, index:Int):js.three.math.Vector2;
	/**
		
			 * Rotates the vector around center by angle radians.
			 
	**/
	function rotateAround(center:js.three.math.Vector2Like, angle:Float):js.three.math.Vector2;
	/**
		
			 * Sets this vector's x and y from Math.random
			 
	**/
	function random():js.three.math.Vector2;
}
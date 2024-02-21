package js.three.math;

typedef Vector4Tuple = Array<Float>;

/**
 * 4D vector.
 */
/**
	
	 * 4D vector.
	 
**/
@:native("THREE.Vector4") extern class Vector4 {
	/**
		
			 * 4D vector.
			 
	**/
	function new(?x:Float, ?y:Float, ?z:Float, ?w:Float):Void;
	/**
		
			 * @default 0
			 
	**/
	var x : Float;
	/**
		
			 * @default 0
			 
	**/
	var y : Float;
	/**
		
			 * @default 0
			 
	**/
	var z : Float;
	/**
		
			 * @default 0
			 
	**/
	var w : Float;
	var width : Float;
	var height : Float;
	var isVector4(default, null) : Bool;
	/**
		
			 * Sets value of this vector.
			 
	**/
	function set(x:Float, y:Float, z:Float, w:Float):js.three.math.Vector4;
	/**
		
			 * Sets all values of this vector.
			 
	**/
	function setScalar(scalar:Float):js.three.math.Vector4;
	/**
		
			 * Sets X component of this vector.
			 
	**/
	function setX(x:Float):js.three.math.Vector4;
	/**
		
			 * Sets Y component of this vector.
			 
	**/
	function setY(y:Float):js.three.math.Vector4;
	/**
		
			 * Sets Z component of this vector.
			 
	**/
	function setZ(z:Float):js.three.math.Vector4;
	/**
		
			 * Sets w component of this vector.
			 
	**/
	function setW(w:Float):js.three.math.Vector4;
	function setComponent(index:Int, value:Float):js.three.math.Vector4;
	function getComponent(index:Int):Float;
	/**
		
			 * Clones this vector.
			 
	**/
	function clone():js.three.math.Vector4;
	/**
		
			 * Copies value of v to this vector.
			 
	**/
	function copy(v:js.three.math.Vector4Like):js.three.math.Vector4;
	/**
		
			 * Adds v to this vector.
			 
	**/
	function add(v:js.three.math.Vector4Like):js.three.math.Vector4;
	function addScalar(scalar:Float):js.three.math.Vector4;
	/**
		
			 * Sets this vector to a + b.
			 
	**/
	function addVectors(a:js.three.math.Vector4Like, b:js.three.math.Vector4Like):js.three.math.Vector4;
	function addScaledVector(v:js.three.math.Vector4Like, s:Float):js.three.math.Vector4;
	/**
		
			 * Subtracts v from this vector.
			 
	**/
	function sub(v:js.three.math.Vector4Like):js.three.math.Vector4;
	function subScalar(s:Float):js.three.math.Vector4;
	/**
		
			 * Sets this vector to a - b.
			 
	**/
	function subVectors(a:js.three.math.Vector4Like, b:js.three.math.Vector4Like):js.three.math.Vector4;
	function multiply(v:js.three.math.Vector4Like):js.three.math.Vector4;
	/**
		
			 * Multiplies this vector by scalar s.
			 
	**/
	function multiplyScalar(s:Float):js.three.math.Vector4;
	function applyMatrix4(m:js.three.math.Matrix4):js.three.math.Vector4;
	/**
		
			 * Divides this vector by scalar s.
			 * Set vector to ( 0, 0, 0 ) if s == 0.
			 
	**/
	function divideScalar(s:Float):js.three.math.Vector4;
	/**
		
			 * http://www.euclideanspace.com/maths/geometry/rotations/conversions/quaternionToAngle/index.htm
			 
	**/
	function setAxisAngleFromQuaternion(q:js.three.math.QuaternionLike):js.three.math.Vector4;
	/**
		
			 * http://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToAngle/index.htm
			 
	**/
	function setAxisAngleFromRotationMatrix(m:js.three.math.Matrix4):js.three.math.Vector4;
	function min(v:js.three.math.Vector4Like):js.three.math.Vector4;
	function max(v:js.three.math.Vector4Like):js.three.math.Vector4;
	function clamp(min:js.three.math.Vector4Like, max:js.three.math.Vector4Like):js.three.math.Vector4;
	function clampScalar(min:Float, max:Float):js.three.math.Vector4;
	function floor():js.three.math.Vector4;
	function ceil():js.three.math.Vector4;
	function round():js.three.math.Vector4;
	function roundToZero():js.three.math.Vector4;
	/**
		
			 * Inverts this vector.
			 
	**/
	function negate():js.three.math.Vector4;
	/**
		
			 * Computes dot product of this vector and v.
			 
	**/
	function dot(v:js.three.math.Vector4Like):Float;
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
	function normalize():js.three.math.Vector4;
	/**
		
			 * Normalizes this vector and multiplies it by l.
			 
	**/
	function setLength(length:Float):js.three.math.Vector4;
	/**
		
			 * Linearly interpolate between this vector and v with alpha factor.
			 
	**/
	function lerp(v:js.three.math.Vector4Like, alpha:Float):js.three.math.Vector4;
	function lerpVectors(v1:js.three.math.Vector4Like, v2:js.three.math.Vector4Like, alpha:Float):js.three.math.Vector4;
	/**
		
			 * Checks for strict equality of this vector and v.
			 
	**/
	function equals(v:js.three.math.Vector4Like):Bool;
	/**
		
			 * Sets this vector's x, y, z and w value from the provided array or array-like.
			 
	**/
	function fromArray(array:haxe.extern.EitherType<Array<Float>, js.three.ArrayLike<Float>>, ?offset:Float):js.three.math.Vector4;
	/**
		
			 * Returns an array [x, y, z, w], or copies x, y, z and w into the provided array.
			 * @return The created or provided array.
			 * Copies x, y, z and w into the provided array-like.
			 * @return The provided array-like.
			 
	**/
	@:overload(function(array:js.three.ArrayLike<Float>, ?offset:Float):js.three.ArrayLike<Float> { })
	@:overload(function(?array:js.three.math.Vector4.Vector4Tuple, ?offset:Int):js.three.math.Vector4.Vector4Tuple { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	function fromBufferAttribute(attribute:js.three.core.BufferAttribute, index:Int):js.three.math.Vector4;
	/**
		
			 * Sets this vector's x, y, z and w from Math.random
			 
	**/
	function random():js.three.math.Vector4;
}
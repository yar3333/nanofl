package js.three.math;

/**
 * Implementation of a quaternion. This is used for rotating things without incurring in the dreaded gimbal lock issue, amongst other advantages.
 *
 * @example
 * const quaternion = new THREE.Quaternion();
 * quaternion.setFromAxisAngle( new THREE.Vector3( 0, 1, 0 ), Math.PI / 2 );
 * const vector = new THREE.Vector3( 1, 0, 0 );
 * vector.applyQuaternion( quaternion );
 */
/**
	
	 * Implementation of a quaternion. This is used for rotating things without incurring in the dreaded gimbal lock issue, amongst other advantages.
	 * 
	 * @example
	 * const quaternion = new THREE.Quaternion();
	 * quaternion.setFromAxisAngle( new THREE.Vector3( 0, 1, 0 ), Math.PI / 2 );
	 * const vector = new THREE.Vector3( 1, 0, 0 );
	 * vector.applyQuaternion( quaternion );
	 
**/
@:native("THREE.Quaternion") extern class Quaternion {
	/**
		
			 * Implementation of a quaternion. This is used for rotating things without incurring in the dreaded gimbal lock issue, amongst other advantages.
			 * 
			 * @example
			 * const quaternion = new THREE.Quaternion();
			 * quaternion.setFromAxisAngle( new THREE.Vector3( 0, 1, 0 ), Math.PI / 2 );
			 * const vector = new THREE.Vector3( 1, 0, 0 );
			 * vector.applyQuaternion( quaternion );
			 
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
		
			 * @default 1
			 
	**/
	var w : Float;
	var isQuaternion(default, null) : Bool;
	var _onChangeCallback : () -> Void;
	/**
		
			 * Sets values of this quaternion.
			 
	**/
	function set(x:Float, y:Float, z:Float, w:Float):js.three.math.Quaternion;
	/**
		
			 * Clones this quaternion.
			 
	**/
	function clone():js.three.math.Quaternion;
	/**
		
			 * Copies values of q to this quaternion.
			 
	**/
	function copy(q:js.three.math.QuaternionLike):js.three.math.Quaternion;
	/**
		
			 * Sets this quaternion from rotation specified by Euler angles.
			 
	**/
	function setFromEuler(euler:js.three.math.Euler, ?update:Bool):js.three.math.Quaternion;
	/**
		
			 * Sets this quaternion from rotation specified by axis and angle.
			 * Adapted from http://www.euclideanspace.com/maths/geometry/rotations/conversions/angleToQuaternion/index.htm.
			 * Axis have to be normalized, angle is in radians.
			 
	**/
	function setFromAxisAngle(axis:js.three.math.Vector3Like, angle:Float):js.three.math.Quaternion;
	/**
		
			 * Sets this quaternion from rotation component of m. Adapted from http://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToQuaternion/index.htm.
			 
	**/
	function setFromRotationMatrix(m:js.three.math.Matrix4):js.three.math.Quaternion;
	function setFromUnitVectors(vFrom:js.three.math.Vector3, vTo:js.three.math.Vector3Like):js.three.math.Quaternion;
	function angleTo(q:js.three.math.Quaternion):Float;
	function rotateTowards(q:js.three.math.Quaternion, step:Float):js.three.math.Quaternion;
	function identity():js.three.math.Quaternion;
	/**
		
			 * Inverts this quaternion.
			 
	**/
	function invert():js.three.math.Quaternion;
	function conjugate():js.three.math.Quaternion;
	function dot(v:js.three.math.Quaternion):Float;
	function lengthSq():Float;
	/**
		
			 * Computes length of this quaternion.
			 
	**/
	function length():Float;
	/**
		
			 * Normalizes this quaternion.
			 
	**/
	function normalize():js.three.math.Quaternion;
	/**
		
			 * Multiplies this quaternion by b.
			 
	**/
	function multiply(q:js.three.math.Quaternion):js.three.math.Quaternion;
	function premultiply(q:js.three.math.Quaternion):js.three.math.Quaternion;
	/**
		
			 * Sets this quaternion to a x b
			 * Adapted from http://www.euclideanspace.com/maths/algebra/realNormedAlgebra/quaternions/code/index.htm.
			 
	**/
	function multiplyQuaternions(a:js.three.math.Quaternion, b:js.three.math.Quaternion):js.three.math.Quaternion;
	function slerp(qb:js.three.math.Quaternion, t:Float):js.three.math.Quaternion;
	function slerpQuaternions(qa:js.three.math.Quaternion, qb:js.three.math.Quaternion, t:Float):js.three.math.Quaternion;
	function equals(v:js.three.math.Quaternion):Bool;
	/**
		
			 * Sets this quaternion's x, y, z and w value from the provided array or array-like.
			 
	**/
	function fromArray(array:haxe.extern.EitherType<Array<Float>, js.three.ArrayLike<Float>>, ?offset:Float):js.three.math.Quaternion;
	/**
		
			 * Returns an array [x, y, z, w], or copies x, y, z and w into the provided array.
			 * @return The created or provided array.
			 * Copies x, y, z and w into the provided array-like.
			 * @return The provided array-like.
			 
	**/
	@:overload(function(array:js.three.ArrayLike<Float>, ?offset:Float):js.three.ArrayLike<Float> { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	/**
		
			 * This method defines the serialization result of Quaternion.
			 * @return The numerical elements of this quaternion in an array of format [x, y, z, w].
			 
	**/
	function toJSON():Array<Float>;
	/**
		
			 * Sets x, y, z, w properties of this quaternion from the attribute.
			 
	**/
	function fromBufferAttribute(attribute:haxe.extern.EitherType<js.three.core.BufferAttribute, js.three.core.InterleavedBufferAttribute>, index:Int):js.three.math.Quaternion;
	function _onChange(callback:() -> Void):js.three.math.Quaternion;
	function random():js.three.math.Quaternion;
	static function slerpFlat(dst:Array<Float>, dstOffset:Float, src0:Array<Float>, srcOffset:Float, src1:Array<Float>, stcOffset1:Float, t:Float):Void;
	static function multiplyQuaternionsFlat(dst:Array<Float>, dstOffset:Float, src0:Array<Float>, srcOffset:Float, src1:Array<Float>, stcOffset1:Float):Array<Float>;
}
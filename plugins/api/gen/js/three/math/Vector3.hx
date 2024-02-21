package js.three.math;

typedef Vector3Tuple = Array<Float>;

/**
 * 3D vector.
 *
 * see {@link https://github.com/mrdoob/three.js/blob/master/src/math/Vector3.js}
 *
 * @example
 * const a = new THREE.Vector3( 1, 0, 0 );
 * const b = new THREE.Vector3( 0, 1, 0 );
 * const c = new THREE.Vector3();
 * c.crossVectors( a, b );
 */
/**
	
	 * 3D vector.
	 * 
	 * see {@link https://github.com/mrdoob/three.js/blob/master/src/math/Vector3.js}
	 * 
	 * @example
	 * const a = new THREE.Vector3( 1, 0, 0 );
	 * const b = new THREE.Vector3( 0, 1, 0 );
	 * const c = new THREE.Vector3();
	 * c.crossVectors( a, b );
	 
**/
@:native("THREE.Vector3") extern class Vector3 {
	/**
		
			 * 3D vector.
			 * 
			 * see {@link https://github.com/mrdoob/three.js/blob/master/src/math/Vector3.js}
			 * 
			 * @example
			 * const a = new THREE.Vector3( 1, 0, 0 );
			 * const b = new THREE.Vector3( 0, 1, 0 );
			 * const c = new THREE.Vector3();
			 * c.crossVectors( a, b );
			 
	**/
	function new(?x:Float, ?y:Float, ?z:Float):Void;
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
	var isVector3(default, null) : Bool;
	/**
		
			 * Sets value of this vector.
			 
	**/
	function set(x:Float, y:Float, z:Float):js.three.math.Vector3;
	/**
		
			 * Sets all values of this vector.
			 
	**/
	function setScalar(scalar:Float):js.three.math.Vector3;
	/**
		
			 * Sets x value of this vector.
			 
	**/
	function setX(x:Float):js.three.math.Vector3;
	/**
		
			 * Sets y value of this vector.
			 
	**/
	function setY(y:Float):js.three.math.Vector3;
	/**
		
			 * Sets z value of this vector.
			 
	**/
	function setZ(z:Float):js.three.math.Vector3;
	function setComponent(index:Int, value:Float):js.three.math.Vector3;
	function getComponent(index:Int):Float;
	/**
		
			 * Clones this vector.
			 
	**/
	function clone():js.three.math.Vector3;
	/**
		
			 * Copies value of v to this vector.
			 
	**/
	function copy(v:js.three.math.Vector3Like):js.three.math.Vector3;
	/**
		
			 * Adds v to this vector.
			 
	**/
	function add(v:js.three.math.Vector3Like):js.three.math.Vector3;
	function addScalar(s:Float):js.three.math.Vector3;
	/**
		
			 * Sets this vector to a + b.
			 
	**/
	function addVectors(a:js.three.math.Vector3Like, b:js.three.math.Vector3Like):js.three.math.Vector3;
	function addScaledVector(v:js.three.math.Vector3, s:Float):js.three.math.Vector3;
	/**
		
			 * Subtracts v from this vector.
			 
	**/
	function sub(a:js.three.math.Vector3Like):js.three.math.Vector3;
	function subScalar(s:Float):js.three.math.Vector3;
	/**
		
			 * Sets this vector to a - b.
			 
	**/
	function subVectors(a:js.three.math.Vector3Like, b:js.three.math.Vector3Like):js.three.math.Vector3;
	function multiply(v:js.three.math.Vector3Like):js.three.math.Vector3;
	/**
		
			 * Multiplies this vector by scalar s.
			 
	**/
	function multiplyScalar(s:Float):js.three.math.Vector3;
	function multiplyVectors(a:js.three.math.Vector3Like, b:js.three.math.Vector3Like):js.three.math.Vector3;
	function applyEuler(euler:js.three.math.Euler):js.three.math.Vector3;
	function applyAxisAngle(axis:js.three.math.Vector3, angle:Float):js.three.math.Vector3;
	function applyMatrix3(m:js.three.math.Matrix3):js.three.math.Vector3;
	function applyNormalMatrix(m:js.three.math.Matrix3):js.three.math.Vector3;
	function applyMatrix4(m:js.three.math.Matrix4):js.three.math.Vector3;
	function applyQuaternion(q:js.three.math.QuaternionLike):js.three.math.Vector3;
	function project(camera:js.three.cameras.Camera):js.three.math.Vector3;
	function unproject(camera:js.three.cameras.Camera):js.three.math.Vector3;
	function transformDirection(m:js.three.math.Matrix4):js.three.math.Vector3;
	function divide(v:js.three.math.Vector3Like):js.three.math.Vector3;
	/**
		
			 * Divides this vector by scalar s.
			 * Set vector to ( 0, 0, 0 ) if s == 0.
			 
	**/
	function divideScalar(s:Float):js.three.math.Vector3;
	function min(v:js.three.math.Vector3Like):js.three.math.Vector3;
	function max(v:js.three.math.Vector3Like):js.three.math.Vector3;
	function clamp(min:js.three.math.Vector3Like, max:js.three.math.Vector3Like):js.three.math.Vector3;
	function clampScalar(min:Float, max:Float):js.three.math.Vector3;
	function clampLength(min:Float, max:Float):js.three.math.Vector3;
	function floor():js.three.math.Vector3;
	function ceil():js.three.math.Vector3;
	function round():js.three.math.Vector3;
	function roundToZero():js.three.math.Vector3;
	/**
		
			 * Inverts this vector.
			 
	**/
	function negate():js.three.math.Vector3;
	/**
		
			 * Computes dot product of this vector and v.
			 
	**/
	function dot(v:js.three.math.Vector3Like):Float;
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
	function normalize():js.three.math.Vector3;
	/**
		
			 * Normalizes this vector and multiplies it by l.
			 
	**/
	function setLength(l:Float):js.three.math.Vector3;
	function lerp(v:js.three.math.Vector3Like, alpha:Float):js.three.math.Vector3;
	function lerpVectors(v1:js.three.math.Vector3Like, v2:js.three.math.Vector3Like, alpha:Float):js.three.math.Vector3;
	/**
		
			 * Sets this vector to cross product of itself and v.
			 
	**/
	function cross(a:js.three.math.Vector3Like):js.three.math.Vector3;
	/**
		
			 * Sets this vector to cross product of a and b.
			 
	**/
	function crossVectors(a:js.three.math.Vector3Like, b:js.three.math.Vector3Like):js.three.math.Vector3;
	function projectOnVector(v:js.three.math.Vector3):js.three.math.Vector3;
	function projectOnPlane(planeNormal:js.three.math.Vector3):js.three.math.Vector3;
	function reflect(vector:js.three.math.Vector3Like):js.three.math.Vector3;
	function angleTo(v:js.three.math.Vector3):Float;
	/**
		
			 * Computes distance of this vector to v.
			 
	**/
	function distanceTo(v:js.three.math.Vector3Like):Float;
	/**
		
			 * Computes squared distance of this vector to v.
			 
	**/
	function distanceToSquared(v:js.three.math.Vector3Like):Float;
	/**
		
			 * Computes the Manhattan length (distance) from this vector to the given vector v
			 * 
			 * see {@link http://en.wikipedia.org/wiki/Taxicab_geometry|Wikipedia: Taxicab Geometry}
			 
	**/
	function manhattanDistanceTo(v:js.three.math.Vector3Like):Float;
	function setFromSpherical(s:js.three.math.Spherical):js.three.math.Vector3;
	function setFromSphericalCoords(r:Float, phi:Float, theta:Float):js.three.math.Vector3;
	function setFromCylindrical(s:js.three.math.Cylindrical):js.three.math.Vector3;
	function setFromCylindricalCoords(radius:Float, theta:Float, y:Float):js.three.math.Vector3;
	function setFromMatrixPosition(m:js.three.math.Matrix4):js.three.math.Vector3;
	function setFromMatrixScale(m:js.three.math.Matrix4):js.three.math.Vector3;
	function setFromMatrixColumn(matrix:js.three.math.Matrix4, index:Int):js.three.math.Vector3;
	function setFromMatrix3Column(matrix:js.three.math.Matrix3, index:Int):js.three.math.Vector3;
	/**
		
			 * Sets this vector's {@link x}, {@link y} and {@link z} components from the x, y, and z components of the specified {@link Euler Euler Angle}.
			 
	**/
	function setFromEuler(e:js.three.math.Euler):js.three.math.Vector3;
	/**
		
			 * Sets this vector's {@link x}, {@link y} and {@link z} components from the r, g, and b components of the specified
			 * {@link Color | color}.
			 
	**/
	function setFromColor(color:js.three.math.Color.RGB):js.three.math.Vector3;
	/**
		
			 * Checks for strict equality of this vector and v.
			 
	**/
	function equals(v:js.three.math.Vector3Like):Bool;
	/**
		
			 * Sets this vector's x, y and z value from the provided array or array-like.
			 
	**/
	function fromArray(array:haxe.extern.EitherType<Array<Float>, js.three.ArrayLike<Float>>, ?offset:Float):js.three.math.Vector3;
	/**
		
			 * Returns an array [x, y, z], or copies x, y and z into the provided array.
			 * @return The created or provided array.
			 * Copies x, y and z into the provided array-like.
			 * @return The provided array-like.
			 
	**/
	@:overload(function(array:js.three.ArrayLike<Float>, ?offset:Float):js.three.ArrayLike<Float> { })
	@:overload(function(?array:js.three.math.Vector3.Vector3Tuple, ?offset:Int):js.three.math.Vector3.Vector3Tuple { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	function fromBufferAttribute(attribute:haxe.extern.EitherType<js.three.core.BufferAttribute, js.three.core.InterleavedBufferAttribute>, index:Int):js.three.math.Vector3;
	/**
		
			 * Sets this vector's x, y and z from Math.random
			 
	**/
	function random():js.three.math.Vector3;
	function randomDirection():js.three.math.Vector3;
}
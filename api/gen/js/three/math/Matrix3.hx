package js.three.math;

typedef Matrix3Tuple = Array<Float>;

/**
 * ( class Matrix3 implements Matrix<Matrix3> )
 */
/**
	
	 * ( class Matrix3 implements Matrix<Matrix3> )
	 
**/
@:native("THREE.Matrix3") extern class Matrix3 implements js.three.math.Matrix<js.three.math.Matrix3> {
	@:overload(function():Void { })
	function new(n11:Float, n12:Float, n13:Float, n21:Float, n22:Float, n23:Float, n31:Float, n32:Float, n33:Float):Void;
	/**
		
			 * Array with matrix values.
			 * @default [1, 0, 0, 0, 1, 0, 0, 0, 1]
			 
	**/
	var elements : Array<Float>;
	function set(n11:Float, n12:Float, n13:Float, n21:Float, n22:Float, n23:Float, n31:Float, n32:Float, n33:Float):js.three.math.Matrix3;
	function identity():js.three.math.Matrix3;
	function clone():js.three.math.Matrix3;
	function copy(m:js.three.math.Matrix3):js.three.math.Matrix3;
	function extractBasis(xAxis:js.three.math.Vector3, yAxis:js.three.math.Vector3, zAxis:js.three.math.Vector3):js.three.math.Matrix3;
	function setFromMatrix4(m:js.three.math.Matrix4):js.three.math.Matrix3;
	function multiplyScalar(s:Float):js.three.math.Matrix3;
	function determinant():Float;
	/**
		
			 * Inverts this matrix in place.
			 
	**/
	function invert():js.three.math.Matrix3;
	/**
		
			 * Transposes this matrix in place.
			 
	**/
	function transpose():js.three.math.Matrix3;
	function getNormalMatrix(matrix4:js.three.math.Matrix4):js.three.math.Matrix3;
	/**
		
			 * Transposes this matrix into the supplied array r, and returns itself.
			 
	**/
	function transposeIntoArray(r:Array<Float>):js.three.math.Matrix3;
	function setUvTransform(tx:Float, ty:Float, sx:Float, sy:Float, rotation:Float, cx:Float, cy:Float):js.three.math.Matrix3;
	function scale(sx:Float, sy:Float):js.three.math.Matrix3;
	/**
		
			 * Sets this matrix as a 2D translation transform:
			 * 
			 * ```
			 * 1, 0, x,
			 * 0, 1, y,
			 * 0, 0, 1
			 * ```
			 
	**/
	@:overload(function(x:Float, y:Float):js.three.math.Matrix3 { })
	function makeTranslation(v:js.three.math.Vector2):js.three.math.Matrix3;
	/**
		
			 * Sets this matrix as a 2D rotational transformation by theta radians. The resulting matrix will be:
			 * 
			 * ```
			 * cos(θ) -sin(θ) 0
			 * sin(θ) cos(θ)  0
			 * 0      0       1
			 * ```
			 
	**/
	function makeRotation(theta:Float):js.three.math.Matrix3;
	/**
		
			 * Sets this matrix as a 2D scale transform:
			 * 
			 * ```
			 * x, 0, 0,
			 * 0, y, 0,
			 * 0, 0, 1
			 * ```
			 
	**/
	function makeScale(x:Float, y:Float):js.three.math.Matrix3;
	function rotate(theta:Float):js.three.math.Matrix3;
	function translate(tx:Float, ty:Float):js.three.math.Matrix3;
	function equals(matrix:js.three.math.Matrix3):Bool;
	/**
		
			 * Sets the values of this matrix from the provided array or array-like.
			 
	**/
	function fromArray(array:haxe.extern.EitherType<Array<Float>, js.three.ArrayLike<Float>>, ?offset:Float):js.three.math.Matrix3;
	/**
		
			 * Returns an array with the values of this matrix, or copies them into the provided array.
			 * @return The created or provided array.
			 * Copies he values of this matrix into the provided array-like.
			 * @return The provided array-like.
			 
	**/
	@:overload(function(?array:js.three.ArrayLike<Float>, ?offset:Float):js.three.ArrayLike<Float> { })
	@:overload(function(?array:js.three.math.Matrix3.Matrix3Tuple, ?offset:Int):js.three.math.Matrix3.Matrix3Tuple { })
	function toArray(?array:Array<Float>, ?offset:Float):Array<Float>;
	/**
		
			 * Multiplies this matrix by m.
			 
	**/
	function multiply(m:js.three.math.Matrix3):js.three.math.Matrix3;
	function premultiply(m:js.three.math.Matrix3):js.three.math.Matrix3;
	/**
		
			 * Sets this matrix to a x b.
			 
	**/
	function multiplyMatrices(a:js.three.math.Matrix3, b:js.three.math.Matrix3):js.three.math.Matrix3;
	/**
		
			 * @deprecated Use {@link Vector3.applyMatrix3 vector.applyMatrix3( matrix )} instead.
			 
	**/
	function multiplyVector3(vector:js.three.math.Vector3):Dynamic;
	/**
		
			 * @deprecated This method has been removed completely.
			 
	**/
	function multiplyVector3Array(a:Dynamic):Dynamic;
	/**
		
			 * @deprecated Use {@link Matrix3#invert .invert()} instead.
			 
	**/
	@:overload(function(matrix:js.three.math.Matrix3):js.three.math.Matrix3 { })
	function getInverse(matrix:js.three.math.Matrix4, ?throwOnDegenerate:Bool):js.three.math.Matrix3;
	/**
		
			 * @deprecated Use {@link Matrix3#toArray .toArray()} instead.
			 
	**/
	function flattenToArrayOffset(array:Array<Float>, offset:Float):Array<Float>;
}
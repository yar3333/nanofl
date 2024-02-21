package js.three.core;

/**
 * @see {@link https://threejs.org/docs/index.html#api/en/core/InterleavedBufferAttribute | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InterleavedBufferAttribute.js | Source}
 */
/**
	
	 * @see {@link https://threejs.org/docs/index.html#api/en/core/InterleavedBufferAttribute | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InterleavedBufferAttribute.js | Source}
	 
**/
@:native("THREE.InterleavedBufferAttribute") extern class InterleavedBufferAttribute {
	/**
		
			 * @see {@link https://threejs.org/docs/index.html#api/en/core/InterleavedBufferAttribute | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InterleavedBufferAttribute.js | Source}
			 
	**/
	function new(interleavedBuffer:js.three.core.InterleavedBuffer, itemSize:Float, offset:Float, ?normalized:Bool):Void;
	/**
		
			 * Optional name for this attribute instance.
			 * @defaultValue `''`
			 
	**/
	var name : String;
	/**
		
			 * The {@link InterleavedBuffer | InterleavedBuffer} instance passed in the constructor.
			 
	**/
	var data : js.three.core.InterleavedBuffer;
	/**
		
			 * How many values make up each item.
			 * @remarks Expects a `Integer`
			 
	**/
	var itemSize : Float;
	/**
		
			 * The offset in the underlying array buffer where an item starts.
			 * @remarks Expects a `Integer`
			 
	**/
	var offset : Float;
	/**
		
			 * @defaultValue `false`
			 
	**/
	var normalized : Bool;
	/**
		
			 * Read-only flag to check if a given object is of type {@link InterleavedBufferAttribute}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isInterleavedBufferAttribute(default, null) : Bool;
	/**
		
			 * Applies matrix {@link Matrix4 | m} to every Vector3 element of this InterleavedBufferAttribute.
			 
	**/
	function applyMatrix4(m:js.three.math.Matrix4):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Applies normal matrix {@link Matrix3 | m} to every Vector3 element of this InterleavedBufferAttribute.
			 
	**/
	function applyNormalMatrix(m:js.three.math.Matrix3):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Applies matrix {@link Matrix4 | m} to every Vector3 element of this InterleavedBufferAttribute, interpreting the elements as a direction vectors.
			 
	**/
	function transformDirection(m:js.three.math.Matrix4):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Returns the given component of the vector at the given index.
			 
	**/
	function getComponent(index:Int, component:Float):Float;
	/**
		
			 * Sets the given component of the vector at the given index.
			 
	**/
	function setComponent(index:Int, component:Float, value:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Returns the x component of the item at the given index.
			 
	**/
	function getX(index:Int):Float;
	/**
		
			 * Sets the x component of the item at the given index.
			 
	**/
	function setX(index:Int, x:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Returns the y component of the item at the given index.
			 
	**/
	function getY(index:Int):Float;
	/**
		
			 * Sets the y component of the item at the given index.
			 
	**/
	function setY(index:Int, y:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Returns the z component of the item at the given index.
			 
	**/
	function getZ(index:Int):Float;
	/**
		
			 * Sets the z component of the item at the given index.
			 
	**/
	function setZ(index:Int, z:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Returns the w component of the item at the given index.
			 
	**/
	function getW(index:Int):Float;
	/**
		
			 * Sets the w component of the item at the given index.
			 
	**/
	function setW(index:Int, z:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Sets the x and y components of the item at the given index.
			 
	**/
	function setXY(index:Int, x:Float, y:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Sets the x, y and z components of the item at the given index.
			 
	**/
	function setXYZ(index:Int, x:Float, y:Float, z:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Sets the x, y, z and w components of the item at the given index.
			 
	**/
	function setXYZW(index:Int, x:Float, y:Float, z:Float, w:Float):js.three.core.InterleavedBufferAttribute;
	/**
		
			 * Creates a clone of this {@link InterleavedBufferAttribute}.
			 
	**/
	function clone(?data:{ }):js.three.core.BufferAttribute;
	/**
		
			 * Serializes this {@link InterleavedBufferAttribute}.
			 * Converting to {@link https://github.com/mrdoob/three.js/wiki/JSON-Geometry-format-4 | JSON Geometry format v4},
			 
	**/
	function toJSON(?data:{ }):{ var data : String; var isInterleavedBufferAttribute : Bool; var itemSize : Float; var normalized : Bool; var offset : Float; };
}
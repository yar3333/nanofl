package js.three.core;

typedef GLenum = Int;

/**
 * This buffer attribute class does not construct a VBO.
 * Instead, it uses whatever VBO is passed in constructor and can later be altered via the {@link buffer | .buffer} property.
 * @remarks
 * It is required to pass additional params alongside the VBO
 * Those are: the GL context, the GL data type, the number of components per vertex, the number of bytes per component, and the number of vertices.
 * @remarks
 * The most common use case for this class is when some kind of GPGPU calculation interferes or even produces the VBOs in question.
 * @see Example: {@link https://threejs.org/examples/#webgl_buffergeometry_glbufferattribute | WebGL / buffergeometry / glbufferattribute}
 * @see {@link https://threejs.org/docs/index.html#api/en/core/GLBufferAttribute | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/GLBufferAttribute.js | Source}
 */
/**
	
	 * This buffer attribute class does not construct a VBO.
	 * Instead, it uses whatever VBO is passed in constructor and can later be altered via the {@link buffer | .buffer} property.
	 * @remarks
	 * It is required to pass additional params alongside the VBO
	 * Those are: the GL context, the GL data type, the number of components per vertex, the number of bytes per component, and the number of vertices.
	 * @remarks
	 * The most common use case for this class is when some kind of GPGPU calculation interferes or even produces the VBOs in question.
	 * @see Example: {@link https://threejs.org/examples/#webgl_buffergeometry_glbufferattribute | WebGL / buffergeometry / glbufferattribute}
	 * @see {@link https://threejs.org/docs/index.html#api/en/core/GLBufferAttribute | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/GLBufferAttribute.js | Source}
	 
**/
@:native("THREE.GLBufferAttribute") extern class GLBufferAttribute {
	/**
		
			 * This buffer attribute class does not construct a VBO.
			 * Instead, it uses whatever VBO is passed in constructor and can later be altered via the {@link buffer | .buffer} property.
			 * @remarks
			 * It is required to pass additional params alongside the VBO
			 * Those are: the GL context, the GL data type, the number of components per vertex, the number of bytes per component, and the number of vertices.
			 * @remarks
			 * The most common use case for this class is when some kind of GPGPU calculation interferes or even produces the VBOs in question.
			 * @see Example: {@link https://threejs.org/examples/#webgl_buffergeometry_glbufferattribute | WebGL / buffergeometry / glbufferattribute}
			 * @see {@link https://threejs.org/docs/index.html#api/en/core/GLBufferAttribute | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/GLBufferAttribute.js | Source}
			 
	**/
	function new(buffer:js.html.webgl.WebGLBuffer, type:js.three.core.GLBufferAttribute.GLenum, itemSize:Float, elementSize:Int, count:Int):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link GLBufferAttribute}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isGLBufferAttribute(default, null) : Bool;
	/**
		
			 * Optional name for this attribute instance.
			 * @defaultValue `""`
			 
	**/
	var name : String;
	/**
		
			 * The current {@link https://developer.mozilla.org/en-US/docs/Web/API/WebGLBuffer | WebGLBuffer} instance.
			 
	**/
	var buffer : js.html.webgl.WebGLBuffer;
	/**
		
			 * A {@link https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Constants#Data_types | WebGL Data Type} describing the underlying VBO contents.
			 * 
			 * #### WebGL Data Type (`GLenum`)
			 * - gl.BYTE: 0x1400
			 * - gl.UNSIGNED_BYTE: 0x1401
			 * - gl.SHORT: 0x1402
			 * - gl.UNSIGNED_SHORT: 0x1403
			 * - gl.INT: 0x1404
			 * - gl.UNSIGNED_INT: 0x1405
			 * - gl.FLOAT: 0x1406
			 * @remarks Set this property together with {@link elementSize | .elementSize}. The recommended way is using the {@link setType | .setType()} method.
			 * @remarks Expects a `DataType` `GLenum` _possible values:_ `0x1400` `0x1401` `0x1402` `0x1403` `0x1404` `0x1405` `0x1406`
			 
	**/
	var type : js.three.core.GLBufferAttribute.GLenum;
	/**
		
			 * How many values make up each item (vertex).
			 * @remarks The number of values of the array that should be associated with a particular vertex.
			 * For instance, if this attribute is storing a 3-component vector (such as a position, normal, or color), then itemSize should be 3.
			 * @remarks Expects a `Integer`
			 
	**/
	var itemSize : Float;
	/**
		
			 * Stores the corresponding size in bytes for the current {@link type | .type} property value.
			 * 
			 * The corresponding size (_in bytes_) for the given "type" param.
			 * #### WebGL Data Type (`GLenum`)
			 * - gl.BYTE: 1
			 * - gl.UNSIGNED_BYTE: 1
			 * - gl.SHORT: 2
			 * - gl.UNSIGNED_SHORT: 2
			 * - gl.INT: 4
			 * - gl.UNSIGNED_INT: 4
			 * - gl.FLOAT: 4
			 * @remarks Set this property together with {@link type | .type}. The recommended way is using the {@link setType | .setType} method.
			 * @see `constructor`` for a list of known type sizes.
			 * @remarks Expects a `1`, `2` or `4`
			 
	**/
	var elementSize : Int;
	/**
		
			 * The expected number of vertices in VBO.
			 * @remarks Expects a `Integer`
			 
	**/
	var count : Int;
	/**
		
			 * A version number, incremented every time the needsUpdate property is set to true.
			 * @remarks Expects a `Integer`
			 
	**/
	var version : Float;
	/**
		
			 * Sets the {@link buffer | .buffer} property.
			 
	**/
	function setBuffer(buffer:js.html.webgl.WebGLBuffer):js.three.core.GLBufferAttribute;
	/**
		
			 * Sets the both {@link GLBufferAttribute.type | type} and {@link GLBufferAttribute.elementSize | elementSize} properties.
			 
	**/
	function setType(type:js.three.core.GLBufferAttribute.GLenum, elementSize:Int):js.three.core.GLBufferAttribute;
	/**
		
			 * Sets the {@link GLBufferAttribute.itemSize | itemSize} property.
			 
	**/
	function setItemSize(itemSize:Float):js.three.core.GLBufferAttribute;
	/**
		
			 * Sets the {@link GLBufferAttribute.count | count} property.
			 
	**/
	function setCount(count:Int):js.three.core.GLBufferAttribute;
}
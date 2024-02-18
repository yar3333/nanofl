package js.three.core;

/**
 * An instanced version of {@link THREE.InterleavedBuffer | InterleavedBuffer}.
 * @see {@link https://threejs.org/docs/index.html#api/en/core/InstancedInterleavedBuffer | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedInterleavedBuffer.js | Source}
 */
/**
	
	 * An instanced version of {@link THREE.InterleavedBuffer | InterleavedBuffer}.
	 * @see {@link https://threejs.org/docs/index.html#api/en/core/InstancedInterleavedBuffer | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedInterleavedBuffer.js | Source}
	 
**/
@:native("THREE.InstancedInterleavedBuffer") extern class InstancedInterleavedBuffer extends js.three.core.InterleavedBuffer {
	/**
		
			 * An instanced version of {@link THREE.InterleavedBuffer | InterleavedBuffer}.
			 * @see {@link https://threejs.org/docs/index.html#api/en/core/InstancedInterleavedBuffer | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedInterleavedBuffer.js | Source}
			 
	**/
	function new(array:js.three.core.TypedArray, stride:Float, ?meshPerAttribute:Float):Void;
	/**
		
			 * @defaultValue `1`
			 
	**/
	var meshPerAttribute : Float;
}
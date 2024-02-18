package js.three.core;

/**
 * An instanced version of {@link THREE.BufferGeometry | BufferGeometry}.
 * @see {@link https://threejs.org/docs/index.html#api/en/core/InstancedBufferGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedBufferGeometry.js | Source}
 */
/**
	
	 * An instanced version of {@link THREE.BufferGeometry | BufferGeometry}.
	 * @see {@link https://threejs.org/docs/index.html#api/en/core/InstancedBufferGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedBufferGeometry.js | Source}
	 
**/
@:native("THREE.InstancedBufferGeometry") extern class InstancedBufferGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * An instanced version of {@link THREE.BufferGeometry | BufferGeometry}.
			 * @see {@link https://threejs.org/docs/index.html#api/en/core/InstancedBufferGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/InstancedBufferGeometry.js | Source}
			 
	**/
	function new():Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link InstancedBufferGeometry}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isInstancedBufferGeometry(default, null) : Bool;
	/**
		
			 * @defaultValue `Infinity`
			 
	**/
	var instanceCount : Float;
	/**
		
			 * Copies the given {@link InstancedBufferGeometry} to this instance.
			 * @override
			 
	**/
	override function copy(source:js.three.core.InstancedBufferGeometry):js.three.core.InstancedBufferGeometry;
}
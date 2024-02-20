package js.three.helpers;

/**
 * An 3D arrow object for visualizing directions.
 * @example
 * ```typescript
 * const dir = new THREE.Vector3(1, 2, 0);
 * //normalize the direction vector (convert to vector of length 1)
 * dir.normalize();
 * const origin = new THREE.Vector3(0, 0, 0);
 * const length = 1;
 * const hex = 0xffff00;
 * const {@link ArrowHelper} = new THREE.ArrowHelper(dir, origin, length, hex);
 * scene.add(arrowHelper);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_shadowmesh | WebGL / shadowmesh}
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/ArrowHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/ArrowHelper.js | Source}
 */
/**
	
	 * An 3D arrow object for visualizing directions.
	 * @example
	 * ```typescript
	 * const dir = new THREE.Vector3(1, 2, 0);
	 * //normalize the direction vector (convert to vector of length 1)
	 * dir.normalize();
	 * const origin = new THREE.Vector3(0, 0, 0);
	 * const length = 1;
	 * const hex = 0xffff00;
	 * const {@link ArrowHelper} = new THREE.ArrowHelper(dir, origin, length, hex);
	 * scene.add(arrowHelper);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_shadowmesh | WebGL / shadowmesh}
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/ArrowHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/ArrowHelper.js | Source}
	 
**/
@:native("THREE.ArrowHelper") extern class ArrowHelper extends js.three.core.Object3D<js.three.core.Object3DEventMap> {
	/**
		
			 * An 3D arrow object for visualizing directions.
			 * @example
			 * ```typescript
			 * const dir = new THREE.Vector3(1, 2, 0);
			 * //normalize the direction vector (convert to vector of length 1)
			 * dir.normalize();
			 * const origin = new THREE.Vector3(0, 0, 0);
			 * const length = 1;
			 * const hex = 0xffff00;
			 * const {@link ArrowHelper} = new THREE.ArrowHelper(dir, origin, length, hex);
			 * scene.add(arrowHelper);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_shadowmesh | WebGL / shadowmesh}
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/ArrowHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/ArrowHelper.js | Source}
			 
	**/
	function new(?dir:js.three.math.Vector3, ?origin:js.three.math.Vector3, ?length:Float, ?color:js.three.math.ColorRepresentation, ?headLength:Float, ?headWidth:Float):Void;
	/**
		
			 * Contains the line part of the arrowHelper.
			 
	**/
	var line : js.three.objects.Line<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap>;
	/**
		
			 * Contains the cone part of the arrowHelper.
			 
	**/
	var cone : js.three.objects.Mesh<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap>;
	/**
		
			 * Sets the color of the arrowHelper.
			 
	**/
	function setColor(color:js.three.math.ColorRepresentation):Void;
	function setDirection(dir:js.three.math.Vector3):Void;
	/**
		
			 * Sets the length of the arrowhelper.
			 
	**/
	function setLength(length:Float, ?headLength:Float, ?headWidth:Float):Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
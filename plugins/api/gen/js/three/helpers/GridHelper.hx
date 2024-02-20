package js.three.helpers;

/**
 * The {@link GridHelper} is an object to define grids
 * @remarks
 * Grids are two-dimensional arrays of lines.
 * @example
 * ```typescript
 * const size = 10;
 * const divisions = 10;
 * const {@link GridHelper} = new THREE.GridHelper(size, divisions);
 * scene.add(gridHelper);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | WebGL / helpers}
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/GridHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/GridHelper.js | Source}
 */
/**
	
	 * The {@link GridHelper} is an object to define grids
	 * @remarks
	 * Grids are two-dimensional arrays of lines.
	 * @example
	 * ```typescript
	 * const size = 10;
	 * const divisions = 10;
	 * const {@link GridHelper} = new THREE.GridHelper(size, divisions);
	 * scene.add(gridHelper);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | WebGL / helpers}
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/GridHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/GridHelper.js | Source}
	 
**/
@:native("THREE.GridHelper") extern class GridHelper extends js.three.objects.LineSegments<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.LineBasicMaterial, js.three.core.Object3DEventMap> {
	/**
		
			 * The {@link GridHelper} is an object to define grids
			 * @remarks
			 * Grids are two-dimensional arrays of lines.
			 * @example
			 * ```typescript
			 * const size = 10;
			 * const divisions = 10;
			 * const {@link GridHelper} = new THREE.GridHelper(size, divisions);
			 * scene.add(gridHelper);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | WebGL / helpers}
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/GridHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/GridHelper.js | Source}
			 
	**/
	function new(?size:Float, ?divisions:Int, ?color1:js.three.math.ColorRepresentation, ?color2:js.three.math.ColorRepresentation):Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
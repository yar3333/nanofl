package js.three.geometries;

/**
 * This can be used as a helper object to view the edges of a {@link THREE.BufferGeometry | geometry}.
 * @example
 * ```typescript
 * const geometry = new THREE.BoxGeometry(100, 100, 100);
 * const edges = new THREE.EdgesGeometry(geometry);
 * const line = new THREE.LineSegments(edges, new THREE.LineBasicMaterial({
 *     color: 0xffffff
 * }));
 * scene.add(line);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | helpers}
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/EdgesGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/EdgesGeometry.js | Source}
 */
/**
	
	 * This can be used as a helper object to view the edges of a {@link THREE.BufferGeometry | geometry}.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.BoxGeometry(100, 100, 100);
	 * const edges = new THREE.EdgesGeometry(geometry);
	 * const line = new THREE.LineSegments(edges, new THREE.LineBasicMaterial({
	 *     color: 0xffffff
	 * }));
	 * scene.add(line);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | helpers}
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/EdgesGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/EdgesGeometry.js | Source}
	 
**/
@:native("THREE.EdgesGeometry") extern class EdgesGeometry<TBufferGeometry:(js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>)> extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * This can be used as a helper object to view the edges of a {@link THREE.BufferGeometry | geometry}.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.BoxGeometry(100, 100, 100);
			 * const edges = new THREE.EdgesGeometry(geometry);
			 * const line = new THREE.LineSegments(edges, new THREE.LineBasicMaterial({
			 *     color: 0xffffff
			 * }));
			 * scene.add(line);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | helpers}
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/EdgesGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/EdgesGeometry.js | Source}
			 
	**/
	function new(?geometry:TBufferGeometry, ?thresholdAngle:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var geometry(default, null) : TBufferGeometry; var thresholdAngle(default, null) : Float; };
}
package js.three.geometries;

/**
 * This can be used as a helper object to view a {@link BufferGeometry | geometry} as a wireframe.
 * @example
 * ```typescript
 * const geometry = new THREE.SphereGeometry(100, 100, 100);
 * const wireframe = new THREE.WireframeGeometry(geometry);
 * const line = new THREE.LineSegments(wireframe);
 * line.material.depthTest = false;
 * line.material.opacity = 0.25;
 * line.material.transparent = true;
 * scene.add(line);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | helpers}
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/WireframeGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/WireframeGeometry.js | Source}
 */
/**
	
	 * This can be used as a helper object to view a {@link BufferGeometry | geometry} as a wireframe.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.SphereGeometry(100, 100, 100);
	 * const wireframe = new THREE.WireframeGeometry(geometry);
	 * const line = new THREE.LineSegments(wireframe);
	 * line.material.depthTest = false;
	 * line.material.opacity = 0.25;
	 * line.material.transparent = true;
	 * scene.add(line);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | helpers}
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/WireframeGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/WireframeGeometry.js | Source}
	 
**/
@:native("THREE.WireframeGeometry") extern class WireframeGeometry<TBufferGeometry:(js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>)> extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * This can be used as a helper object to view a {@link BufferGeometry | geometry} as a wireframe.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.SphereGeometry(100, 100, 100);
			 * const wireframe = new THREE.WireframeGeometry(geometry);
			 * const line = new THREE.LineSegments(wireframe);
			 * line.material.depthTest = false;
			 * line.material.opacity = 0.25;
			 * line.material.transparent = true;
			 * scene.add(line);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_helpers | helpers}
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/WireframeGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/WireframeGeometry.js | Source}
			 
	**/
	function new(?geometry:TBufferGeometry):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var geometry(default, null) : TBufferGeometry; };
}
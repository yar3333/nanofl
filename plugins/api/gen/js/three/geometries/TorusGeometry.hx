package js.three.geometries;

/**
 * A class for generating torus geometries.
 * @example
 * ```typescript
 * const geometry = new THREE.TorusGeometry(10, 3, 16, 100);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffff00
 * });
 * const torus = new THREE.Mesh(geometry, material);
 * scene.add(torus);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TorusGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TorusGeometry.js | Source}
 */
/**
	
	 * A class for generating torus geometries.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.TorusGeometry(10, 3, 16, 100);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffff00
	 * });
	 * const torus = new THREE.Mesh(geometry, material);
	 * scene.add(torus);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TorusGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TorusGeometry.js | Source}
	 
**/
@:native("THREE.TorusGeometry") extern class TorusGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * A class for generating torus geometries.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.TorusGeometry(10, 3, 16, 100);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffff00
			 * });
			 * const torus = new THREE.Mesh(geometry, material);
			 * scene.add(torus);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TorusGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TorusGeometry.js | Source}
			 
	**/
	function new(?radius:Float, ?tube:Float, ?radialSegments:Int, ?tubularSegments:Float, ?arc:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var arc(default, null) : Float; var radialSegments(default, null) : Float; var radius(default, null) : Float; var tube(default, null) : Float; var tubularSegments(default, null) : Float; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:Dynamic):js.three.geometries.TorusGeometry;
}
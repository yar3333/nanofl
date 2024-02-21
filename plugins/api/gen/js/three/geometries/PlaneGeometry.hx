package js.three.geometries;

/**
 * A class for generating plane geometries.
 * @example
 * ```typescript
 * const geometry = new THREE.PlaneGeometry(1, 1);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffff00,
 *     side: THREE.DoubleSide
 * });
 * const plane = new THREE.Mesh(geometry, material);
 * scene.add(plane);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/PlaneGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/PlaneGeometry.js | Source}
 */
/**
	
	 * A class for generating plane geometries.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.PlaneGeometry(1, 1);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffff00,
	 *     side: THREE.DoubleSide
	 * });
	 * const plane = new THREE.Mesh(geometry, material);
	 * scene.add(plane);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/PlaneGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/PlaneGeometry.js | Source}
	 
**/
@:native("THREE.PlaneGeometry") extern class PlaneGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * A class for generating plane geometries.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.PlaneGeometry(1, 1);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffff00,
			 *     side: THREE.DoubleSide
			 * });
			 * const plane = new THREE.Mesh(geometry, material);
			 * scene.add(plane);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/PlaneGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/PlaneGeometry.js | Source}
			 
	**/
	function new(?width:Float, ?height:Float, ?widthSegments:Float, ?heightSegments:Int):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var height(default, null) : Float; var heightSegments(default, null) : Float; var width(default, null) : Float; var widthSegments(default, null) : Float; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.PlaneGeometry;
}
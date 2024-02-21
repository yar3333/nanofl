package js.three.geometries;

/**
 * A class for generating a two-dimensional ring geometry.
 * @example
 * ```typescript
 * const geometry = new THREE.RingGeometry(1, 5, 32);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffff00,
 *     side: THREE.DoubleSide
 * });
 * const mesh = new THREE.Mesh(geometry, material);
 * scene.add(mesh);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/RingGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/RingGeometry.js | Source}
 */
/**
	
	 * A class for generating a two-dimensional ring geometry.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.RingGeometry(1, 5, 32);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffff00,
	 *     side: THREE.DoubleSide
	 * });
	 * const mesh = new THREE.Mesh(geometry, material);
	 * scene.add(mesh);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/RingGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/RingGeometry.js | Source}
	 
**/
@:native("THREE.RingGeometry") extern class RingGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * A class for generating a two-dimensional ring geometry.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.RingGeometry(1, 5, 32);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffff00,
			 *     side: THREE.DoubleSide
			 * });
			 * const mesh = new THREE.Mesh(geometry, material);
			 * scene.add(mesh);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/RingGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/RingGeometry.js | Source}
			 
	**/
	function new(?innerRadius:Float, ?outerRadius:Float, ?thetaSegments:Float, ?phiSegments:Float, ?thetaStart:Float, ?thetaLength:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var innerRadius(default, null) : Float; var outerRadius(default, null) : Float; var phiSegments(default, null) : Float; var thetaLength(default, null) : Float; var thetaSegments(default, null) : Float; var thetaStart(default, null) : Float; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.RingGeometry;
}
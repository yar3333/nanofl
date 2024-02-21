package js.three.geometries;

/**
 * A class for generating sphere geometries.
 * @example
 * ```typescript
 * const geometry = new THREE.SphereGeometry(15, 32, 16);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffff00
 * });
 * const sphere = new THREE.Mesh(geometry, material);
 * scene.add(sphere);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/SphereGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/SphereGeometry.js | Source}
 */
/**
	
	 * A class for generating sphere geometries.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.SphereGeometry(15, 32, 16);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffff00
	 * });
	 * const sphere = new THREE.Mesh(geometry, material);
	 * scene.add(sphere);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/SphereGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/SphereGeometry.js | Source}
	 
**/
@:native("THREE.SphereGeometry") extern class SphereGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * A class for generating sphere geometries.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.SphereGeometry(15, 32, 16);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffff00
			 * });
			 * const sphere = new THREE.Mesh(geometry, material);
			 * scene.add(sphere);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/SphereGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/SphereGeometry.js | Source}
			 
	**/
	function new(?radius:Float, ?widthSegments:Float, ?heightSegments:Int, ?phiStart:Float, ?phiLength:Float, ?thetaStart:Float, ?thetaLength:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var heightSegments(default, null) : Float; var phiLength(default, null) : Float; var phiStart(default, null) : Float; var radius(default, null) : Float; var thetaLength(default, null) : Float; var thetaStart(default, null) : Float; var widthSegments(default, null) : Float; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.SphereGeometry;
}
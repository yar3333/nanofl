package js.three.geometries;

/**
 * A class for generating cone geometries.
 * @example
 * ```typescript
 * const geometry = new THREE.ConeGeometry(5, 20, 32);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffff00
 * });
 * const cone = new THREE.Mesh(geometry, material);
 * scene.add(cone);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/ConeGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/ConeGeometry.js | Source}
 */
/**
	
	 * A class for generating cone geometries.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.ConeGeometry(5, 20, 32);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffff00
	 * });
	 * const cone = new THREE.Mesh(geometry, material);
	 * scene.add(cone);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/ConeGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/ConeGeometry.js | Source}
	 
**/
@:native("THREE.ConeGeometry") extern class ConeGeometry extends js.three.geometries.CylinderGeometry {
	/**
		
			 * A class for generating cone geometries.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.ConeGeometry(5, 20, 32);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffff00
			 * });
			 * const cone = new THREE.Mesh(geometry, material);
			 * scene.add(cone);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/ConeGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/ConeGeometry.js | Source}
			 
	**/
	function new(?radius:Float, ?height:Float, ?radialSegments:Int, ?heightSegments:Int, ?openEnded:Bool, ?thetaStart:Float, ?thetaLength:Float):Void;
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.ConeGeometry;
}
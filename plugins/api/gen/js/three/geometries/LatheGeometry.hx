package js.three.geometries;

/**
 * Creates meshes with axial symmetry like vases
 * @remarks
 * The lathe rotates around the Y axis.
 * @example
 * ```typescript
 * const points = [];
 * for (let i = 0; i & lt; 10; i++) {
 *     points.push(new THREE.Vector2(Math.sin(i * 0.2) * 10 + 5, (i - 5) * 2));
 * }
 * const geometry = new THREE.LatheGeometry(points);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffff00
 * });
 * const lathe = new THREE.Mesh(geometry, material);
 * scene.add(lathe);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/LatheGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/LatheGeometry.js | Source}
 */
/**
	
	 * Creates meshes with axial symmetry like vases
	 * @remarks
	 * The lathe rotates around the Y axis.
	 * @example
	 * ```typescript
	 * const points = [];
	 * for (let i = 0; i & lt; 10; i++) {
	 *     points.push(new THREE.Vector2(Math.sin(i * 0.2) * 10 + 5, (i - 5) * 2));
	 * }
	 * const geometry = new THREE.LatheGeometry(points);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffff00
	 * });
	 * const lathe = new THREE.Mesh(geometry, material);
	 * scene.add(lathe);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/LatheGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/LatheGeometry.js | Source}
	 
**/
@:native("THREE.LatheGeometry") extern class LatheGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * Creates meshes with axial symmetry like vases
			 * @remarks
			 * The lathe rotates around the Y axis.
			 * @example
			 * ```typescript
			 * const points = [];
			 * for (let i = 0; i & lt; 10; i++) {
			 *     points.push(new THREE.Vector2(Math.sin(i * 0.2) * 10 + 5, (i - 5) * 2));
			 * }
			 * const geometry = new THREE.LatheGeometry(points);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffff00
			 * });
			 * const lathe = new THREE.Mesh(geometry, material);
			 * scene.add(lathe);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/LatheGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/LatheGeometry.js | Source}
			 
	**/
	function new(?points:Array<js.three.math.Vector2>, ?segments:Int, ?phiStart:Float, ?phiLength:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var phiLength(default, null) : Float; var phiStart(default, null) : Float; var points(default, null) : Array<js.three.math.Vector2>; var segments(default, null) : Float; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.LatheGeometry;
}
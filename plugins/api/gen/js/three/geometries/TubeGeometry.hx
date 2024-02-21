package js.three.geometries;

/**
 * Creates a tube that extrudes along a 3d curve.
 * @example
 * ```typescript
 * class CustomSinCurve extends THREE.Curve {
 *     constructor(scale = 1) {
 *         super();
 *         this.scale = scale;
 *     }
 *     getPoint(t, optionalTarget = new THREE.Vector3()) {
 *         const tx = t * 3 - 1.5;
 *         const ty = Math.sin(2 * Math.PI * t);
 *         const tz = 0;
 *         return optionalTarget.set(tx, ty, tz).multiplyScalar(this.scale);
 *     }
 * }
 * const path = new CustomSinCurve(10);
 * const geometry = new THREE.TubeGeometry(path, 20, 2, 8, false);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0x00ff00
 * });
 * const mesh = new THREE.Mesh(geometry, material);
 * scene.add(mesh);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TubeGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TubeGeometry.js | Source}
 */
/**
	
	 * Creates a tube that extrudes along a 3d curve.
	 * @example
	 * ```typescript
	 * class CustomSinCurve extends THREE.Curve {
	 *     constructor(scale = 1) {
	 *         super();
	 *         this.scale = scale;
	 *     }
	 *     getPoint(t, optionalTarget = new THREE.Vector3()) {
	 *         const tx = t * 3 - 1.5;
	 *         const ty = Math.sin(2 * Math.PI * t);
	 *         const tz = 0;
	 *         return optionalTarget.set(tx, ty, tz).multiplyScalar(this.scale);
	 *     }
	 * }
	 * const path = new CustomSinCurve(10);
	 * const geometry = new THREE.TubeGeometry(path, 20, 2, 8, false);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0x00ff00
	 * });
	 * const mesh = new THREE.Mesh(geometry, material);
	 * scene.add(mesh);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TubeGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TubeGeometry.js | Source}
	 
**/
@:native("THREE.TubeGeometry") extern class TubeGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * Creates a tube that extrudes along a 3d curve.
			 * @example
			 * ```typescript
			 * class CustomSinCurve extends THREE.Curve {
			 *     constructor(scale = 1) {
			 *         super();
			 *         this.scale = scale;
			 *     }
			 *     getPoint(t, optionalTarget = new THREE.Vector3()) {
			 *         const tx = t * 3 - 1.5;
			 *         const ty = Math.sin(2 * Math.PI * t);
			 *         const tz = 0;
			 *         return optionalTarget.set(tx, ty, tz).multiplyScalar(this.scale);
			 *     }
			 * }
			 * const path = new CustomSinCurve(10);
			 * const geometry = new THREE.TubeGeometry(path, 20, 2, 8, false);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0x00ff00
			 * });
			 * const mesh = new THREE.Mesh(geometry, material);
			 * scene.add(mesh);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TubeGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TubeGeometry.js | Source}
			 
	**/
	function new(?path:js.three.extras.core.Curve<js.three.math.Vector3>, ?tubularSegments:Float, ?radius:Float, ?radialSegments:Int, ?closed:Bool):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var closed(default, null) : Bool; var path(default, null) : js.three.extras.core.Curve<js.three.math.Vector3>; var radialSegments(default, null) : Float; var radius(default, null) : Float; var tubularSegments(default, null) : Float; };
	/**
		
			 * An array of {@link THREE.Vector3 | Vector3} tangents
			 
	**/
	var tangents : Array<js.three.math.Vector3>;
	/**
		
			 * An array of {@link THREE.Vector3 | Vector3} normals
			 
	**/
	var normals : Array<js.three.math.Vector3>;
	/**
		
			 * An array of {@link THREE.Vector3 | Vector3} binormals
			 
	**/
	var binormals : Array<js.three.math.Vector3>;
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.TubeGeometry;
}
package js.three.geometries;

/**
 * {@link BoxGeometry} is a geometry class for a rectangular cuboid with a given 'width', 'height', and 'depth'
 * @remarks On creation, the cuboid is centred on the origin, with each edge parallel to one of the axes.
 * @example
 * ```typescript
 * const geometry = new THREE.BoxGeometry(1, 1, 1);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0x00ff00
 * });
 * const cube = new THREE.Mesh(geometry, material);
 * scene.add(cube);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/BoxGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/BoxGeometry.js | Source}
 */
/**
	
	 * {@link BoxGeometry} is a geometry class for a rectangular cuboid with a given 'width', 'height', and 'depth'
	 * @remarks On creation, the cuboid is centred on the origin, with each edge parallel to one of the axes.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.BoxGeometry(1, 1, 1);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0x00ff00
	 * });
	 * const cube = new THREE.Mesh(geometry, material);
	 * scene.add(cube);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/BoxGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/BoxGeometry.js | Source}
	 
**/
@:native("THREE.BoxGeometry") extern class BoxGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * {@link BoxGeometry} is a geometry class for a rectangular cuboid with a given 'width', 'height', and 'depth'
			 * @remarks On creation, the cuboid is centred on the origin, with each edge parallel to one of the axes.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.BoxGeometry(1, 1, 1);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0x00ff00
			 * });
			 * const cube = new THREE.Mesh(geometry, material);
			 * scene.add(cube);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/BoxGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/BoxGeometry.js | Source}
			 
	**/
	function new(?width:Float, ?height:Float, ?depth:Float, ?widthSegments:Float, ?heightSegments:Int, ?depthSegments:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var depth(default, null) : Float; var depthSegments(default, null) : Float; var height(default, null) : Float; var heightSegments(default, null) : Float; var width(default, null) : Float; var widthSegments(default, null) : Float; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.BoxGeometry;
}
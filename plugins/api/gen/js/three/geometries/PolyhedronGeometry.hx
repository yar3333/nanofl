package js.three.geometries;

/**
 * A polyhedron is a solid in three dimensions with flat faces
 * @remarks
 * This class will take an array of vertices, project them onto a sphere, and then divide them up to the desired level of detail
 * This class is used by {@link THREE.DodecahedronGeometry | DodecahedronGeometry}, {@link THREE.IcosahedronGeometry | IcosahedronGeometry},
 * {@link THREE.OctahedronGeometry | OctahedronGeometry}, and {@link THREE.TetrahedronGeometry | TetrahedronGeometry} to generate their respective geometries.
 * @example
 * ```typescript
 * const verticesOfCube = [-1, -1, -1, 1, -1, -1, 1, 1, -1, -1, 1, -1, -1, -1, 1, 1, -1, 1, 1, 1, 1, -1, 1, 1, ];
 * const indicesOfFaces = [
 * 2, 1, 0, 0, 3, 2,
 * 0, 4, 7, 7, 3, 0,
 * 0, 1, 5, 5, 4, 0,
 * 1, 2, 6, 6, 5, 1,
 * 2, 3, 7, 7, 6, 2,
 * 4, 5, 6, 6, 7, 4];
 * const geometry = new THREE.PolyhedronGeometry(verticesOfCube, indicesOfFaces, 6, 2);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/PolyhedronGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/PolyhedronGeometry.js | Source}
 */
/**
	
	 * A polyhedron is a solid in three dimensions with flat faces
	 * @remarks
	 * This class will take an array of vertices, project them onto a sphere, and then divide them up to the desired level of detail
	 * This class is used by {@link THREE.DodecahedronGeometry | DodecahedronGeometry}, {@link THREE.IcosahedronGeometry | IcosahedronGeometry},
	 * {@link THREE.OctahedronGeometry | OctahedronGeometry}, and {@link THREE.TetrahedronGeometry | TetrahedronGeometry} to generate their respective geometries.
	 * @example
	 * ```typescript
	 * const verticesOfCube = [-1, -1, -1, 1, -1, -1, 1, 1, -1, -1, 1, -1, -1, -1, 1, 1, -1, 1, 1, 1, 1, -1, 1, 1, ];
	 * const indicesOfFaces = [
	 * 2, 1, 0, 0, 3, 2,
	 * 0, 4, 7, 7, 3, 0,
	 * 0, 1, 5, 5, 4, 0,
	 * 1, 2, 6, 6, 5, 1,
	 * 2, 3, 7, 7, 6, 2,
	 * 4, 5, 6, 6, 7, 4];
	 * const geometry = new THREE.PolyhedronGeometry(verticesOfCube, indicesOfFaces, 6, 2);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/PolyhedronGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/PolyhedronGeometry.js | Source}
	 
**/
@:native("THREE.PolyhedronGeometry") extern class PolyhedronGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * A polyhedron is a solid in three dimensions with flat faces
			 * @remarks
			 * This class will take an array of vertices, project them onto a sphere, and then divide them up to the desired level of detail
			 * This class is used by {@link THREE.DodecahedronGeometry | DodecahedronGeometry}, {@link THREE.IcosahedronGeometry | IcosahedronGeometry},
			 * {@link THREE.OctahedronGeometry | OctahedronGeometry}, and {@link THREE.TetrahedronGeometry | TetrahedronGeometry} to generate their respective geometries.
			 * @example
			 * ```typescript
			 * const verticesOfCube = [-1, -1, -1, 1, -1, -1, 1, 1, -1, -1, 1, -1, -1, -1, 1, 1, -1, 1, 1, 1, 1, -1, 1, 1, ];
			 * const indicesOfFaces = [
			 * 2, 1, 0, 0, 3, 2,
			 * 0, 4, 7, 7, 3, 0,
			 * 0, 1, 5, 5, 4, 0,
			 * 1, 2, 6, 6, 5, 1,
			 * 2, 3, 7, 7, 6, 2,
			 * 4, 5, 6, 6, 7, 4];
			 * const geometry = new THREE.PolyhedronGeometry(verticesOfCube, indicesOfFaces, 6, 2);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/PolyhedronGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/PolyhedronGeometry.js | Source}
			 
	**/
	function new(?vertices:Array<Float>, ?indices:Array<Float>, ?radius:Float, ?detail:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var detail(default, null) : Float; var indices(default, null) : Array<Float>; var radius(default, null) : Float; var vertices(default, null) : Array<Float>; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.PolyhedronGeometry;
}
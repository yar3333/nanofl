package js.three.geometries;

/**
 * A class for generating a tetrahedron geometries.
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TetrahedronGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TetrahedronGeometry.js | Source}
 */
/**
	
	 * A class for generating a tetrahedron geometries.
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TetrahedronGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TetrahedronGeometry.js | Source}
	 
**/
@:native("THREE.TetrahedronGeometry") extern class TetrahedronGeometry extends js.three.geometries.PolyhedronGeometry {
	/**
		
			 * A class for generating a tetrahedron geometries.
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/TetrahedronGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/TetrahedronGeometry.js | Source}
			 
	**/
	function new(?radius:Float, ?detail:Float):Void;
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.TetrahedronGeometry;
}
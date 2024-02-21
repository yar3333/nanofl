package js.three.geometries;

/**
 * A class for generating a dodecahedron geometries.
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/DodecahedronGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/DodecahedronGeometry.js | Source}
 */
/**
	
	 * A class for generating a dodecahedron geometries.
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/DodecahedronGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/DodecahedronGeometry.js | Source}
	 
**/
@:native("THREE.DodecahedronGeometry") extern class DodecahedronGeometry extends js.three.geometries.PolyhedronGeometry {
	/**
		
			 * A class for generating a dodecahedron geometries.
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/DodecahedronGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/DodecahedronGeometry.js | Source}
			 
	**/
	function new(?radius:Float, ?detail:Float):Void;
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.DodecahedronGeometry;
}
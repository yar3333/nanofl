package js.three.geometries;

/**
 * A class for generating an octahedron geometry.
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/OctahedronGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/OctahedronGeometry.js | Source}
 */
/**
	
	 * A class for generating an octahedron geometry.
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/OctahedronGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/OctahedronGeometry.js | Source}
	 
**/
@:native("THREE.OctahedronGeometry") extern class OctahedronGeometry extends js.three.geometries.PolyhedronGeometry {
	/**
		
			 * A class for generating an octahedron geometry.
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/OctahedronGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/OctahedronGeometry.js | Source}
			 
	**/
	function new(?radius:Float, ?detail:Float):Void;
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.OctahedronGeometry;
}
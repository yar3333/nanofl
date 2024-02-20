package js.three.geometries;

/**
 * A class for generating an icosahedron geometry.
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/IcosahedronGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/IcosahedronGeometry.js | Source}
 */
/**
	
	 * A class for generating an icosahedron geometry.
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/IcosahedronGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/IcosahedronGeometry.js | Source}
	 
**/
@:native("THREE.IcosahedronGeometry") extern class IcosahedronGeometry extends js.three.geometries.PolyhedronGeometry {
	/**
		
			 * A class for generating an icosahedron geometry.
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/IcosahedronGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/IcosahedronGeometry.js | Source}
			 
	**/
	function new(?radius:Float, ?detail:Float):Void;
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.IcosahedronGeometry;
}
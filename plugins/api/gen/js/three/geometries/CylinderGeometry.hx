package js.three.geometries;

/**
 * A class for generating cylinder geometries.
 * @example
 * ```typescript
 * const geometry = new THREE.CylinderGeometry(5, 5, 20, 32);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0xffff00
 * });
 * const cylinder = new THREE.Mesh(geometry, material);
 * scene.add(cylinder);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/CylinderGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/CylinderGeometry.js | Source}
 */
/**
	
	 * A class for generating cylinder geometries.
	 * @example
	 * ```typescript
	 * const geometry = new THREE.CylinderGeometry(5, 5, 20, 32);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0xffff00
	 * });
	 * const cylinder = new THREE.Mesh(geometry, material);
	 * scene.add(cylinder);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/CylinderGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/CylinderGeometry.js | Source}
	 
**/
@:native("THREE.CylinderGeometry") extern class CylinderGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * A class for generating cylinder geometries.
			 * @example
			 * ```typescript
			 * const geometry = new THREE.CylinderGeometry(5, 5, 20, 32);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0xffff00
			 * });
			 * const cylinder = new THREE.Mesh(geometry, material);
			 * scene.add(cylinder);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/CylinderGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/CylinderGeometry.js | Source}
			 
	**/
	function new(?radiusTop:Float, ?radiusBottom:Float, ?height:Float, ?radialSegments:Int, ?heightSegments:Int, ?openEnded:Bool, ?thetaStart:Float, ?thetaLength:Float):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var height(default, null) : Float; var heightSegments(default, null) : Float; var openEnded(default, null) : Bool; var radialSegments(default, null) : Float; var radiusBottom(default, null) : Float; var radiusTop(default, null) : Float; var thetaLength(default, null) : Float; var thetaStart(default, null) : Float; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:Dynamic):js.three.geometries.CylinderGeometry;
}
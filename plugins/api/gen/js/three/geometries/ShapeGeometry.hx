package js.three.geometries;

/**
 * Creates an one-sided polygonal geometry from one or more path shapes.
 * @example
 * ```typescript
 * const x = 0, y = 0;
 * const heartShape = new THREE.Shape();
 * heartShape.moveTo(x + 5, y + 5);
 * heartShape.bezierCurveTo(x + 5, y + 5, x + 4, y, x, y);
 * heartShape.bezierCurveTo(x - 6, y, x - 6, y + 7, x - 6, y + 7);
 * heartShape.bezierCurveTo(x - 6, y + 11, x - 3, y + 15.4, x + 5, y + 19);
 * heartShape.bezierCurveTo(x + 12, y + 15.4, x + 16, y + 11, x + 16, y + 7);
 * heartShape.bezierCurveTo(x + 16, y + 7, x + 16, y, x + 10, y);
 * heartShape.bezierCurveTo(x + 7, y, x + 5, y + 5, x + 5, y + 5);
 * const geometry = new THREE.ShapeGeometry(heartShape);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0x00ff00
 * });
 * const mesh = new THREE.Mesh(geometry, material);
 * scene.add(mesh);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/ShapeGeometry | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/ShapeGeometry.js | Source}
 */
/**
	
	 * Creates an one-sided polygonal geometry from one or more path shapes.
	 * @example
	 * ```typescript
	 * const x = 0, y = 0;
	 * const heartShape = new THREE.Shape();
	 * heartShape.moveTo(x + 5, y + 5);
	 * heartShape.bezierCurveTo(x + 5, y + 5, x + 4, y, x, y);
	 * heartShape.bezierCurveTo(x - 6, y, x - 6, y + 7, x - 6, y + 7);
	 * heartShape.bezierCurveTo(x - 6, y + 11, x - 3, y + 15.4, x + 5, y + 19);
	 * heartShape.bezierCurveTo(x + 12, y + 15.4, x + 16, y + 11, x + 16, y + 7);
	 * heartShape.bezierCurveTo(x + 16, y + 7, x + 16, y, x + 10, y);
	 * heartShape.bezierCurveTo(x + 7, y, x + 5, y + 5, x + 5, y + 5);
	 * const geometry = new THREE.ShapeGeometry(heartShape);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0x00ff00
	 * });
	 * const mesh = new THREE.Mesh(geometry, material);
	 * scene.add(mesh);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/ShapeGeometry | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/ShapeGeometry.js | Source}
	 
**/
@:native("THREE.ShapeGeometry") extern class ShapeGeometry extends js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes> {
	/**
		
			 * Creates an one-sided polygonal geometry from one or more path shapes.
			 * @example
			 * ```typescript
			 * const x = 0, y = 0;
			 * const heartShape = new THREE.Shape();
			 * heartShape.moveTo(x + 5, y + 5);
			 * heartShape.bezierCurveTo(x + 5, y + 5, x + 4, y, x, y);
			 * heartShape.bezierCurveTo(x - 6, y, x - 6, y + 7, x - 6, y + 7);
			 * heartShape.bezierCurveTo(x - 6, y + 11, x - 3, y + 15.4, x + 5, y + 19);
			 * heartShape.bezierCurveTo(x + 12, y + 15.4, x + 16, y + 11, x + 16, y + 7);
			 * heartShape.bezierCurveTo(x + 16, y + 7, x + 16, y, x + 10, y);
			 * heartShape.bezierCurveTo(x + 7, y, x + 5, y + 5, x + 5, y + 5);
			 * const geometry = new THREE.ShapeGeometry(heartShape);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0x00ff00
			 * });
			 * const mesh = new THREE.Mesh(geometry, material);
			 * scene.add(mesh);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/geometries/ShapeGeometry | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/geometries/ShapeGeometry.js | Source}
			 
	**/
	function new(?shapes:haxe.extern.EitherType<js.three.extras.core.Shape, Array<js.three.extras.core.Shape>>, ?curveSegments:Int):Void;
	/**
		
			 * An object with a property for each of the constructor parameters.
			 * @remarks Any modification after instantiation does not change the geometry.
			 
	**/
	var parameters(default, null) : { var curveSegments(default, null) : Float; var shapes(default, null) : haxe.extern.EitherType<js.three.extras.core.Shape, Array<js.three.extras.core.Shape>>; };
	/**
		
			 * @internal 
			 
	**/
	static function fromJSON(data:{ }):js.three.geometries.ShapeGeometry;
}
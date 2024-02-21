package js.three.helpers;

/**
 * Helper object to visualize a {@link THREE.Plane | Plane}.
 * @example
 * ```typescript
 * const plane = new THREE.Plane(new THREE.Vector3(1, 1, 0.2), 3);
 * const helper = new THREE.PlaneHelper(plane, 1, 0xffff00);
 * scene.add(helper);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/PlaneHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/PlaneHelper.js | Source}
 */
/**
	
	 * Helper object to visualize a {@link THREE.Plane | Plane}.
	 * @example
	 * ```typescript
	 * const plane = new THREE.Plane(new THREE.Vector3(1, 1, 0.2), 3);
	 * const helper = new THREE.PlaneHelper(plane, 1, 0xffff00);
	 * scene.add(helper);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/PlaneHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/PlaneHelper.js | Source}
	 
**/
@:native("THREE.PlaneHelper") extern class PlaneHelper extends js.three.objects.LineSegments<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap> {
	/**
		
			 * Helper object to visualize a {@link THREE.Plane | Plane}.
			 * @example
			 * ```typescript
			 * const plane = new THREE.Plane(new THREE.Vector3(1, 1, 0.2), 3);
			 * const helper = new THREE.PlaneHelper(plane, 1, 0xffff00);
			 * scene.add(helper);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/PlaneHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/PlaneHelper.js | Source}
			 
	**/
	function new(plane:js.three.math.Plane, ?size:Float, ?hex:Int):Void;
	/**
		
			 * The {@link Plane | plane} being visualized.
			 
	**/
	var plane : js.three.math.Plane;
	/**
		
			 * The side lengths of plane helper.
			 * @remarks Expects a `Float`
			 * @defaultValue `1`
			 
	**/
	var size : Float;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
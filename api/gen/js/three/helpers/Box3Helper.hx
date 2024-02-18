package js.three.helpers;

/**
 * Helper object to visualize a {@link THREE.Box3 | Box3}.
 * @example
 * ```typescript
 * const box = new THREE.Box3();
 * box.setFromCenterAndSize(new THREE.Vector3(1, 1, 1), new THREE.Vector3(2, 1, 3));
 * const helper = new THREE.Box3Helper(box, 0xffff00);
 * scene.add(helper);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/Box3Helper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/Box3Helper.js | Source}
 */
/**
	
	 * Helper object to visualize a {@link THREE.Box3 | Box3}.
	 * @example
	 * ```typescript
	 * const box = new THREE.Box3();
	 * box.setFromCenterAndSize(new THREE.Vector3(1, 1, 1), new THREE.Vector3(2, 1, 3));
	 * const helper = new THREE.Box3Helper(box, 0xffff00);
	 * scene.add(helper);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/Box3Helper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/Box3Helper.js | Source}
	 
**/
@:native("THREE.Box3Helper") extern class Box3Helper extends js.three.objects.LineSegments<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap> {
	/**
		
			 * Helper object to visualize a {@link THREE.Box3 | Box3}.
			 * @example
			 * ```typescript
			 * const box = new THREE.Box3();
			 * box.setFromCenterAndSize(new THREE.Vector3(1, 1, 1), new THREE.Vector3(2, 1, 3));
			 * const helper = new THREE.Box3Helper(box, 0xffff00);
			 * scene.add(helper);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/Box3Helper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/Box3Helper.js | Source}
			 
	**/
	function new(box:js.three.math.Box3, ?color:js.three.math.ColorRepresentation):Void;
	/**
		
			 * The Box3 being visualized.
			 
	**/
	var box : js.three.math.Box3;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
package js.three.objects;

/**
 * Its purpose is to make working with groups of objects syntactically clearer.
 * @remarks This is almost identical to an {@link Object3D | Object3D}
 * @example
 * ```typescript
 * const geometry = new THREE.BoxGeometry(1, 1, 1);
 * const material = new THREE.MeshBasicMaterial({
 *     color: 0x00ff00
 * });
 * const cubeA = new THREE.Mesh(geometry, material);
 * cubeA.position.set(100, 100, 0);
 * const cubeB = new THREE.Mesh(geometry, material);
 * cubeB.position.set(-100, -100, 0);
 * //create a {@link Group} and add the two cubes
 * //These cubes can now be rotated / scaled etc as a {@link Group}  * const {@link Group} = new THREE.Group();
 * group.add(cubeA);
 * group.add(cubeB);
 * scene.add(group);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Group | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Group.js | Source}
 */
/**
	
	 * Its purpose is to make working with groups of objects syntactically clearer.
	 * @remarks This is almost identical to an {@link Object3D | Object3D}
	 * @example
	 * ```typescript
	 * const geometry = new THREE.BoxGeometry(1, 1, 1);
	 * const material = new THREE.MeshBasicMaterial({
	 *     color: 0x00ff00
	 * });
	 * const cubeA = new THREE.Mesh(geometry, material);
	 * cubeA.position.set(100, 100, 0);
	 * const cubeB = new THREE.Mesh(geometry, material);
	 * cubeB.position.set(-100, -100, 0);
	 * //create a {@link Group} and add the two cubes
	 * //These cubes can now be rotated / scaled etc as a {@link Group}  * const {@link Group} = new THREE.Group();
	 * group.add(cubeA);
	 * group.add(cubeB);
	 * scene.add(group);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Group | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Group.js | Source}
	 
**/
@:native("THREE.Group") extern class Group<TEventMap:(js.three.core.Object3DEventMap)> extends js.three.core.Object3D<TEventMap> {
	/**
		
			 * Its purpose is to make working with groups of objects syntactically clearer.
			 * @remarks This is almost identical to an {@link Object3D | Object3D}
			 * @example
			 * ```typescript
			 * const geometry = new THREE.BoxGeometry(1, 1, 1);
			 * const material = new THREE.MeshBasicMaterial({
			 *     color: 0x00ff00
			 * });
			 * const cubeA = new THREE.Mesh(geometry, material);
			 * cubeA.position.set(100, 100, 0);
			 * const cubeB = new THREE.Mesh(geometry, material);
			 * cubeB.position.set(-100, -100, 0);
			 * //create a {@link Group} and add the two cubes
			 * //These cubes can now be rotated / scaled etc as a {@link Group}  * const {@link Group} = new THREE.Group();
			 * group.add(cubeA);
			 * group.add(cubeB);
			 * scene.add(group);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Group | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Group.js | Source}
			 
	**/
	function new():Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link Group}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isGroup(default, null) : Bool;
}
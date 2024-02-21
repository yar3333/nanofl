package js.three.helpers;

/**
 * A helper object to assist with visualizing a {@link Skeleton | Skeleton}
 * @remarks
 * The helper is rendered using a {@link LineBasicMaterial | LineBasicMaterial}.
 * @example
 * ```typescript
 * const helper = new THREE.SkeletonHelper(skinnedMesh);
 * scene.add(helper);
 * ```
 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_blending | WebGL / animation / skinning / blending}
 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_morph | WebGL / animation / skinning / morph}
 * @see Example: {@link https://threejs.org/examples/#webgl_loader_bvh | WebGL / loader / bvh }
 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/SkeletonHelper | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/SkeletonHelper.js | Source}
 */
/**
	
	 * A helper object to assist with visualizing a {@link Skeleton | Skeleton}
	 * @remarks
	 * The helper is rendered using a {@link LineBasicMaterial | LineBasicMaterial}.
	 * @example
	 * ```typescript
	 * const helper = new THREE.SkeletonHelper(skinnedMesh);
	 * scene.add(helper);
	 * ```
	 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_blending | WebGL / animation / skinning / blending}
	 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_morph | WebGL / animation / skinning / morph}
	 * @see Example: {@link https://threejs.org/examples/#webgl_loader_bvh | WebGL / loader / bvh }
	 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/SkeletonHelper | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/SkeletonHelper.js | Source}
	 
**/
@:native("THREE.SkeletonHelper") extern class SkeletonHelper extends js.three.objects.LineSegments<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap> {
	/**
		
			 * A helper object to assist with visualizing a {@link Skeleton | Skeleton}
			 * @remarks
			 * The helper is rendered using a {@link LineBasicMaterial | LineBasicMaterial}.
			 * @example
			 * ```typescript
			 * const helper = new THREE.SkeletonHelper(skinnedMesh);
			 * scene.add(helper);
			 * ```
			 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_blending | WebGL / animation / skinning / blending}
			 * @see Example: {@link https://threejs.org/examples/#webgl_animation_skinning_morph | WebGL / animation / skinning / morph}
			 * @see Example: {@link https://threejs.org/examples/#webgl_loader_bvh | WebGL / loader / bvh }
			 * @see {@link https://threejs.org/docs/index.html#api/en/helpers/SkeletonHelper | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/helpers/SkeletonHelper.js | Source}
			 
	**/
	function new(object:haxe.extern.EitherType<js.three.objects.SkinnedMesh<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material>, js.three.core.Object3D<js.three.core.Object3DEventMap>>):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link SkeletonHelper}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isSkeletonHelper(default, null) : Dynamic;
	/**
		
			 * The list of bones that the helper renders as {@link Line | Lines}.
			 
	**/
	var bones : Array<js.three.objects.Bone<js.three.core.Object3DEventMap>>;
	/**
		
			 * The object passed in the constructor.
			 
	**/
	var root : haxe.extern.EitherType<js.three.objects.SkinnedMesh<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material>, js.three.core.Object3D<js.three.core.Object3DEventMap>>;
	/**
		
			 * Updates the helper.
			 
	**/
	function update():Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance
			 * @remarks
			 * Call this method whenever this instance is no longer used in your app.
			 
	**/
	function dispose():Void;
}
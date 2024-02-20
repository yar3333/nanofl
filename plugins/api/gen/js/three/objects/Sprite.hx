package js.three.objects;

/**
 * A {@link Sprite} is a plane that always faces towards the camera, generally with a partially transparent texture applied.
 * @remarks Sprites do not cast shadows, setting `castShadow = true` will have no effect.
 * @example
 * ```typescript
 * const map = new THREE.TextureLoader().load('sprite.png');
 * const material = new THREE.SpriteMaterial({
 *     map: map
 * });
 * const {@link Sprite} = new THREE.Sprite(material);
 * scene.add(sprite);
 * ```
 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Sprite | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Sprite.js | Source}
 */
/**
	
	 * A {@link Sprite} is a plane that always faces towards the camera, generally with a partially transparent texture applied.
	 * @remarks Sprites do not cast shadows, setting `castShadow = true` will have no effect.
	 * @example
	 * ```typescript
	 * const map = new THREE.TextureLoader().load('sprite.png');
	 * const material = new THREE.SpriteMaterial({
	 *     map: map
	 * });
	 * const {@link Sprite} = new THREE.Sprite(material);
	 * scene.add(sprite);
	 * ```
	 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Sprite | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Sprite.js | Source}
	 
**/
@:native("THREE.Sprite") extern class Sprite<TEventMap:(js.three.core.Object3DEventMap)> extends js.three.core.Object3D<TEventMap> {
	/**
		
			 * A {@link Sprite} is a plane that always faces towards the camera, generally with a partially transparent texture applied.
			 * @remarks Sprites do not cast shadows, setting `castShadow = true` will have no effect.
			 * @example
			 * ```typescript
			 * const map = new THREE.TextureLoader().load('sprite.png');
			 * const material = new THREE.SpriteMaterial({
			 *     map: map
			 * });
			 * const {@link Sprite} = new THREE.Sprite(material);
			 * scene.add(sprite);
			 * ```
			 * @see {@link https://threejs.org/docs/index.html#api/en/objects/Sprite | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/objects/Sprite.js | Source}
			 
	**/
	function new(?material:js.three.materials.SpriteMaterial):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link Sprite}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isSprite(default, null) : Bool;
	/**
		
			 * @override
			 * @defaultValue `Sprite`
			 * Whether the object gets rendered into shadow map.
			 * No effect in {@link Sprite}.
			 * @ignore
			 * @hidden
			 * @defaultValue `false`
			 
	**/
	var geometry : haxe.extern.EitherType<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, Bool>;
	/**
		
			 * An instance of {@link THREE.SpriteMaterial | SpriteMaterial}, defining the object's appearance.
			 * @defaultValue {@link THREE.SpriteMaterial | `new SpriteMaterial()`}, _with white color_.
			 
	**/
	var material : js.three.materials.SpriteMaterial;
	/**
		
			 * The sprite's anchor point, and the point around which the {@link Sprite} rotates.
			 * A value of (0.5, 0.5) corresponds to the midpoint of the sprite.
			 * A value of (0, 0) corresponds to the lower left corner of the sprite.
			 * @defaultValue {@link THREE.Vector2 | `new Vector2(0.5, 0.5)`}.
			 
	**/
	var center : js.three.math.Vector2;
}
package js.three.core;

/**
 * This is the base class for most objects in three.js and provides a set of properties and methods for manipulating objects in 3D space.
 * @remarks Note that this can be used for grouping objects via the {@link THREE.Object3D.add | .add()} method which adds the object as a child,
 * however it is better to use {@link THREE.Group | Group} for this.
 * @see {@link https://threejs.org/docs/index.html#api/en/core/Object3D | Official Documentation}
 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/Object3D.js | Source}
 */
/**
	
	 * This is the base class for most objects in three.js and provides a set of properties and methods for manipulating objects in 3D space.
	 * @remarks Note that this can be used for grouping objects via the {@link THREE.Object3D.add | .add()} method which adds the object as a child,
	 * however it is better to use {@link THREE.Group | Group} for this.
	 * @see {@link https://threejs.org/docs/index.html#api/en/core/Object3D | Official Documentation}
	 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/Object3D.js | Source}
	 
**/
@:native("THREE.Object3D") extern class Object3D<TEventMap:(js.three.core.Object3DEventMap)> extends js.three.core.EventDispatcher<TEventMap> {
	/**
		
			 * This is the base class for most objects in three.js and provides a set of properties and methods for manipulating objects in 3D space.
			 * @remarks Note that this can be used for grouping objects via the {@link THREE.Object3D.add | .add()} method which adds the object as a child,
			 * however it is better to use {@link THREE.Group | Group} for this.
			 * @see {@link https://threejs.org/docs/index.html#api/en/core/Object3D | Official Documentation}
			 * @see {@link https://github.com/mrdoob/three.js/blob/master/src/core/Object3D.js | Source}
			 
	**/
	function new():Void;
	/**
		
			 * Flag to check if a given object is of type {@link Object3D}.
			 * @remarks This is a _constant_ value
			 * @defaultValue `true`
			 
	**/
	var isObject3D(default, null) : Bool;
	/**
		
			 * Unique number for this {@link Object3D} instance.
			 * @remarks Note that ids are assigned in chronological order: 1, 2, 3, ..., incrementing by one for each new object.
			 * Expects a `Integer`
			 
	**/
	var id(default, null) : Int;
	/**
		
			 * {@link http://en.wikipedia.org/wiki/Universally_unique_identifier | UUID} of this object instance.
			 * @remarks This gets automatically assigned and shouldn't be edited.
			 
	**/
	var uuid : String;
	/**
		
			 * Optional name of the object
			 * @remarks _(doesn't need to be unique)_.
			 * @defaultValue `""`
			 
	**/
	var name : String;
	/**
		
			 * A Read-only _string_ to check `this` object type.
			 * @remarks This can be used to find a specific type of Object3D in a scene.
			 * Sub-classes will update this value.
			 * @defaultValue `Object3D`
			 
	**/
	var type(default, null) : js.three.ObjectType;
	/**
		
			 * Object's parent in the {@link https://en.wikipedia.org/wiki/Scene_graph | scene graph}.
			 * @remarks An object can have at most one parent.
			 * @defaultValue `null`
			 
	**/
	var parent : js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Array with object's children.
			 * @see {@link THREE.Object3DGroup | Group} for info on manually grouping objects.
			 * @defaultValue `[]`
			 
	**/
	var children : Array<js.three.core.Object3D<js.three.core.Object3DEventMap>>;
	/**
		
			 * This is used by the {@link lookAt | lookAt} method, for example, to determine the orientation of the result.
			 * @defaultValue {@link DEFAULT_UP | Object3D.DEFAULT_UP} - that is `(0, 1, 0)`.
			 
	**/
	var up : js.three.math.Vector3;
	/**
		
			 * Object's local position.
			 * @defaultValue `new THREE.Vector3()` - that is `(0, 0, 0)`.
			 
	**/
	var position(default, null) : js.three.math.Vector3;
	/**
		
			 * Object's local rotation ({@link https://en.wikipedia.org/wiki/Euler_angles | Euler angles}), in radians.
			 * @defaultValue `new THREE.Euler()` - that is `(0, 0, 0, Euler.DEFAULT_ORDER)`.
			 
	**/
	var rotation(default, null) : js.three.math.Euler;
	/**
		
			 * Object's local rotation as a {@link THREE.Quaternion | Quaternion}.
			 * @defaultValue `new THREE.Quaternion()` - that is `(0,  0, 0, 1)`.
			 
	**/
	var quaternion(default, null) : js.three.math.Quaternion;
	/**
		
			 * The object's local scale.
			 * @defaultValue `new THREE.Vector3( 1, 1, 1 )`
			 
	**/
	var scale(default, null) : js.three.math.Vector3;
	/**
		
			 * @defaultValue `new THREE.Matrix4()`
			 
	**/
	var modelViewMatrix(default, null) : js.three.math.Matrix4;
	/**
		
			 * @defaultValue `new THREE.Matrix3()`
			 
	**/
	var normalMatrix(default, null) : js.three.math.Matrix3;
	/**
		
			 * The local transform matrix.
			 * @defaultValue `new THREE.Matrix4()`
			 
	**/
	var matrix : js.three.math.Matrix4;
	/**
		
			 * The global transform of the object.
			 * @remarks If the {@link Object3D} has no parent, then it's identical to the local transform {@link THREE.Object3D.matrix | .matrix}.
			 * @defaultValue `new THREE.Matrix4()`
			 
	**/
	var matrixWorld : js.three.math.Matrix4;
	/**
		
			 * When this is set, it calculates the matrix of position, (rotation or quaternion) and
			 * scale every frame and also recalculates the matrixWorld property.
			 * @defaultValue {@link DEFAULT_MATRIX_AUTO_UPDATE} - that is `(true)`.
			 
	**/
	var matrixAutoUpdate : Bool;
	/**
		
			 * If set, then the renderer checks every frame if the object and its children need matrix updates.
			 * When it isn't, then you have to maintain all matrices in the object and its children yourself.
			 * @defaultValue {@link DEFAULT_MATRIX_WORLD_AUTO_UPDATE} - that is `(true)`.
			 
	**/
	var matrixWorldAutoUpdate : Bool;
	/**
		
			 * When this is set, it calculates the matrixWorld in that frame and resets this property to false.
			 * @defaultValue `false`
			 
	**/
	var matrixWorldNeedsUpdate : Bool;
	/**
		
			 * The layer membership of the object.
			 * @remarks The object is only visible if it has at least one layer in common with the {@link THREE.Object3DCamera | Camera} in use.
			 * This property can also be used to filter out unwanted objects in ray-intersection tests when using {@link THREE.Raycaster | Raycaster}.
			 * @defaultValue `new THREE.Layers()`
			 
	**/
	var layers : js.three.core.Layers;
	/**
		
			 * Object gets rendered if `true`.
			 * @defaultValue `true`
			 
	**/
	var visible : Bool;
	/**
		
			 * Whether the object gets rendered into shadow map.
			 * @defaultValue `false`
			 
	**/
	var castShadow : Bool;
	/**
		
			 * Whether the material receives shadows.
			 * @defaultValue `false`
			 
	**/
	var receiveShadow : Bool;
	/**
		
			 * When this is set, it checks every frame if the object is in the frustum of the camera before rendering the object.
			 * If set to `false` the object gets rendered every frame even if it is not in the frustum of the camera.
			 * @defaultValue `true`
			 
	**/
	var frustumCulled : Bool;
	/**
		
			 * This value allows the default rendering order of {@link https://en.wikipedia.org/wiki/Scene_graph | scene graph}
			 * objects to be overridden although opaque and transparent objects remain sorted independently.
			 * @remarks When this property is set for an instance of {@link Group | Group}, all descendants objects will be sorted and rendered together.
			 * Sorting is from lowest to highest renderOrder.
			 * @defaultValue `0`
			 
	**/
	var renderOrder : Float;
	/**
		
			 * Array with object's animation clips.
			 * @defaultValue `[]`
			 
	**/
	var animations : Array<js.three.animation.AnimationClip>;
	/**
		
			 * An object that can be used to store custom data about the {@link Object3D}.
			 * @remarks It should not hold references to _functions_ as these **will not** be cloned.
			 * @default `{}`
			 
	**/
	var userData : Dynamic<Dynamic>;
	/**
		
			 * Custom depth material to be used when rendering to the depth map.
			 * @remarks Can only be used in context of meshes.
			 * When shadow-casting with a {@link THREE.DirectionalLight | DirectionalLight} or {@link THREE.SpotLight | SpotLight},
			 * if you are modifying vertex positions in the vertex shader you must specify a customDepthMaterial for proper shadows.
			 * @defaultValue `undefined`
			 
	**/
	@:optional
	var customDepthMaterial : haxe.extern.EitherType<js.three.materials.Material, { }>;
	/**
		
			 * Same as {@link customDepthMaterial}, but used with {@link THREE.Object3DPointLight | PointLight}.
			 * @defaultValue `undefined`
			 
	**/
	@:optional
	var customDistanceMaterial : haxe.extern.EitherType<js.three.materials.Material, { }>;
	/**
		
			 * An optional callback that is executed immediately before a 3D object is rendered to a shadow map.
			 * @remarks This function is called with the following parameters: renderer, scene, camera, shadowCamera, geometry,
			 * depthMaterial, group.
			 * Please notice that this callback is only executed for `renderable` 3D objects. Meaning 3D objects which
			 * define their visual appearance with geometries and materials like instances of {@link Mesh}, {@link Line},
			 * {@link Points} or {@link Sprite}. Instances of {@link Object3D}, {@link Group} or {@link Bone} are not renderable
			 * and thus this callback is not executed for such objects.
			 
	**/
	function onBeforeShadow(renderer:js.three.renderers.WebGLRenderer, scene:js.three.scenes.Scene, shadowCamera:js.three.cameras.Camera, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, depthMaterial:js.three.materials.Material, group:js.three.objects.Group<js.three.core.Object3DEventMap>):Void;
	/**
		
			 * An optional callback that is executed immediately after a 3D object is rendered to a shadow map.
			 * @remarks This function is called with the following parameters: renderer, scene, camera, shadowCamera, geometry,
			 * depthMaterial, group.
			 * Please notice that this callback is only executed for `renderable` 3D objects. Meaning 3D objects which
			 * define their visual appearance with geometries and materials like instances of {@link Mesh}, {@link Line},
			 * {@link Points} or {@link Sprite}. Instances of {@link Object3D}, {@link Group} or {@link Bone} are not renderable
			 * and thus this callback is not executed for such objects.
			 
	**/
	function onAfterShadow(renderer:js.three.renderers.WebGLRenderer, scene:js.three.scenes.Scene, shadowCamera:js.three.cameras.Camera, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, depthMaterial:js.three.materials.Material, group:js.three.objects.Group<js.three.core.Object3DEventMap>):Void;
	/**
		
			 * An optional callback that is executed immediately before a 3D object is rendered.
			 * @remarks This function is called with the following parameters: renderer, scene, camera, geometry, material, group.
			 * Please notice that this callback is only executed for `renderable` 3D objects. Meaning 3D objects which
			 * define their visual appearance with geometries and materials like instances of {@link Mesh}, {@link Line},
			 * {@link Points} or {@link Sprite}. Instances of {@link Object3D}, {@link Group} or {@link Bone} are not renderable
			 * and thus this callback is not executed for such objects.
			 
	**/
	function onBeforeRender(renderer:js.three.renderers.WebGLRenderer, scene:js.three.scenes.Scene, camera:js.three.cameras.Camera, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, material:js.three.materials.Material, group:js.three.objects.Group<js.three.core.Object3DEventMap>):Void;
	/**
		
			 * An optional callback that is executed immediately after a 3D object is rendered.
			 * @remarks This function is called with the following parameters: renderer, scene, camera, geometry, material, group.
			 * Please notice that this callback is only executed for `renderable` 3D objects. Meaning 3D objects which
			 * define their visual appearance with geometries and materials like instances of {@link Mesh}, {@link Line},
			 * {@link Points} or {@link Sprite}. Instances of {@link Object3D}, {@link Group} or {@link Bone} are not renderable
			 * and thus this callback is not executed for such objects.
			 
	**/
	function onAfterRender(renderer:js.three.renderers.WebGLRenderer, scene:js.three.scenes.Scene, camera:js.three.cameras.Camera, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, material:js.three.materials.Material, group:js.three.objects.Group<js.three.core.Object3DEventMap>):Void;
	/**
		
			 * Applies the matrix transform to the object and updates the object's position, rotation and scale.
			 
	**/
	function applyMatrix4(matrix:js.three.math.Matrix4):Void;
	/**
		
			 * Applies the rotation represented by the quaternion to the object.
			 
	**/
	function applyQuaternion(quaternion:js.three.math.Quaternion):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Calls {@link THREE.Quaternion.setFromAxisAngle | setFromAxisAngle}({@link axis}, {@link angle}) on the {@link quaternion | .quaternion}.
			 
	**/
	function setRotationFromAxisAngle(axis:js.three.math.Vector3, angle:Float):Void;
	/**
		
			 * Calls {@link THREE.Quaternion.setFromEuler | setFromEuler}({@link euler}) on the {@link quaternion | .quaternion}.
			 
	**/
	function setRotationFromEuler(euler:js.three.math.Euler):Void;
	/**
		
			 * Calls {@link THREE.Quaternion.setFromRotationMatrix | setFromRotationMatrix}({@link m}) on the {@link quaternion | .quaternion}.
			 * @remarks Note that this assumes that the upper 3x3 of m is a pure rotation matrix (i.e, unscaled).
			 
	**/
	function setRotationFromMatrix(m:js.three.math.Matrix4):Void;
	/**
		
			 * Copy the given {@link THREE.Quaternion | Quaternion} into {@link quaternion | .quaternion}.
			 
	**/
	function setRotationFromQuaternion(q:js.three.math.Quaternion):Void;
	/**
		
			 * Rotate an object along an axis in object space.
			 * @remarks The axis is assumed to be normalized.
			 
	**/
	function rotateOnAxis(axis:js.three.math.Vector3, angle:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Rotate an object along an axis in world space.
			 * @remarks The axis is assumed to be normalized
			 * Method Assumes no rotated parent.
			 
	**/
	function rotateOnWorldAxis(axis:js.three.math.Vector3, angle:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Rotates the object around _x_ axis in local space.
			 
	**/
	function rotateX(angle:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Rotates the object around _y_ axis in local space.
			 
	**/
	function rotateY(angle:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Rotates the object around _z_ axis in local space.
			 
	**/
	function rotateZ(angle:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Translate an object by distance along an axis in object space
			 * @remarks The axis is assumed to be normalized.
			 
	**/
	function translateOnAxis(axis:js.three.math.Vector3, distance:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Translates object along x axis in object space by {@link distance} units.
			 
	**/
	function translateX(distance:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Translates object along _y_ axis in object space by {@link distance} units.
			 
	**/
	function translateY(distance:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Translates object along _z_ axis in object space by {@link distance} units.
			 
	**/
	function translateZ(distance:Float):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Converts the vector from this object's local space to world space.
			 
	**/
	function localToWorld(vector:js.three.math.Vector3):js.three.math.Vector3;
	/**
		
			 * Converts the vector from world space to this object's local space.
			 
	**/
	function worldToLocal(vector:js.three.math.Vector3):js.three.math.Vector3;
	/**
		
			 * Rotates the object to face a point in world space.
			 * @remarks This method does not support objects having non-uniformly-scaled parent(s).
			 * Rotates the object to face a point in world space.
			 * @remarks This method does not support objects having non-uniformly-scaled parent(s).
			 
	**/
	@:overload(function(x:Float, y:Float, z:Float):Void { })
	function lookAt(vector:js.three.math.Vector3):Void;
	/**
		
			 * Adds another {@link Object3D} as child of this {@link Object3D}.
			 * @remarks An arbitrary number of objects may be added
			 * Any current parent on an {@link object} passed in here will be removed, since an {@link Object3D} can have at most one parent.
			 * @see {@link attach}
			 * @see {@link THREE.Group | Group} for info on manually grouping objects.
			 
	**/
	function add(object:js.three.core.Object3D<js.three.core.Object3DEventMap>):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Removes a {@link Object3D} as child of this {@link Object3D}.
			 * @remarks An arbitrary number of objects may be removed.
			 * @see {@link THREE.Group | Group} for info on manually grouping objects.
			 
	**/
	function remove(object:js.three.core.Object3D<js.three.core.Object3DEventMap>):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Removes this object from its current parent.
			 
	**/
	function removeFromParent():js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Removes all child objects.
			 
	**/
	function clear():js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Adds a {@link Object3D} as a child of this, while maintaining the object's world transform.
			 * @remarks Note: This method does not support scene graphs having non-uniformly-scaled nodes(s).
			 * @see {@link add}
			 
	**/
	function attach(object:js.three.core.Object3D<js.three.core.Object3DEventMap>):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Searches through an object and its children, starting with the object itself, and returns the first with a matching id.
			 * @remarks Note that ids are assigned in chronological order: 1, 2, 3, ..., incrementing by one for each new object.
			 * @see {@link id}
			 
	**/
	function getObjectById(id:Int):haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, { }>;
	/**
		
			 * Searches through an object and its children, starting with the object itself, and returns the first with a matching name.
			 * @remarks Note that for most objects the name is an empty string by default
			 * You will have to set it manually to make use of this method.
			 
	**/
	function getObjectByName(name:String):haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, { }>;
	/**
		
			 * Searches through an object and its children, starting with the object itself,
			 * and returns the first with a property that matches the value given.
			 
	**/
	function getObjectByProperty(name:String, value:Dynamic):haxe.extern.EitherType<js.three.core.Object3D<js.three.core.Object3DEventMap>, { }>;
	/**
		
			 * Searches through an object and its children, starting with the object itself,
			 * and returns the first with a property that matches the value given.
			 
	**/
	function getObjectsByProperty(name:String, value:Dynamic, ?optionalTarget:Array<js.three.core.Object3D<js.three.core.Object3DEventMap>>):Array<js.three.core.Object3D<js.three.core.Object3DEventMap>>;
	/**
		
			 * Returns a vector representing the position of the object in world space.
			 
	**/
	function getWorldPosition(target:js.three.math.Vector3):js.three.math.Vector3;
	/**
		
			 * Returns a quaternion representing the rotation of the object in world space.
			 
	**/
	function getWorldQuaternion(target:js.three.math.Quaternion):js.three.math.Quaternion;
	/**
		
			 * Returns a vector of the scaling factors applied to the object for each axis in world space.
			 
	**/
	function getWorldScale(target:js.three.math.Vector3):js.three.math.Vector3;
	/**
		
			 * Returns a vector representing the direction of object's positive z-axis in world space.
			 
	**/
	function getWorldDirection(target:js.three.math.Vector3):js.three.math.Vector3;
	/**
		
			 * Abstract (empty) method to get intersections between a casted ray and this object
			 * @remarks Subclasses such as {@link THREE.Mesh | Mesh}, {@link THREE.Line | Line}, and {@link THREE.Points | Points} implement this method in order to use raycasting.
			 * @see {@link THREE.Raycaster | Raycaster}
			 * @defaultValue `() => {}`
			 
	**/
	function raycast(raycaster:js.three.core.Raycaster, intersects:Array<js.three.core.Intersection<js.three.core.Object3D<js.three.core.Object3DEventMap>>>):Void;
	/**
		
			 * Executes the callback on this object and all descendants.
			 * @remarks Note: Modifying the scene graph inside the callback is discouraged.
			 * @link Object3D} object.
			 
	**/
	function traverse(callback:js.three.core.Object3D<js.three.core.Object3DEventMap> -> Void):Void;
	/**
		
			 * Like traverse, but the callback will only be executed for visible objects
			 * @remarks Descendants of invisible objects are not traversed.
			 * Note: Modifying the scene graph inside the callback is discouraged.
			 * @link Object3D} object.
			 
	**/
	function traverseVisible(callback:js.three.core.Object3D<js.three.core.Object3DEventMap> -> Void):Void;
	/**
		
			 * Executes the callback on all ancestors.
			 * @remarks Note: Modifying the scene graph inside the callback is discouraged.
			 * @link Object3D} object.
			 
	**/
	function traverseAncestors(callback:js.three.core.Object3D<js.three.core.Object3DEventMap> -> Void):Void;
	/**
		
			 * Updates local transform.
			 
	**/
	function updateMatrix():Void;
	/**
		
			 * Updates the global transform of the object.
			 * And will update the object descendants if {@link matrixWorldNeedsUpdate | .matrixWorldNeedsUpdate} is set to true or if the {@link force} parameter is set to `true`.
			 * @link matrixWorldAutoUpdate | .matrixWorldAutoUpdate}, to recalculate the world matrix of the object and descendants on the current frame.
			 * Useful if you cannot wait for the renderer to update it on the next frame, assuming {@link matrixWorldAutoUpdate | .matrixWorldAutoUpdate} set to `true`.
			 
	**/
	function updateMatrixWorld(?force:Bool):Void;
	/**
		
			 * Updates the global transform of the object.
			 
	**/
	function updateWorldMatrix(updateParents:Bool, updateChildren:Bool):Void;
	/**
		
			 * Convert the object to three.js {@link https://github.com/mrdoob/three.js/wiki/JSON-Object-Scene-format-4 | JSON Object/Scene format}.
			 
	**/
	function toJSON(?meta:{ public var textures(default, default) : Dynamic; public var materials(default, default) : Dynamic; public var images(default, default) : Dynamic; public var geometries(default, default) : Dynamic; }):Dynamic;
	/**
		
			 * Returns a clone of `this` object and optionally all descendants.
			 
	**/
	function clone(?recursive:Bool):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * Copy the given object into this object
			 * @remarks Note: event listeners and user-defined callbacks ({@link onAfterRender | .onAfterRender} and {@link onBeforeRender | .onBeforeRender}) are not copied.
			 
	**/
	function copy(source:js.three.core.Object3D<js.three.core.Object3DEventMap>, ?recursive:Bool):js.three.core.Object3D<js.three.core.Object3DEventMap>;
	/**
		
			 * The default {@link up} direction for objects, also used as the default position for {@link THREE.DirectionalLight | DirectionalLight},
			 * {@link THREE.HemisphereLight | HemisphereLight} and {@link THREE.Spotlight | Spotlight} (which creates lights shining from the top down).
			 * @defaultValue `new THREE.Vector3( 0, 1, 0)`
			 
	**/
	static var DEFAULT_UP : js.three.math.Vector3;
	/**
		
			 * The default setting for {@link matrixAutoUpdate} for newly created Object3Ds.
			 * @defaultValue `true`
			 
	**/
	static var DEFAULT_MATRIX_AUTO_UPDATE : Bool;
	/**
		
			 * The default setting for {@link matrixWorldAutoUpdate} for newly created Object3Ds.
			 * @defaultValue `true`
			 
	**/
	static var DEFAULT_MATRIX_WORLD_AUTO_UPDATE : Bool;
}
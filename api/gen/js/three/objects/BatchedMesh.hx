package js.three.objects;

/**
 * A special version of {@link Mesh} with multi draw batch rendering support. Use {@link BatchedMesh} if you have to
 * render a large number of objects with the same material but with different world transformations and geometry. The
 * usage of {@link BatchedMesh} will help you to reduce the number of draw calls and thus improve the overall rendering
 * performance in your application.
 *
 * If the {@link https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_multi_draw WEBGL_multi_draw extension} is not
 * supported then a less performant callback is used.
 *
 * @example
 * const box = new THREE.BoxGeometry( 1, 1, 1 );
 * const sphere = new THREE.BoxGeometry( 1, 1, 1 );
 * const material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
 *
 * // initialize and add geometries into the batched mesh
 * const batchedMesh = new BatchedMesh( 10, 5000, 10000, material );
 * const boxId = batchedMesh.addGeometry( box );
 * const sphereId = batchedMesh.addGeometry( sphere );
 *
 * // position the geometries
 * batchedMesh.setMatrixAt( boxId, boxMatrix );
 * batchedMesh.setMatrixAt( sphereId, sphereMatrix );
 *
 * scene.add( batchedMesh );
 *
 * @also Example: {@link https://threejs.org/examples/#webgl_mesh_batch WebGL / mesh / batch}
 */
/**
	
	 * A special version of {@link Mesh} with multi draw batch rendering support. Use {@link BatchedMesh} if you have to
	 * render a large number of objects with the same material but with different world transformations and geometry. The
	 * usage of {@link BatchedMesh} will help you to reduce the number of draw calls and thus improve the overall rendering
	 * performance in your application.
	 * 
	 * If the {@link https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_multi_draw WEBGL_multi_draw extension} is not
	 * supported then a less performant callback is used.
	 * 
	 * @example
	 * const box = new THREE.BoxGeometry( 1, 1, 1 );
	 * const sphere = new THREE.BoxGeometry( 1, 1, 1 );
	 * const material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
	 * 
	 * // initialize and add geometries into the batched mesh
	 * const batchedMesh = new BatchedMesh( 10, 5000, 10000, material );
	 * const boxId = batchedMesh.addGeometry( box );
	 * const sphereId = batchedMesh.addGeometry( sphere );
	 * 
	 * // position the geometries
	 * batchedMesh.setMatrixAt( boxId, boxMatrix );
	 * batchedMesh.setMatrixAt( sphereId, sphereMatrix );
	 * 
	 * scene.add( batchedMesh );
	 * 
	 * @also Example: {@link https://threejs.org/examples/#webgl_mesh_batch WebGL / mesh / batch}
	 
**/
@:native("THREE.BatchedMesh") extern class BatchedMesh extends js.three.objects.Mesh<js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, js.three.materials.Material, js.three.core.Object3DEventMap> {
	/**
		
			 * A special version of {@link Mesh} with multi draw batch rendering support. Use {@link BatchedMesh} if you have to
			 * render a large number of objects with the same material but with different world transformations and geometry. The
			 * usage of {@link BatchedMesh} will help you to reduce the number of draw calls and thus improve the overall rendering
			 * performance in your application.
			 * 
			 * If the {@link https://developer.mozilla.org/en-US/docs/Web/API/WEBGL_multi_draw WEBGL_multi_draw extension} is not
			 * supported then a less performant callback is used.
			 * 
			 * @example
			 * const box = new THREE.BoxGeometry( 1, 1, 1 );
			 * const sphere = new THREE.BoxGeometry( 1, 1, 1 );
			 * const material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
			 * 
			 * // initialize and add geometries into the batched mesh
			 * const batchedMesh = new BatchedMesh( 10, 5000, 10000, material );
			 * const boxId = batchedMesh.addGeometry( box );
			 * const sphereId = batchedMesh.addGeometry( sphere );
			 * 
			 * // position the geometries
			 * batchedMesh.setMatrixAt( boxId, boxMatrix );
			 * batchedMesh.setMatrixAt( sphereId, sphereMatrix );
			 * 
			 * scene.add( batchedMesh );
			 * 
			 * @also Example: {@link https://threejs.org/examples/#webgl_mesh_batch WebGL / mesh / batch}
			 
	**/
	function new(maxGeometryCount:Float, maxVertexCount:Float, ?maxIndexCount:Float, ?material:js.three.materials.Material):Void;
	/**
		
			 * This bounding box encloses all instances of the {@link BatchedMesh}. Can be calculated with
			 * {@link .computeBoundingBox()}.
			 * @default null
			 
	**/
	var boundingBox : js.three.math.Box3;
	/**
		
			 * This bounding sphere encloses all instances of the {@link BatchedMesh}. Can be calculated with
			 * {@link .computeBoundingSphere()}.
			 * @default null
			 
	**/
	var boundingSphere : js.three.math.Sphere;
	var customSort : (js.three.objects.BatchedMesh, Array<{ public var z(default, default) : Float; public var start(default, default) : Float; public var count(default, default) : Float; }>, js.three.cameras.Camera) -> Void;
	/**
		
			 * If true then the individual objects within the {@link BatchedMesh} are frustum culled.
			 * @default true
			 
	**/
	var perObjectFrustumCulled : Bool;
	/**
		
			 * If true then the individual objects within the {@link BatchedMesh} are sorted to improve overdraw-related
			 * artifacts. If the material is marked as "transparent" objects are rendered back to front and if not then they are
			 * rendered front to back.
			 * @default true
			 
	**/
	var sortObjects : Bool;
	/**
		
			 * Read-only flag to check if a given object is of type {@link BatchedMesh}.
			 
	**/
	var isBatchedMesh : Bool;
	/**
		
			 * Computes the bounding box, updating {@link .boundingBox} attribute.
			 * Bounding boxes aren't computed by default. They need to be explicitly computed, otherwise they are `null`.
			 
	**/
	function computeBoundingBox():Void;
	/**
		
			 * Computes the bounding sphere, updating {@link .boundingSphere} attribute.
			 * Bounding spheres aren't computed by default. They need to be explicitly computed, otherwise they are `null`.
			 
	**/
	function computeBoundingSphere():Void;
	/**
		
			 * Frees the GPU-related resources allocated by this instance. Call this method whenever this instance is no longer
			 * used in your app.
			 
	**/
	function dispose():js.three.objects.BatchedMesh;
	/**
		
			 * Takes a sort a function that is run before render. The function takes a list of items to sort and a camera. The
			 * objects in the list include a "z" field to perform a depth-ordered sort with.
			 
	**/
	function setCustomSort(func:(js.three.objects.BatchedMesh, Array<{ public var z(default, default) : Float; public var start(default, default) : Float; public var count(default, default) : Float; }>, js.three.cameras.Camera) -> Void):js.three.objects.BatchedMesh;
	/**
		
			 * Get the local transformation matrix of the defined instance.
			 
	**/
	function getMatrixAt(index:Int, matrix:js.three.math.Matrix4):js.three.math.Matrix4;
	/**
		
			 * Get whether the given instance is marked as "visible" or not.
			 
	**/
	function getVisibleAt(index:Int):Bool;
	/**
		
			 * Sets the given local transformation matrix to the defined instance. Make sure you set {@link .instanceMatrix}
			 * {@link BufferAttribute.needsUpdate} to true after updating all the matrices.
			 
	**/
	function setMatrixAt(index:Int, matrix:js.three.math.Matrix4):js.three.objects.BatchedMesh;
	/**
		
			 * Sets the visibility of the object at the given index.
			 
	**/
	function setVisibleAt(index:Int, visible:Bool):js.three.objects.BatchedMesh;
	/**
		
			 * Adds the given geometry to the {@link BatchedMesh} and returns the associated index referring to it.
			 * @link BatchedMesh}.
			 
	**/
	function addGeometry(geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>, ?reservedVertexRange:Float, ?reservedIndexRange:Float):Float;
	/**
		
			 * Replaces the geometry at `index` with the provided geometry. Throws an error if there is not enough space
			 * reserved for geometry at the index.
			 
	**/
	function setGeometryAt(index:Int, geometry:js.three.core.BufferGeometry<js.three.core.BufferGeometry.NormalBufferAttributes>):Float;
	/**
		
			 * Marks the geometry at the given index as deleted and to not be rendered anymore.
			 
	**/
	function deleteGeometry(index:Int):js.three.objects.BatchedMesh;
	function getBoundingBoxAt(index:Int, target:js.three.math.Box3):js.three.math.Box3;
	function getBoundingSphereAt(index:Int, target:js.three.math.Sphere):js.three.math.Sphere;
}
package js.three.core;

extern interface Intersection<TIntersected:(js.three.core.Object3D<js.three.core.Object3DEventMap>)> {
	/**
		
			 * Distance between the origin of the ray and the intersection 
			 
	**/
	var distance : Float;
	@:optional
	var distanceToRay : haxe.extern.EitherType<Float, { }>;
	/**
		
			 * Point of intersection, in world coordinates 
			 
	**/
	var point : js.three.math.Vector3;
	@:optional
	var index : haxe.extern.EitherType<Float, { }>;
	/**
		
			 * Intersected face 
			 
	**/
	@:optional
	var face : haxe.extern.EitherType<js.three.core.Face, { }>;
	/**
		
			 * Index of the intersected face 
			 
	**/
	@:optional
	var faceIndex : haxe.extern.EitherType<Float, { }>;
	/**
		
			 * The intersected object 
			 
	**/
	var object : TIntersected;
	@:optional
	var uv : haxe.extern.EitherType<js.three.math.Vector2, { }>;
	@:optional
	var uv1 : haxe.extern.EitherType<js.three.math.Vector2, { }>;
	@:optional
	var normal : js.three.math.Vector3;
	/**
		
			 * The index number of the instance where the ray intersects the {@link THREE.InstancedMesh | InstancedMesh } 
			 
	**/
	@:optional
	var instanceId : haxe.extern.EitherType<Float, { }>;
	@:optional
	var pointOnLine : js.three.math.Vector3;
	@:optional
	var batchId : Float;
}
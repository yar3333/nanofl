package js.three.math;

/**
 * Frustums are used to determine what is inside the camera's field of view. They help speed up the rendering process.
 */
/**
	
	 * Frustums are used to determine what is inside the camera's field of view. They help speed up the rendering process.
	 
**/
@:native("THREE.Frustum") extern class Frustum {
	/**
		
			 * Frustums are used to determine what is inside the camera's field of view. They help speed up the rendering process.
			 
	**/
	function new(?p0:js.three.math.Plane, ?p1:js.three.math.Plane, ?p2:js.three.math.Plane, ?p3:js.three.math.Plane, ?p4:js.three.math.Plane, ?p5:js.three.math.Plane):Void;
	/**
		
			 * Array of 6 vectors.
			 
	**/
	var planes : Array<js.three.math.Plane>;
	function set(p0:js.three.math.Plane, p1:js.three.math.Plane, p2:js.three.math.Plane, p3:js.three.math.Plane, p4:js.three.math.Plane, p5:js.three.math.Plane):js.three.math.Frustum;
	function clone():js.three.math.Frustum;
	function copy(frustum:js.three.math.Frustum):js.three.math.Frustum;
	function setFromProjectionMatrix(m:js.three.math.Matrix4, ?coordinateSystem:js.three.CoordinateSystem):js.three.math.Frustum;
	function intersectsObject(object:js.three.core.Object3D<js.three.core.Object3DEventMap>):Bool;
	function intersectsSprite(sprite:js.three.objects.Sprite<js.three.core.Object3DEventMap>):Bool;
	function intersectsSphere(sphere:js.three.math.Sphere):Bool;
	function intersectsBox(box:js.three.math.Box3):Bool;
	function containsPoint(point:js.three.math.Vector3):Bool;
}
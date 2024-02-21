package js.three.math;

@:native("THREE.Ray") extern class Ray {
	function new(?origin:js.three.math.Vector3, ?direction:js.three.math.Vector3):Void;
	/**
		
			 * @default new THREE.Vector3()
			 
	**/
	var origin : js.three.math.Vector3;
	/**
		
			 * @default new THREE.Vector3( 0, 0, - 1 )
			 
	**/
	var direction : js.three.math.Vector3;
	function set(origin:js.three.math.Vector3, direction:js.three.math.Vector3):js.three.math.Ray;
	function clone():js.three.math.Ray;
	function copy(ray:js.three.math.Ray):js.three.math.Ray;
	function at(t:Float, target:js.three.math.Vector3):js.three.math.Vector3;
	function lookAt(v:js.three.math.Vector3):js.three.math.Ray;
	function recast(t:Float):js.three.math.Ray;
	function closestPointToPoint(point:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	function distanceToPoint(point:js.three.math.Vector3):Float;
	function distanceSqToPoint(point:js.three.math.Vector3):Float;
	function distanceSqToSegment(v0:js.three.math.Vector3, v1:js.three.math.Vector3, ?optionalPointOnRay:js.three.math.Vector3, ?optionalPointOnSegment:js.three.math.Vector3):Float;
	function intersectSphere(sphere:js.three.math.Sphere, target:js.three.math.Vector3):js.three.math.Vector3;
	function intersectsSphere(sphere:js.three.math.Sphere):Bool;
	function distanceToPlane(plane:js.three.math.Plane):Float;
	function intersectPlane(plane:js.three.math.Plane, target:js.three.math.Vector3):js.three.math.Vector3;
	function intersectsPlane(plane:js.three.math.Plane):Bool;
	function intersectBox(box:js.three.math.Box3, target:js.three.math.Vector3):js.three.math.Vector3;
	function intersectsBox(box:js.three.math.Box3):Bool;
	function intersectTriangle(a:js.three.math.Vector3, b:js.three.math.Vector3, c:js.three.math.Vector3, backfaceCulling:Bool, target:js.three.math.Vector3):js.three.math.Vector3;
	function applyMatrix4(matrix4:js.three.math.Matrix4):js.three.math.Ray;
	function equals(ray:js.three.math.Ray):Bool;
	/**
		
			 * @deprecated Use {@link Ray#intersectsBox .intersectsBox()} instead.
			 
	**/
	function isIntersectionBox(b:Dynamic):Dynamic;
	/**
		
			 * @deprecated Use {@link Ray#intersectsPlane .intersectsPlane()} instead.
			 
	**/
	function isIntersectionPlane(p:Dynamic):Dynamic;
	/**
		
			 * @deprecated Use {@link Ray#intersectsSphere .intersectsSphere()} instead.
			 
	**/
	function isIntersectionSphere(s:Dynamic):Dynamic;
}
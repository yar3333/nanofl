package js.three.math;

@:native("THREE.Sphere") extern class Sphere {
	function new(?center:js.three.math.Vector3, ?radius:Float):Void;
	/**
		
			 * Read-only flag to check if a given object is of type {@link Sphere}.
			 
	**/
	var isSphere(default, null) : Bool;
	/**
		
			 * @default new Vector3()
			 
	**/
	var center : js.three.math.Vector3;
	/**
		
			 * @default 1
			 
	**/
	var radius : Float;
	function set(center:js.three.math.Vector3, radius:Float):js.three.math.Sphere;
	function setFromPoints(points:Array<js.three.math.Vector3>, ?optionalCenter:js.three.math.Vector3):js.three.math.Sphere;
	function clone():js.three.math.Sphere;
	function copy(sphere:js.three.math.Sphere):js.three.math.Sphere;
	function expandByPoint(point:js.three.math.Vector3):js.three.math.Sphere;
	function isEmpty():Bool;
	function makeEmpty():js.three.math.Sphere;
	function containsPoint(point:js.three.math.Vector3):Bool;
	function distanceToPoint(point:js.three.math.Vector3):Float;
	function intersectsSphere(sphere:js.three.math.Sphere):Bool;
	function intersectsBox(box:js.three.math.Box3):Bool;
	function intersectsPlane(plane:js.three.math.Plane):Bool;
	function clampPoint(point:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	function getBoundingBox(target:js.three.math.Box3):js.three.math.Box3;
	function applyMatrix4(matrix:js.three.math.Matrix4):js.three.math.Sphere;
	function translate(offset:js.three.math.Vector3):js.three.math.Sphere;
	function equals(sphere:js.three.math.Sphere):Bool;
	function union(sphere:js.three.math.Sphere):js.three.math.Sphere;
	/**
		
			 * @deprecated Use {@link Sphere#isEmpty .isEmpty()} instead.
			 
	**/
	function empty():Dynamic;
}
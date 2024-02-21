package js.three.math;

@:native("THREE.Box3") extern class Box3 {
	function new(?min:js.three.math.Vector3, ?max:js.three.math.Vector3):Void;
	/**
		
			 * @default new THREE.Vector3( + Infinity, + Infinity, + Infinity )
			 
	**/
	var min : js.three.math.Vector3;
	/**
		
			 * @default new THREE.Vector3( - Infinity, - Infinity, - Infinity )
			 
	**/
	var max : js.three.math.Vector3;
	var isBox3(default, null) : Bool;
	function set(min:js.three.math.Vector3, max:js.three.math.Vector3):js.three.math.Box3;
	function setFromArray(array:js.three.ArrayLike<Float>):js.three.math.Box3;
	function setFromBufferAttribute(bufferAttribute:js.three.core.BufferAttribute):js.three.math.Box3;
	function setFromPoints(points:Array<js.three.math.Vector3>):js.three.math.Box3;
	function setFromCenterAndSize(center:js.three.math.Vector3, size:js.three.math.Vector3):js.three.math.Box3;
	function setFromObject(object:js.three.core.Object3D<js.three.core.Object3DEventMap>, ?precise:Bool):js.three.math.Box3;
	function clone():js.three.math.Box3;
	function copy(box:js.three.math.Box3):js.three.math.Box3;
	function makeEmpty():js.three.math.Box3;
	function isEmpty():Bool;
	function getCenter(target:js.three.math.Vector3):js.three.math.Vector3;
	function getSize(target:js.three.math.Vector3):js.three.math.Vector3;
	function expandByPoint(point:js.three.math.Vector3):js.three.math.Box3;
	function expandByVector(vector:js.three.math.Vector3):js.three.math.Box3;
	function expandByScalar(scalar:Float):js.three.math.Box3;
	function expandByObject(object:js.three.core.Object3D<js.three.core.Object3DEventMap>, ?precise:Bool):js.three.math.Box3;
	function containsPoint(point:js.three.math.Vector3):Bool;
	function containsBox(box:js.three.math.Box3):Bool;
	function getParameter(point:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	function intersectsBox(box:js.three.math.Box3):Bool;
	function intersectsSphere(sphere:js.three.math.Sphere):Bool;
	function intersectsPlane(plane:js.three.math.Plane):Bool;
	function intersectsTriangle(triangle:js.three.math.Triangle):Bool;
	function clampPoint(point:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	function distanceToPoint(point:js.three.math.Vector3):Float;
	function getBoundingSphere(target:js.three.math.Sphere):js.three.math.Sphere;
	function intersect(box:js.three.math.Box3):js.three.math.Box3;
	function union(box:js.three.math.Box3):js.three.math.Box3;
	function applyMatrix4(matrix:js.three.math.Matrix4):js.three.math.Box3;
	function translate(offset:js.three.math.Vector3):js.three.math.Box3;
	function equals(box:js.three.math.Box3):Bool;
	/**
		
			 * @deprecated Use {@link Box3#isEmpty .isEmpty()} instead.
			 
	**/
	function empty():Dynamic;
	/**
		
			 * @deprecated Use {@link Box3#intersectsBox .intersectsBox()} instead.
			 
	**/
	function isIntersectionBox(b:Dynamic):Dynamic;
	/**
		
			 * @deprecated Use {@link Box3#intersectsSphere .intersectsSphere()} instead.
			 
	**/
	function isIntersectionSphere(s:Dynamic):Dynamic;
}
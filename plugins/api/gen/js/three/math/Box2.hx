package js.three.math;

@:native("THREE.Box2") extern class Box2 {
	function new(?min:js.three.math.Vector2, ?max:js.three.math.Vector2):Void;
	/**
		
			 * @default new THREE.Vector2( + Infinity, + Infinity )
			 
	**/
	var min : js.three.math.Vector2;
	/**
		
			 * @default new THREE.Vector2( - Infinity, - Infinity )
			 
	**/
	var max : js.three.math.Vector2;
	function set(min:js.three.math.Vector2, max:js.three.math.Vector2):js.three.math.Box2;
	function setFromPoints(points:Array<js.three.math.Vector2>):js.three.math.Box2;
	function setFromCenterAndSize(center:js.three.math.Vector2, size:js.three.math.Vector2):js.three.math.Box2;
	function clone():js.three.math.Box2;
	function copy(box:js.three.math.Box2):js.three.math.Box2;
	function makeEmpty():js.three.math.Box2;
	function isEmpty():Bool;
	function getCenter(target:js.three.math.Vector2):js.three.math.Vector2;
	function getSize(target:js.three.math.Vector2):js.three.math.Vector2;
	function expandByPoint(point:js.three.math.Vector2):js.three.math.Box2;
	function expandByVector(vector:js.three.math.Vector2):js.three.math.Box2;
	function expandByScalar(scalar:Float):js.three.math.Box2;
	function containsPoint(point:js.three.math.Vector2):Bool;
	function containsBox(box:js.three.math.Box2):Bool;
	function getParameter(point:js.three.math.Vector2, target:js.three.math.Vector2):js.three.math.Vector2;
	function intersectsBox(box:js.three.math.Box2):Bool;
	function clampPoint(point:js.three.math.Vector2, target:js.three.math.Vector2):js.three.math.Vector2;
	function distanceToPoint(point:js.three.math.Vector2):Float;
	function intersect(box:js.three.math.Box2):js.three.math.Box2;
	function union(box:js.three.math.Box2):js.three.math.Box2;
	function translate(offset:js.three.math.Vector2):js.three.math.Box2;
	function equals(box:js.three.math.Box2):Bool;
	/**
		
			 * @deprecated Use {@link Box2#isEmpty .isEmpty()} instead.
			 
	**/
	function empty():Dynamic;
	/**
		
			 * @deprecated Use {@link Box2#intersectsBox .intersectsBox()} instead.
			 
	**/
	function isIntersectionBox(b:Dynamic):Dynamic;
}
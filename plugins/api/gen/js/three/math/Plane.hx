package js.three.math;

@:native("THREE.Plane") extern class Plane {
	function new(?normal:js.three.math.Vector3, ?constant:Float):Void;
	/**
		
			 * @default new THREE.Vector3( 1, 0, 0 )
			 
	**/
	var normal : js.three.math.Vector3;
	/**
		
			 * @default 0
			 
	**/
	var constant : Float;
	var isPlane(default, null) : Bool;
	function set(normal:js.three.math.Vector3, constant:Float):js.three.math.Plane;
	function setComponents(x:Float, y:Float, z:Float, w:Float):js.three.math.Plane;
	function setFromNormalAndCoplanarPoint(normal:js.three.math.Vector3, point:js.three.math.Vector3):js.three.math.Plane;
	function setFromCoplanarPoints(a:js.three.math.Vector3, b:js.three.math.Vector3, c:js.three.math.Vector3):js.three.math.Plane;
	function clone():js.three.math.Plane;
	function copy(plane:js.three.math.Plane):js.three.math.Plane;
	function normalize():js.three.math.Plane;
	function negate():js.three.math.Plane;
	function distanceToPoint(point:js.three.math.Vector3):Float;
	function distanceToSphere(sphere:js.three.math.Sphere):Float;
	function projectPoint(point:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	function intersectLine(line:js.three.math.Line3, target:js.three.math.Vector3):js.three.math.Vector3;
	function intersectsLine(line:js.three.math.Line3):Bool;
	function intersectsBox(box:js.three.math.Box3):Bool;
	function intersectsSphere(sphere:js.three.math.Sphere):Bool;
	function coplanarPoint(target:js.three.math.Vector3):js.three.math.Vector3;
	function applyMatrix4(matrix:js.three.math.Matrix4, ?optionalNormalMatrix:js.three.math.Matrix3):js.three.math.Plane;
	function translate(offset:js.three.math.Vector3):js.three.math.Plane;
	function equals(plane:js.three.math.Plane):Bool;
	/**
		
			 * @deprecated Use {@link Plane#intersectsLine .intersectsLine()} instead.
			 
	**/
	function isIntersectionLine(l:Dynamic):Dynamic;
}
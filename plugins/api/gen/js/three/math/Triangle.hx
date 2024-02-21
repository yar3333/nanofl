package js.three.math;

@:native("THREE.Triangle") extern class Triangle {
	function new(?a:js.three.math.Vector3, ?b:js.three.math.Vector3, ?c:js.three.math.Vector3):Void;
	/**
		
			 * @default new THREE.Vector3()
			 
	**/
	var a : js.three.math.Vector3;
	/**
		
			 * @default new THREE.Vector3()
			 
	**/
	var b : js.three.math.Vector3;
	/**
		
			 * @default new THREE.Vector3()
			 
	**/
	var c : js.three.math.Vector3;
	function set(a:js.three.math.Vector3, b:js.three.math.Vector3, c:js.three.math.Vector3):js.three.math.Triangle;
	function setFromPointsAndIndices(points:Array<js.three.math.Vector3>, i0:Float, i1:Float, i2:Float):js.three.math.Triangle;
	function setFromAttributeAndIndices(attribute:haxe.extern.EitherType<js.three.core.BufferAttribute, js.three.core.InterleavedBufferAttribute>, i0:Float, i1:Float, i2:Float):js.three.math.Triangle;
	function clone():js.three.math.Triangle;
	function copy(triangle:js.three.math.Triangle):js.three.math.Triangle;
	function getArea():Float;
	function getMidpoint(target:js.three.math.Vector3):js.three.math.Vector3;
	function getNormal(target:js.three.math.Vector3):js.three.math.Vector3;
	function getPlane(target:js.three.math.Plane):js.three.math.Plane;
	function getBarycoord(point:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	@:overload(function(point:js.three.math.Vector3, p1:js.three.math.Vector3, p2:js.three.math.Vector3, p3:js.three.math.Vector3, v1:js.three.math.Vector4, v2:js.three.math.Vector4, v3:js.three.math.Vector4, target:js.three.math.Vector4):js.three.math.Vector4 { })
	@:overload(function(point:js.three.math.Vector3, p1:js.three.math.Vector3, p2:js.three.math.Vector3, p3:js.three.math.Vector3, v1:js.three.math.Vector3, v2:js.three.math.Vector3, v3:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3 { })
	function getInterpolation(point:js.three.math.Vector3, v1:js.three.math.Vector2, v2:js.three.math.Vector2, v3:js.three.math.Vector2, target:js.three.math.Vector2):js.three.math.Vector2;
	function containsPoint(point:js.three.math.Vector3):Bool;
	function intersectsBox(box:js.three.math.Box3):Bool;
	function isFrontFacing(direction:js.three.math.Vector3):Bool;
	function closestPointToPoint(point:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	function equals(triangle:js.three.math.Triangle):Bool;
	static function getNormal(a:js.three.math.Vector3, b:js.three.math.Vector3, c:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	static function getBarycoord(point:js.three.math.Vector3, a:js.three.math.Vector3, b:js.three.math.Vector3, c:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3;
	static function containsPoint(point:js.three.math.Vector3, a:js.three.math.Vector3, b:js.three.math.Vector3, c:js.three.math.Vector3):Bool;
	@:overload(function(point:js.three.math.Vector3, p1:js.three.math.Vector3, p2:js.three.math.Vector3, p3:js.three.math.Vector3, v1:js.three.math.Vector4, v2:js.three.math.Vector4, v3:js.three.math.Vector4, target:js.three.math.Vector4):js.three.math.Vector4 { })
	@:overload(function(point:js.three.math.Vector3, p1:js.three.math.Vector3, p2:js.three.math.Vector3, p3:js.three.math.Vector3, v1:js.three.math.Vector3, v2:js.three.math.Vector3, v3:js.three.math.Vector3, target:js.three.math.Vector3):js.three.math.Vector3 { })
	static function getInterpolation(point:js.three.math.Vector3, p1:js.three.math.Vector3, p2:js.three.math.Vector3, p3:js.three.math.Vector3, v1:js.three.math.Vector2, v2:js.three.math.Vector2, v3:js.three.math.Vector2, target:js.three.math.Vector2):js.three.math.Vector2;
	static function isFrontFacing(a:js.three.math.Vector3, b:js.three.math.Vector3, c:js.three.math.Vector3, direction:js.three.math.Vector3):Bool;
}
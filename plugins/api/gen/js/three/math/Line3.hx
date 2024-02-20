package js.three.math;

@:native("THREE.Line3") extern class Line3 {
	function new(?start:js.three.math.Vector3, ?end:js.three.math.Vector3):Void;
	/**
		
			 * @default new THREE.Vector3()
			 
	**/
	var start : js.three.math.Vector3;
	/**
		
			 * @default new THREE.Vector3()
			 
	**/
	var end : js.three.math.Vector3;
	function set(?start:js.three.math.Vector3, ?end:js.three.math.Vector3):js.three.math.Line3;
	function clone():js.three.math.Line3;
	function copy(line:js.three.math.Line3):js.three.math.Line3;
	function getCenter(target:js.three.math.Vector3):js.three.math.Vector3;
	function delta(target:js.three.math.Vector3):js.three.math.Vector3;
	function distanceSq():Float;
	function distance():Float;
	function at(t:Float, target:js.three.math.Vector3):js.three.math.Vector3;
	function closestPointToPointParameter(point:js.three.math.Vector3, ?clampToLine:Bool):Float;
	function closestPointToPoint(point:js.three.math.Vector3, clampToLine:Bool, target:js.three.math.Vector3):js.three.math.Vector3;
	function applyMatrix4(matrix:js.three.math.Matrix4):js.three.math.Line3;
	function equals(line:js.three.math.Line3):Bool;
}
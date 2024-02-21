package js.three.math;

@:native("THREE.Cylindrical") extern class Cylindrical {
	function new(?radius:Float, ?theta:Float, ?y:Float):Void;
	/**
		
			 * @default 1
			 
	**/
	var radius : Float;
	/**
		
			 * @default 0
			 
	**/
	var theta : Float;
	/**
		
			 * @default 0
			 
	**/
	var y : Float;
	function clone():js.three.math.Cylindrical;
	function copy(other:js.three.math.Cylindrical):js.three.math.Cylindrical;
	function set(radius:Float, theta:Float, y:Float):js.three.math.Cylindrical;
	function setFromVector3(vec3:js.three.math.Vector3):js.three.math.Cylindrical;
	function setFromCartesianCoords(x:Float, y:Float, z:Float):js.three.math.Cylindrical;
}
package js.three.math;

@:native("THREE.Spherical") extern class Spherical {
	function new(?radius:Float, ?phi:Float, ?theta:Float):Void;
	/**
		
			 * @default 1
			 
	**/
	var radius : Float;
	/**
		
			 * @default 0
			 
	**/
	var phi : Float;
	/**
		
			 * @default 0
			 
	**/
	var theta : Float;
	function set(radius:Float, phi:Float, theta:Float):js.three.math.Spherical;
	function clone():js.three.math.Spherical;
	function copy(other:js.three.math.Spherical):js.three.math.Spherical;
	function makeSafe():js.three.math.Spherical;
	function setFromVector3(v:js.three.math.Vector3):js.three.math.Spherical;
	function setFromCartesianCoords(x:Float, y:Float, z:Float):js.three.math.Spherical;
}
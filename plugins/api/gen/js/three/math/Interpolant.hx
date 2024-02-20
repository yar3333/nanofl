package js.three.math;

@:native("THREE.Interpolant") extern class Interpolant {
	function new(parameterPositions:Dynamic, sampleValues:Dynamic, sampleSize:Float, ?resultBuffer:Dynamic):Void;
	var parameterPositions : Dynamic;
	var sampleValues : Dynamic;
	var valueSize : Float;
	var resultBuffer : Dynamic;
	function evaluate(time:Float):Dynamic;
}
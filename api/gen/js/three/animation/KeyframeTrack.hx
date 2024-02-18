package js.three.animation;

@:native("THREE.KeyframeTrack") extern class KeyframeTrack {
	function new(name:String, times:js.three.ArrayLike<Float>, values:js.three.ArrayLike<Dynamic>, ?interpolation:js.three.InterpolationModes):Void;
	var name : String;
	var times : js.lib.Float32Array;
	var values : js.lib.Float32Array;
	var ValueTypeName : String;
	var TimeBufferType : js.lib.Float32Array;
	var ValueBufferType : js.lib.Float32Array;
	/**
		
			 * @default THREE.InterpolateLinear
			 
	**/
	var DefaultInterpolation : js.three.InterpolationModes;
	function InterpolantFactoryMethodDiscrete(result:Dynamic):js.three.math.interpolants.DiscreteInterpolant;
	function InterpolantFactoryMethodLinear(result:Dynamic):js.three.math.interpolants.LinearInterpolant;
	function InterpolantFactoryMethodSmooth(result:Dynamic):js.three.math.interpolants.CubicInterpolant;
	function setInterpolation(interpolation:js.three.InterpolationModes):js.three.animation.KeyframeTrack;
	function getInterpolation():js.three.InterpolationModes;
	function createInterpolant():js.three.math.Interpolant;
	function getValueSize():Float;
	function shift(timeOffset:Float):js.three.animation.KeyframeTrack;
	function scale(timeScale:Float):js.three.animation.KeyframeTrack;
	function trim(startTime:Float, endTime:Float):js.three.animation.KeyframeTrack;
	function validate():Bool;
	function optimize():js.three.animation.KeyframeTrack;
	function clone():js.three.animation.KeyframeTrack;
	static function toJSON(track:js.three.animation.KeyframeTrack):Dynamic;
}
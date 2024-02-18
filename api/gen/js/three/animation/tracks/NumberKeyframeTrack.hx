package js.three.animation.tracks;

@:native("THREE.NumberKeyframeTrack") extern class NumberKeyframeTrack extends js.three.animation.KeyframeTrack {
	/**
		
			 * @default 'number'
			 
	**/
	function new(name:String, times:js.three.ArrayLike<Float>, values:js.three.ArrayLike<Float>, ?interpolation:js.three.InterpolationModes):Void;
}
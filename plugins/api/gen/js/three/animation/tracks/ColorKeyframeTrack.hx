package js.three.animation.tracks;

@:native("THREE.ColorKeyframeTrack") extern class ColorKeyframeTrack extends js.three.animation.KeyframeTrack {
	/**
		
			 * @default 'color'
			 
	**/
	function new(name:String, times:js.three.ArrayLike<Float>, values:js.three.ArrayLike<Float>, ?interpolation:js.three.InterpolationModes):Void;
}
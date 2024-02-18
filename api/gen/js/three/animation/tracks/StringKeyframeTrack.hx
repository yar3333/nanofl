package js.three.animation.tracks;

@:native("THREE.StringKeyframeTrack") extern class StringKeyframeTrack extends js.three.animation.KeyframeTrack {
	/**
		
			 * @default 'string'
			 
	**/
	function new(name:String, times:js.three.ArrayLike<Float>, values:js.three.ArrayLike<Dynamic>, ?interpolation:js.three.InterpolationModes):Void;
}
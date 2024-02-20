package js.three.animation.tracks;

@:native("THREE.QuaternionKeyframeTrack") extern class QuaternionKeyframeTrack extends js.three.animation.KeyframeTrack {
	/**
		
			 * @default 'quaternion'
			 
	**/
	function new(name:String, times:js.three.ArrayLike<Float>, values:js.three.ArrayLike<Float>, ?interpolation:js.three.InterpolationModes):Void;
}
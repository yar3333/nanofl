package js.three.animation.tracks;

@:native("THREE.VectorKeyframeTrack") extern class VectorKeyframeTrack extends js.three.animation.KeyframeTrack {
	/**
		
			 * @default 'vector'
			 
	**/
	function new(name:String, times:js.three.ArrayLike<Float>, values:js.three.ArrayLike<Float>, ?interpolation:js.three.InterpolationModes):Void;
}
package js.three.animation.tracks;

@:native("THREE.BooleanKeyframeTrack") extern class BooleanKeyframeTrack extends js.three.animation.KeyframeTrack {
	/**
		
			 * @default 'bool'
			 
	**/
	function new(name:String, times:js.three.ArrayLike<Float>, values:js.three.ArrayLike<Dynamic>):Void;
}
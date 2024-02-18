package soundjs.cordovaaudio;

/**
 * CordovaAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
 * {{#crossLink "CordovaAudioPlugin"}}{{/crossLink}}.
 */
/**
	
	 * CordovaAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
	 * {{#crossLink "CordovaAudioPlugin"}}{{/crossLink}}.
	 
**/
@:native('createjs.CordovaAudioSoundInstance') extern class CordovaAudioSoundInstance extends soundjs.AbstractSoundInstance {
	function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	/**
		
			 * Sets the playAudioWhenScreenIsLocked property for play calls on iOS devices.
			 
	**/
	var playWhenScreenLocked : Bool;
	/**
		
			 * Maps to <a href="http://plugins.cordova.io/#/package/org.apache.cordova.media" target="_blank">Media.getCurrentPosition</a>,
			 * which is curiously asynchronus and requires a callback.
			 
	**/
	function getCurrentPosition(mediaSuccess:haxe.Constraints.Function, ?mediaError:haxe.Constraints.Function):Void;
}
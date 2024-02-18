package soundjs.htmlaudio;

@:native('createjs.HTMLAudioSoundInstance') extern class HTMLAudioSoundInstance extends soundjs.AbstractSoundInstance {
	/**
		
			 * HTMLAudioSoundInstance extends the base api of {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} and is used by
			 * {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
			 *
			 * @param {String} src The path to and file name of the sound.
			 * @param {Number} startTime Audio sprite property used to apply an offset, in milliseconds.
			 * @param {Number} duration Audio sprite property used to set the time the clip plays for, in milliseconds.
			 * @param {Object} playbackResource Any resource needed by plugin to support audio playback.
			 * @class HTMLAudioSoundInstance
			 * @extends AbstractSoundInstance
			 * @constructor
			 
	**/
	function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	/**
		
			 * Called by {{#crossLink "Sound"}}{{/crossLink}} when plugin does not handle master volume.
			 * undoc'd because it is not meant to be used outside of Sound
			 * #method setMasterVolume
			 * @param value
			 
	**/
	function setMasterVolume(value:Float):Void;
	/**
		
			 * Called by {{#crossLink "Sound"}}{{/crossLink}} when plugin does not handle master mute.
			 * undoc'd because it is not meant to be used outside of Sound
			 * #method setMasterMute
			 * @param value
			 
	**/
	function setMasterMute(isMuted:Bool):Void;
	override function toString():String;
}
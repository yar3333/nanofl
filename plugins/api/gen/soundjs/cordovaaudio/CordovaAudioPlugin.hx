package soundjs.cordovaaudio;

/**
 * Play sounds using Cordova Media plugin, which will work with a Cordova app and tools that utilize Cordova such as PhoneGap or Ionic.
 * This plugin is not used by default, and must be registered manually in {{#crossLink "Sound"}}{{/crossLink}}
 * using the {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method.
 * This plugin is recommended when building a Cordova based app, but is not required.
 *
 * <b>NOTE the <a href="http://plugins.cordova.io/#/package/org.apache.cordova.media" target="_blank">Cordova Media plugin</a> is required</b>
 *
 * 		cordova plugin add org.apache.cordova.media
 *
 * <h4>Known Issues</h4>
 * <b>Audio Position</b>
 * <ul>Audio position is calculated asynchronusly by Media.  The SoundJS solution to this problem is two-fold:
 * <li>Provide {{#crossLink "CordovaAudioSoundInstance/getCurrentPosition"}}{{/crossLink}} that maps directly to media.getCurrentPosition.</li>
 * <li>Provide a best guess position based on elapsed time since playback started, which is synchronized with actual position when the audio is paused or stopped.
 * Testing showed this to be fairly reliable within 200ms.</li></ul>
 * <b>Cordova Media Docs</b>
 * <ul><li>See the <a href="http://plugins.cordova.io/#/package/org.apache.cordova.media" target="_blank">Cordova Media Docs</a> for various known OS issues.</li></ul>
 * <br />
 */
/**
	
	 * Play sounds using Cordova Media plugin, which will work with a Cordova app and tools that utilize Cordova such as PhoneGap or Ionic.
	 * This plugin is not used by default, and must be registered manually in {{#crossLink "Sound"}}{{/crossLink}}
	 * using the {{#crossLink "Sound/registerPlugins"}}{{/crossLink}} method.
	 * This plugin is recommended when building a Cordova based app, but is not required.
	 * 
	 * <b>NOTE the <a href="http://plugins.cordova.io/#/package/org.apache.cordova.media" target="_blank">Cordova Media plugin</a> is required</b>
	 * 
	 * 		cordova plugin add org.apache.cordova.media
	 * 
	 * <h4>Known Issues</h4>
	 * <b>Audio Position</b>
	 * <ul>Audio position is calculated asynchronusly by Media.  The SoundJS solution to this problem is two-fold:
	 * <li>Provide {{#crossLink "CordovaAudioSoundInstance/getCurrentPosition"}}{{/crossLink}} that maps directly to media.getCurrentPosition.</li>
	 * <li>Provide a best guess position based on elapsed time since playback started, which is synchronized with actual position when the audio is paused or stopped.
	 * Testing showed this to be fairly reliable within 200ms.</li></ul>
	 * <b>Cordova Media Docs</b>
	 * <ul><li>See the <a href="http://plugins.cordova.io/#/package/org.apache.cordova.media" target="_blank">Cordova Media Docs</a> for various known OS issues.</li></ul>
	 * <br />
	 
**/
@:native('createjs.CordovaAudioPlugin') extern class CordovaAudioPlugin extends soundjs.AbstractPlugin {
	function new():Void;
	/**
		
			 * Get the duration for a src.  Intended for internal use by CordovaAudioSoundInstance.
			 
	**/
	function getSrcDuration(src:Dynamic):Float;
	/**
		
			 * Sets a default playAudioWhenScreenIsLocked property for play calls on iOS devices.
			 * Individual SoundInstances can alter the default with {{#crossLink "CordovaAudioSoundInstance/playWhenScreenLocked"}}{{/crossLink}}.
			 
	**/
	static var playWhenScreenLocked : Bool;
	/**
		
			 * The version string for this release.
			 
	**/
	static var version : String;
	/**
		
			 * The build date for this release in UTC format.
			 
	**/
	static var buildDate : String;
	/**
		
			 * Determine if the plugin can be used in the current browser/OS. Note that HTML audio is available in most modern
			 * browsers, but is disabled in iOS because of its limitations.
			 
	**/
	static function isSupported():Bool;
}
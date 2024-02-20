package soundjs;

typedef AbstractSoundInstanceSucceededEvent = {
	var target : Dynamic;
	var type : String;
};

typedef AbstractSoundInstanceInterruptedEvent = {
	var target : Dynamic;
	var type : String;
};

typedef AbstractSoundInstanceFailedEvent = {
	var target : Dynamic;
	var type : String;
};

typedef AbstractSoundInstanceLoopEvent = {
	var target : Dynamic;
	var type : String;
};

typedef AbstractSoundInstanceCompleteEvent = {
	var target : Dynamic;
	var type : String;
};

/**
 * A AbstractSoundInstance is created when any calls to the Sound API method {{#crossLink "Sound/play"}}{{/crossLink}} or
 * {{#crossLink "Sound/createInstance"}}{{/crossLink}} are made. The AbstractSoundInstance is returned by the active plugin
 * for control by the user.
 *
 * <h4>Example</h4>
 *
 *      var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
 *
 * A number of additional parameters provide a quick way to determine how a sound is played. Please see the Sound
 * API method {{#crossLink "Sound/play"}}{{/crossLink}} for a list of arguments.
 *
 * Once a AbstractSoundInstance is created, a reference can be stored that can be used to control the audio directly through
 * the AbstractSoundInstance. If the reference is not stored, the AbstractSoundInstance will play out its audio (and any loops), and
 * is then de-referenced from the {{#crossLink "Sound"}}{{/crossLink}} class so that it can be cleaned up. If audio
 * playback has completed, a simple call to the {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}} instance method
 * will rebuild the references the Sound class need to control it.
 *
 *      var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3", {loop:2});
 *      myInstance.on("loop", handleLoop);
 *      function handleLoop(event) {
 *          myInstance.volume = myInstance.volume * 0.5;
 *      }
 *
 * Events are dispatched from the instance to notify when the sound has completed, looped, or when playback fails
 *
 *      var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
 *      myInstance.on("complete", handleComplete);
 *      myInstance.on("loop", handleLoop);
 *      myInstance.on("failed", handleFailed);
 */
/**
	
	 * A AbstractSoundInstance is created when any calls to the Sound API method {{#crossLink "Sound/play"}}{{/crossLink}} or
	 * {{#crossLink "Sound/createInstance"}}{{/crossLink}} are made. The AbstractSoundInstance is returned by the active plugin
	 * for control by the user.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
	 * 
	 * A number of additional parameters provide a quick way to determine how a sound is played. Please see the Sound
	 * API method {{#crossLink "Sound/play"}}{{/crossLink}} for a list of arguments.
	 * 
	 * Once a AbstractSoundInstance is created, a reference can be stored that can be used to control the audio directly through
	 * the AbstractSoundInstance. If the reference is not stored, the AbstractSoundInstance will play out its audio (and any loops), and
	 * is then de-referenced from the {{#crossLink "Sound"}}{{/crossLink}} class so that it can be cleaned up. If audio
	 * playback has completed, a simple call to the {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}} instance method
	 * will rebuild the references the Sound class need to control it.
	 * 
	 *      var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3", {loop:2});
	 *      myInstance.on("loop", handleLoop);
	 *      function handleLoop(event) {
	 *          myInstance.volume = myInstance.volume * 0.5;
	 *      }
	 * 
	 * Events are dispatched from the instance to notify when the sound has completed, looped, or when playback fails
	 * 
	 *      var myInstance = createjs.Sound.play("myAssetPath/mySrcFile.mp3");
	 *      myInstance.on("complete", handleComplete);
	 *      myInstance.on("loop", handleLoop);
	 *      myInstance.on("failed", handleFailed);
	 
**/
@:native('createjs.AbstractSoundInstance') extern class AbstractSoundInstance extends createjs.events.EventDispatcher {
	function new(src:String, startTime:Float, duration:Float, playbackResource:Dynamic):Void;
	/**
		
			 * The source of the sound.
			 
	**/
	var src : String;
	/**
		
			 * The unique ID of the instance. This is set by {{#crossLink "Sound"}}{{/crossLink}}.
			 
	**/
	var uniqueId : Dynamic;
	/**
		
			 * The play state of the sound. Play states are defined as constants on {{#crossLink "Sound"}}{{/crossLink}}.
			 
	**/
	var playState : String;
	/**
		
			 * The volume of the sound, between 0 and 1.
			 * 
			 * The actual output volume of a sound can be calculated using:
			 * <code>myInstance.volume * createjs.Sound._getVolume();</code>
			 
	**/
	var volume : Float;
	/**
		
			 * The pan of the sound, between -1 (left) and 1 (right). Note that pan is not supported by HTML Audio.
			 * 
			 * Note in WebAudioPlugin this only gives us the "x" value of what is actually 3D audio
			 
	**/
	var pan : Float;
	/**
		
			 * Audio sprite property used to determine the starting offset.
			 
	**/
	var startTime : Float;
	/**
		
			 * Sets or gets the length of the audio clip, value is in milliseconds.
			 
	**/
	var duration : Float;
	/**
		
			 * Object that holds plugin specific resource need for audio playback.
			 * This is set internally by the plugin.  For example, WebAudioPlugin will set an array buffer,
			 * HTMLAudioPlugin will set a tag, FlashAudioPlugin will set a flash reference.
			 
	**/
	var playbackResource : Dynamic;
	/**
		
			 * The position of the playhead in milliseconds. This can be set while a sound is playing, paused, or stopped.
			 
	**/
	var position : Float;
	/**
		
			 * The number of play loops remaining. Negative values will loop infinitely.
			 
	**/
	var loop : Float;
	/**
		
			 * Mutes or unmutes the current audio instance.
			 
	**/
	var muted : Bool;
	/**
		
			 * Pauses or resumes the current audio instance.
			 
	**/
	var paused : Bool;
	/**
		
			 * Play an instance. This method is intended to be called on SoundInstances that already exist (created
			 * with the Sound API {{#crossLink "Sound/createInstance"}}{{/crossLink}} or {{#crossLink "Sound/play"}}{{/crossLink}}).
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var myInstance = createjs.Sound.createInstance(mySrc);
			 *      myInstance.play({interrupt:createjs.Sound.INTERRUPT_ANY, loop:2, pan:0.5});
			 * 
			 * Note that if this sound is already playing, this call will still set the passed in parameters.
			 * 
			 * <b>Parameters Deprecated</b><br />
			 * The parameters for this method are deprecated in favor of a single parameter that is an Object or {{#crossLink "PlayPropsConfig"}}{{/crossLink}}.
			 
	**/
	function play(?props:Dynamic):soundjs.AbstractSoundInstance;
	/**
		
			 * Stop playback of the instance. Stopped sounds will reset their position to 0, and calls to {{#crossLink "AbstractSoundInstance/resume"}}{{/crossLink}}
			 * will fail. To start playback again, call {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}}.
			 * 
			 * If you don't want to lose your position use yourSoundInstance.paused = true instead. {{#crossLink "AbstractSoundInstance/paused"}}{{/crossLink}}.
			 * 
			 * <h4>Example</h4>
			 * 
			 *     myInstance.stop();
			 
	**/
	function stop():soundjs.AbstractSoundInstance;
	/**
		
			 * Remove all external references and resources from AbstractSoundInstance.  Note this is irreversible and AbstractSoundInstance will no longer work
			 
	**/
	function destroy():Void;
	/**
		
			 * Takes an PlayPropsConfig or Object with the same properties and sets them on this instance.
			 
	**/
	function applyPlayProps(playProps:Dynamic):soundjs.AbstractSoundInstance;
}
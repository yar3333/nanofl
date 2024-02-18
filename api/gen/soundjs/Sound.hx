package soundjs;

typedef SoundFileloadEvent = {
	var data : Dynamic;
	var id : String;
	var src : String;
	var target : Dynamic;
	var type : String;
};

typedef SoundFileerrorEvent = {
	var data : Dynamic;
	var id : String;
	var src : String;
	var target : Dynamic;
	var type : String;
};

/**
 * The Sound class is the public API for creating sounds, controlling the overall sound levels, and managing plugins.
 * All Sound APIs on this class are static.
 *
 * <b>Registering and Preloading</b><br />
 * Before you can play a sound, it <b>must</b> be registered. You can do this with {{#crossLink "Sound/registerSound"}}{{/crossLink}},
 * or register multiple sounds using {{#crossLink "Sound/registerSounds"}}{{/crossLink}}. If you don't register a
 * sound prior to attempting to play it using {{#crossLink "Sound/play"}}{{/crossLink}} or create it using {{#crossLink "Sound/createInstance"}}{{/crossLink}},
 * the sound source will be automatically registered but playback will fail as the source will not be ready. If you use
 * <a href="http://preloadjs.com" target="_blank">PreloadJS</a>, registration is handled for you when the sound is
 * preloaded. It is recommended to preload sounds either internally using the register functions or externally using
 * PreloadJS so they are ready when you want to use them.
 *
 * <b>Playback</b><br />
 * To play a sound once it's been registered and preloaded, use the {{#crossLink "Sound/play"}}{{/crossLink}} method.
 * This method returns a {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} which can be paused, resumed, muted, etc.
 * Please see the {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} documentation for more on the instance control APIs.
 *
 * <b>Plugins</b><br />
 * By default, the {{#crossLink "WebAudioPlugin"}}{{/crossLink}} or the {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}
 * are used (when available), although developers can change plugin priority or add new plugins (such as the
 * provided {{#crossLink "FlashAudioPlugin"}}{{/crossLink}}). Please see the {{#crossLink "Sound"}}{{/crossLink}} API
 * methods for more on the playback and plugin APIs. To install plugins, or specify a different plugin order, see
 * {{#crossLink "Sound/installPlugins"}}{{/crossLink}}.
 *
 * <h4>Example</h4>
 *
 *      createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio";
 *      createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.FlashAudioPlugin]);
 *      createjs.Sound.alternateExtensions = ["mp3"];
 *      createjs.Sound.on("fileload", this.loadHandler, this);
 *      createjs.Sound.registerSound("path/to/mySound.ogg", "sound");
 *      function loadHandler(event) {
 *          // This is fired for each sound that is registered.
 *          var instance = createjs.Sound.play("sound");  // play using id.  Could also use full source path or event.src.
 *          instance.on("complete", this.handleComplete, this);
 *          instance.volume = 0.5;
 *      }
 *
 * The maximum number of concurrently playing instances of the same sound can be specified in the "data" argument
 * of {{#crossLink "Sound/registerSound"}}{{/crossLink}}.  Note that if not specified, the active plugin will apply
 * a default limit.  Currently HTMLAudioPlugin sets a default limit of 2, while WebAudioPlugin and FlashAudioPlugin set a
 * default limit of 100.
 *
 *      createjs.Sound.registerSound("sound.mp3", "soundId", 4);
 *
 * Sound can be used as a plugin with PreloadJS to help preload audio properly. Audio preloaded with PreloadJS is
 * automatically registered with the Sound class. When audio is not preloaded, Sound will do an automatic internal
 * load. As a result, it may fail to play the first time play is called if the audio is not finished loading. Use
 * the {{#crossLink "Sound/fileload:event"}}{{/crossLink}} event to determine when a sound has finished internally
 * preloading. It is recommended that all audio is preloaded before it is played.
 *
 *      var queue = new createjs.LoadQueue();
 * 		queue.installPlugin(createjs.Sound);
 *
 * <b>Audio Sprites</b><br />
 * SoundJS has added support for {{#crossLink "AudioSprite"}}{{/crossLink}}, available as of version 0.6.0.
 * For those unfamiliar with audio sprites, they are much like CSS sprites or sprite sheets: multiple audio assets
 * grouped into a single file.
 *
 * <h4>Example</h4>
 *
 * 		var assetsPath = "./assets/";
 * 		var sounds = [{
 * 			src:"MyAudioSprite.ogg", data: {
 * 				audioSprite: [
 * 					{id:"sound1", startTime:0, duration:500},
 * 					{id:"sound2", startTime:1000, duration:400},
 * 					{id:"sound3", startTime:1700, duration: 1000}
 * 				]}
 * 			}
 * 		];
 * 		createjs.Sound.alternateExtensions = ["mp3"];
 * 		createjs.Sound.on("fileload", loadSound);
 * 		createjs.Sound.registerSounds(sounds, assetsPath);
 * 		// after load is complete
 * 		createjs.Sound.play("sound2");
 *
 * <b>Mobile Playback</b><br />
 * Devices running iOS require the WebAudio context to be "unlocked" by playing at least one sound inside of a user-
 * initiated event (such as touch/click). Earlier versions of SoundJS included a "MobileSafe" sample, but this is no
 * longer necessary as of SoundJS 0.6.2.
 * <ul>
 *     <li>
 *         In SoundJS 0.4.1 and above, you can either initialize plugins or use the {{#crossLink "WebAudioPlugin/playEmptySound"}}{{/crossLink}}
 *         method in the call stack of a user input event to manually unlock the audio context.
 *     </li>
 *     <li>
 *         In SoundJS 0.6.2 and above, SoundJS will automatically listen for the first document-level "mousedown"
 *         and "touchend" event, and unlock WebAudio. This will continue to check these events until the WebAudio
 *         context becomes "unlocked" (changes from "suspended" to "running")
 *     </li>
 *     <li>
 *         Both the "mousedown" and "touchend" events can be used to unlock audio in iOS9+, the "touchstart" event
 *         will work in iOS8 and below. The "touchend" event will only work in iOS9 when the gesture is interpreted
 *         as a "click", so if the user long-presses the button, it will no longer work.
 *     </li>
 *     <li>
 *         When using the <a href="http://www.createjs.com/docs/easeljs/classes/Touch.html">EaselJS Touch class</a>,
 *         the "mousedown" event will not fire when a canvas is clicked, since MouseEvents are prevented, to ensure
 *         only touch events fire. To get around this, you can either rely on "touchend", or:
 *         <ol>
 *             <li>Set the `allowDefault` property on the Touch class constructor to `true` (defaults to `false`).</li>
 *             <li>Set the `preventSelection` property on the EaselJS `Stage` to `false`.</li>
 *         </ol>
 *         These settings may change how your application behaves, and are not recommended.
 *     </li>
 * </ul>
 *
 * <b>Loading Alternate Paths and Extension-less Files</b><br />
 * SoundJS supports loading alternate paths and extension-less files by passing an object instead of a string for
 * the `src` property, which is a hash using the format `{extension:"path", extension2:"path2"}`. These labels are
 * how SoundJS determines if the browser will support the sound. This also enables multiple formats to live in
 * different folders, or on CDNs, which often has completely different filenames for each file.
 *
 * Priority is determined by the property order (first property is tried first).  This is supported by both internal loading
 * and loading with PreloadJS.
 *
 * <em>Note: an id is required for playback.</em>
 *
 * <h4>Example</h4>
 *
 * 		var sounds = {path:"./audioPath/",
 * 				manifest: [
 * 				{id: "cool", src: {mp3:"mp3/awesome.mp3", ogg:"noExtensionOggFile"}}
 * 		]};
 *
 * 		createjs.Sound.alternateExtensions = ["mp3"];
 * 		createjs.Sound.addEventListener("fileload", handleLoad);
 * 		createjs.Sound.registerSounds(sounds);
 *
 * <h3>Known Browser and OS issues</h3>
 * <b>IE 9 HTML Audio limitations</b><br />
 * <ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
 * muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
 * when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
 * <li>MP3 encoding will not always work for audio tags, particularly in Internet Explorer. We've found default
 * encoding with 64kbps works.</li>
 * <li>Occasionally very short samples will get cut off.</li>
 * <li>There is a limit to how many audio tags you can load and play at once, which appears to be determined by
 * hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe
 * estimate.</li></ul>
 *
 * <b>Firefox 25 Web Audio limitations</b>
 * <ul><li>mp3 audio files do not load properly on all windows machines, reported
 * <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=929969" target="_blank">here</a>. </br>
 * For this reason it is recommended to pass another FF supported type (ie ogg) first until this bug is resolved, if
 * possible.</li></ul>
 *
 * <b>Safari limitations</b><br />
 * <ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
 *
 * <b>iOS 6 Web Audio limitations</b><br />
 * <ul><li>Sound is initially locked, and must be unlocked via a user-initiated event. Please see the section on
 * Mobile Playback above.</li>
 * <li>A bug exists that will distort un-cached web audio when a video element is present in the DOM that has audio
 * at a different sampleRate.</li>
 * </ul>
 *
 * <b>Android HTML Audio limitations</b><br />
 * <ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
 * <li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use
 * a delay.</li></ul>
 *
 * <b>Web Audio and PreloadJS</b><br />
 * <ul><li>Web Audio must be loaded through XHR, therefore when used with PreloadJS, tag loading is not possible.
 * This means that tag loading can not be used to avoid cross domain issues.</li><ul>
 */
/**
	
	 * The Sound class is the public API for creating sounds, controlling the overall sound levels, and managing plugins.
	 * All Sound APIs on this class are static.
	 * 
	 * <b>Registering and Preloading</b><br />
	 * Before you can play a sound, it <b>must</b> be registered. You can do this with {{#crossLink "Sound/registerSound"}}{{/crossLink}},
	 * or register multiple sounds using {{#crossLink "Sound/registerSounds"}}{{/crossLink}}. If you don't register a
	 * sound prior to attempting to play it using {{#crossLink "Sound/play"}}{{/crossLink}} or create it using {{#crossLink "Sound/createInstance"}}{{/crossLink}},
	 * the sound source will be automatically registered but playback will fail as the source will not be ready. If you use
	 * <a href="http://preloadjs.com" target="_blank">PreloadJS</a>, registration is handled for you when the sound is
	 * preloaded. It is recommended to preload sounds either internally using the register functions or externally using
	 * PreloadJS so they are ready when you want to use them.
	 * 
	 * <b>Playback</b><br />
	 * To play a sound once it's been registered and preloaded, use the {{#crossLink "Sound/play"}}{{/crossLink}} method.
	 * This method returns a {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} which can be paused, resumed, muted, etc.
	 * Please see the {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} documentation for more on the instance control APIs.
	 * 
	 * <b>Plugins</b><br />
	 * By default, the {{#crossLink "WebAudioPlugin"}}{{/crossLink}} or the {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}
	 * are used (when available), although developers can change plugin priority or add new plugins (such as the
	 * provided {{#crossLink "FlashAudioPlugin"}}{{/crossLink}}). Please see the {{#crossLink "Sound"}}{{/crossLink}} API
	 * methods for more on the playback and plugin APIs. To install plugins, or specify a different plugin order, see
	 * {{#crossLink "Sound/installPlugins"}}{{/crossLink}}.
	 * 
	 * <h4>Example</h4>
	 * 
	 *      createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio";
	 *      createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.FlashAudioPlugin]);
	 *      createjs.Sound.alternateExtensions = ["mp3"];
	 *      createjs.Sound.on("fileload", this.loadHandler, this);
	 *      createjs.Sound.registerSound("path/to/mySound.ogg", "sound");
	 *      function loadHandler(event) {
	 *          // This is fired for each sound that is registered.
	 *          var instance = createjs.Sound.play("sound");  // play using id.  Could also use full source path or event.src.
	 *          instance.on("complete", this.handleComplete, this);
	 *          instance.volume = 0.5;
	 *      }
	 * 
	 * The maximum number of concurrently playing instances of the same sound can be specified in the "data" argument
	 * of {{#crossLink "Sound/registerSound"}}{{/crossLink}}.  Note that if not specified, the active plugin will apply
	 * a default limit.  Currently HTMLAudioPlugin sets a default limit of 2, while WebAudioPlugin and FlashAudioPlugin set a
	 * default limit of 100.
	 * 
	 *      createjs.Sound.registerSound("sound.mp3", "soundId", 4);
	 * 
	 * Sound can be used as a plugin with PreloadJS to help preload audio properly. Audio preloaded with PreloadJS is
	 * automatically registered with the Sound class. When audio is not preloaded, Sound will do an automatic internal
	 * load. As a result, it may fail to play the first time play is called if the audio is not finished loading. Use
	 * the {{#crossLink "Sound/fileload:event"}}{{/crossLink}} event to determine when a sound has finished internally
	 * preloading. It is recommended that all audio is preloaded before it is played.
	 * 
	 *      var queue = new createjs.LoadQueue();
	 * 		queue.installPlugin(createjs.Sound);
	 * 
	 * <b>Audio Sprites</b><br />
	 * SoundJS has added support for {{#crossLink "AudioSprite"}}{{/crossLink}}, available as of version 0.6.0.
	 * For those unfamiliar with audio sprites, they are much like CSS sprites or sprite sheets: multiple audio assets
	 * grouped into a single file.
	 * 
	 * <h4>Example</h4>
	 * 
	 * 		var assetsPath = "./assets/";
	 * 		var sounds = [{
	 * 			src:"MyAudioSprite.ogg", data: {
	 * 				audioSprite: [
	 * 					{id:"sound1", startTime:0, duration:500},
	 * 					{id:"sound2", startTime:1000, duration:400},
	 * 					{id:"sound3", startTime:1700, duration: 1000}
	 * 				]}
	 * 			}
	 * 		];
	 * 		createjs.Sound.alternateExtensions = ["mp3"];
	 * 		createjs.Sound.on("fileload", loadSound);
	 * 		createjs.Sound.registerSounds(sounds, assetsPath);
	 * 		// after load is complete
	 * 		createjs.Sound.play("sound2");
	 * 
	 * <b>Mobile Playback</b><br />
	 * Devices running iOS require the WebAudio context to be "unlocked" by playing at least one sound inside of a user-
	 * initiated event (such as touch/click). Earlier versions of SoundJS included a "MobileSafe" sample, but this is no
	 * longer necessary as of SoundJS 0.6.2.
	 * <ul>
	 *     <li>
	 *         In SoundJS 0.4.1 and above, you can either initialize plugins or use the {{#crossLink "WebAudioPlugin/playEmptySound"}}{{/crossLink}}
	 *         method in the call stack of a user input event to manually unlock the audio context.
	 *     </li>
	 *     <li>
	 *         In SoundJS 0.6.2 and above, SoundJS will automatically listen for the first document-level "mousedown"
	 *         and "touchend" event, and unlock WebAudio. This will continue to check these events until the WebAudio
	 *         context becomes "unlocked" (changes from "suspended" to "running")
	 *     </li>
	 *     <li>
	 *         Both the "mousedown" and "touchend" events can be used to unlock audio in iOS9+, the "touchstart" event
	 *         will work in iOS8 and below. The "touchend" event will only work in iOS9 when the gesture is interpreted
	 *         as a "click", so if the user long-presses the button, it will no longer work.
	 *     </li>
	 *     <li>
	 *         When using the <a href="http://www.createjs.com/docs/easeljs/classes/Touch.html">EaselJS Touch class</a>,
	 *         the "mousedown" event will not fire when a canvas is clicked, since MouseEvents are prevented, to ensure
	 *         only touch events fire. To get around this, you can either rely on "touchend", or:
	 *         <ol>
	 *             <li>Set the `allowDefault` property on the Touch class constructor to `true` (defaults to `false`).</li>
	 *             <li>Set the `preventSelection` property on the EaselJS `Stage` to `false`.</li>
	 *         </ol>
	 *         These settings may change how your application behaves, and are not recommended.
	 *     </li>
	 * </ul>
	 * 
	 * <b>Loading Alternate Paths and Extension-less Files</b><br />
	 * SoundJS supports loading alternate paths and extension-less files by passing an object instead of a string for
	 * the `src` property, which is a hash using the format `{extension:"path", extension2:"path2"}`. These labels are
	 * how SoundJS determines if the browser will support the sound. This also enables multiple formats to live in
	 * different folders, or on CDNs, which often has completely different filenames for each file.
	 * 
	 * Priority is determined by the property order (first property is tried first).  This is supported by both internal loading
	 * and loading with PreloadJS.
	 * 
	 * <em>Note: an id is required for playback.</em>
	 * 
	 * <h4>Example</h4>
	 * 
	 * 		var sounds = {path:"./audioPath/",
	 * 				manifest: [
	 * 				{id: "cool", src: {mp3:"mp3/awesome.mp3", ogg:"noExtensionOggFile"}}
	 * 		]};
	 * 
	 * 		createjs.Sound.alternateExtensions = ["mp3"];
	 * 		createjs.Sound.addEventListener("fileload", handleLoad);
	 * 		createjs.Sound.registerSounds(sounds);
	 * 
	 * <h3>Known Browser and OS issues</h3>
	 * <b>IE 9 HTML Audio limitations</b><br />
	 * <ul><li>There is a delay in applying volume changes to tags that occurs once playback is started. So if you have
	 * muted all sounds, they will all play during this delay until the mute applies internally. This happens regardless of
	 * when or how you apply the volume change, as the tag seems to need to play to apply it.</li>
	 * <li>MP3 encoding will not always work for audio tags, particularly in Internet Explorer. We've found default
	 * encoding with 64kbps works.</li>
	 * <li>Occasionally very short samples will get cut off.</li>
	 * <li>There is a limit to how many audio tags you can load and play at once, which appears to be determined by
	 * hardware and browser settings.  See {{#crossLink "HTMLAudioPlugin.MAX_INSTANCES"}}{{/crossLink}} for a safe
	 * estimate.</li></ul>
	 * 
	 * <b>Firefox 25 Web Audio limitations</b>
	 * <ul><li>mp3 audio files do not load properly on all windows machines, reported
	 * <a href="https://bugzilla.mozilla.org/show_bug.cgi?id=929969" target="_blank">here</a>. </br>
	 * For this reason it is recommended to pass another FF supported type (ie ogg) first until this bug is resolved, if
	 * possible.</li></ul>
	 * 
	 * <b>Safari limitations</b><br />
	 * <ul><li>Safari requires Quicktime to be installed for audio playback.</li></ul>
	 * 
	 * <b>iOS 6 Web Audio limitations</b><br />
	 * <ul><li>Sound is initially locked, and must be unlocked via a user-initiated event. Please see the section on
	 * Mobile Playback above.</li>
	 * <li>A bug exists that will distort un-cached web audio when a video element is present in the DOM that has audio
	 * at a different sampleRate.</li>
	 * </ul>
	 * 
	 * <b>Android HTML Audio limitations</b><br />
	 * <ul><li>We have no control over audio volume. Only the user can set volume on their device.</li>
	 * <li>We can only play audio inside a user event (touch/click).  This currently means you cannot loop sound or use
	 * a delay.</li></ul>
	 * 
	 * <b>Web Audio and PreloadJS</b><br />
	 * <ul><li>Web Audio must be loaded through XHR, therefore when used with PreloadJS, tag loading is not possible.
	 * This means that tag loading can not be used to avoid cross domain issues.</li><ul>
	 
**/
@:native('createjs.Sound') extern class Sound {
	/**
		
			 * Set the master volume of Sound. The master volume is multiplied against each sound's individual volume.  For
			 * example, if master volume is 0.5 and a sound's volume is 0.5, the resulting volume is 0.25. To set individual
			 * sound volume, use AbstractSoundInstance {{#crossLink "AbstractSoundInstance/volume:property"}}{{/crossLink}}
			 * instead.
			 * 
			 * <h4>Example</h4>
			 * 
			 *     createjs.Sound.volume = 0.5;
			 
	**/
	var volume : Float;
	/**
		
			 * Mute/Unmute all audio. Note that muted audio still plays at 0 volume. This global mute value is maintained
			 * separately and when set will override, but not change the mute property of individual instances. To mute an individual
			 * instance, use AbstractSoundInstance {{#crossLink "AbstractSoundInstance/muted:property"}}{{/crossLink}} instead.
			 * 
			 * <h4>Example</h4>
			 * 
			 *     createjs.Sound.muted = true;
			 
	**/
	var muted : Bool;
	/**
		
			 * Set the default playback properties for all new SoundInstances of the passed in src or ID.
			 * See {{#crossLink "PlayPropsConfig"}}{{/crossLink}} for available properties.
			 
	**/
	function setDefaultPlayProps(src:String, playProps:Dynamic):Void;
	/**
		
			 * Get the default playback properties for the passed in src or ID.  These properties are applied to all
			 * new SoundInstances.  Returns null if default does not exist.
			 
	**/
	function getDefaultPlayProps(src:String):soundjs.data.PlayPropsConfig;
	function toString():String;
	/**
		
			 * The interrupt value to interrupt any currently playing instance with the same source, if the maximum number of
			 * instances of the sound are already playing.
			 
	**/
	static var INTERRUPT_ANY : String;
	/**
		
			 * The interrupt value to interrupt the earliest currently playing instance with the same source that progressed the
			 * least distance in the audio track, if the maximum number of instances of the sound are already playing.
			 
	**/
	static var INTERRUPT_EARLY : String;
	/**
		
			 * The interrupt value to interrupt the currently playing instance with the same source that progressed the most
			 * distance in the audio track, if the maximum number of instances of the sound are already playing.
			 
	**/
	static var INTERRUPT_LATE : String;
	/**
		
			 * The interrupt value to not interrupt any currently playing instances with the same source, if the maximum number of
			 * instances of the sound are already playing.
			 
	**/
	static var INTERRUPT_NONE : String;
	/**
		
			 * Defines the playState of an instance that is still initializing.
			 
	**/
	static var PLAY_INITED : String;
	/**
		
			 * Defines the playState of an instance that is currently playing or paused.
			 
	**/
	static var PLAY_SUCCEEDED : String;
	/**
		
			 * Defines the playState of an instance that was interrupted by another instance.
			 
	**/
	static var PLAY_INTERRUPTED : String;
	/**
		
			 * Defines the playState of an instance that completed playback.
			 
	**/
	static var PLAY_FINISHED : String;
	/**
		
			 * Defines the playState of an instance that failed to play. This is usually caused by a lack of available channels
			 * when the interrupt mode was "INTERRUPT_NONE", the playback stalled, or the sound could not be found.
			 
	**/
	static var PLAY_FAILED : String;
	/**
		
			 * A list of the default supported extensions that Sound will <i>try</i> to play. Plugins will check if the browser
			 * can play these types, so modifying this list before a plugin is initialized will allow the plugins to try to
			 * support additional media types.
			 * 
			 * NOTE this does not currently work for {{#crossLink "FlashAudioPlugin"}}{{/crossLink}}.
			 * 
			 * More details on file formats can be found at <a href="http://en.wikipedia.org/wiki/Audio_file_format" target="_blank">http://en.wikipedia.org/wiki/Audio_file_format</a>.<br />
			 * A very detailed list of file formats can be found at <a href="http://www.fileinfo.com/filetypes/audio" target="_blank">http://www.fileinfo.com/filetypes/audio</a>.
			 
	**/
	static var SUPPORTED_EXTENSIONS : Array<String>;
	/**
		
			 * Some extensions use another type of extension support to play (one of them is a codex).  This allows you to map
			 * that support so plugins can accurately determine if an extension is supported.  Adding to this list can help
			 * plugins determine more accurately if an extension is supported.
			 * 
			 * A useful list of extensions for each format can be found at <a href="http://html5doctor.com/html5-audio-the-state-of-play/" target="_blank">http://html5doctor.com/html5-audio-the-state-of-play/</a>.
			 
	**/
	static var EXTENSION_MAP : Dynamic;
	/**
		
			 * Determines the default behavior for interrupting other currently playing instances with the same source, if the
			 * maximum number of instances of the sound are already playing.  Currently the default is {{#crossLink "Sound/INTERRUPT_NONE:property"}}{{/crossLink}}
			 * but this can be set and will change playback behavior accordingly.  This is only used when {{#crossLink "Sound/play"}}{{/crossLink}}
			 * is called without passing a value for interrupt.
			 
	**/
	static var defaultInterruptBehavior : String;
	/**
		
			 * An array of extensions to attempt to use when loading sound, if the default is unsupported by the active plugin.
			 * These are applied in order, so if you try to Load Thunder.ogg in a browser that does not support ogg, and your
			 * extensions array is ["mp3", "m4a", "wav"] it will check mp3 support, then m4a, then wav. The audio files need
			 * to exist in the same location, as only the extension is altered.
			 * 
			 * Note that regardless of which file is loaded, you can call {{#crossLink "Sound/createInstance"}}{{/crossLink}}
			 * and {{#crossLink "Sound/play"}}{{/crossLink}} using the same id or full source path passed for loading.
			 * 
			 * <h4>Example</h4>
			 * 
			 * 	var sounds = [
			 * 		{src:"myPath/mySound.ogg", id:"example"},
			 * 	];
			 * 	createjs.Sound.alternateExtensions = ["mp3"]; // now if ogg is not supported, SoundJS will try asset0.mp3
			 * 	createjs.Sound.on("fileload", handleLoad); // call handleLoad when each sound loads
			 * 	createjs.Sound.registerSounds(sounds, assetPath);
			 * 	// ...
			 * 	createjs.Sound.play("myPath/mySound.ogg"); // works regardless of what extension is supported.  Note calling with ID is a better approach
			 
	**/
	static var alternateExtensions : Array<Dynamic>;
	/**
		
			 * The currently active plugin. If this is null, then no plugin could be initialized. If no plugin was specified,
			 * Sound attempts to apply the default plugins: {{#crossLink "WebAudioPlugin"}}{{/crossLink}}, followed by
			 * {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
			 
	**/
	static var activePlugin : Dynamic;
	/**
		
			 * Get the active plugins capabilities, which help determine if a plugin can be used in the current environment,
			 * or if the plugin supports a specific feature. Capabilities include:
			 * <ul>
			 *     <li><b>panning:</b> If the plugin can pan audio from left to right</li>
			 *     <li><b>volume;</b> If the plugin can control audio volume.</li>
			 *     <li><b>tracks:</b> The maximum number of audio tracks that can be played back at a time. This will be -1
			 *     if there is no known limit.</li>
			 * <br />An entry for each file type in {{#crossLink "Sound/SUPPORTED_EXTENSIONS:property"}}{{/crossLink}}:
			 *     <li><b>mp3:</b> If MP3 audio is supported.</li>
			 *     <li><b>ogg:</b> If OGG audio is supported.</li>
			 *     <li><b>wav:</b> If WAV audio is supported.</li>
			 *     <li><b>mpeg:</b> If MPEG audio is supported.</li>
			 *     <li><b>m4a:</b> If M4A audio is supported.</li>
			 *     <li><b>mp4:</b> If MP4 audio is supported.</li>
			 *     <li><b>aiff:</b> If aiff audio is supported.</li>
			 *     <li><b>wma:</b> If wma audio is supported.</li>
			 *     <li><b>mid:</b> If mid audio is supported.</li>
			 * </ul>
			 * 
			 * You can get a specific capability of the active plugin using standard object notation
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var mp3 = createjs.Sound.capabilities.mp3;
			 * 
			 * Note this property is read only.
			 
	**/
	static var capabilities : Dynamic;
	/**
		
			 * Register a list of Sound plugins, in order of precedence. To register a single plugin, pass a single element in the array.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio/";
			 *      createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashAudioPlugin]);
			 
	**/
	static function registerPlugins(plugins:Array<Dynamic>):Bool;
	/**
		
			 * Initialize the default plugins. This method is automatically called when any audio is played or registered before
			 * the user has manually registered plugins, and enables Sound to work without manual plugin setup. Currently, the
			 * default plugins are {{#crossLink "WebAudioPlugin"}}{{/crossLink}} followed by {{#crossLink "HTMLAudioPlugin"}}{{/crossLink}}.
			 * 
			 * <h4>Example</h4>
			 * 
			 * 	if (!createjs.initializeDefaultPlugins()) { return; }
			 
	**/
	static function initializeDefaultPlugins():Bool;
	/**
		
			 * Determines if Sound has been initialized, and a plugin has been activated.
			 * 
			 * <h4>Example</h4>
			 * This example sets up a Flash fallback, but only if there is no plugin specified yet.
			 * 
			 * 	if (!createjs.Sound.isReady()) {
			 * 		createjs.FlashAudioPlugin.swfPath = "../src/soundjs/flashaudio/";
			 * 		createjs.Sound.registerPlugins([createjs.WebAudioPlugin, createjs.HTMLAudioPlugin, createjs.FlashAudioPlugin]);
			 * 	}
			 
	**/
	static function isReady():Bool;
	/**
		
			 * Register an audio file for loading and future playback in Sound. This is automatically called when using
			 * <a href="http://preloadjs.com" target="_blank">PreloadJS</a>.  It is recommended to register all sounds that
			 * need to be played back in order to properly prepare and preload them. Sound does internal preloading when required.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      createjs.Sound.alternateExtensions = ["mp3"];
			 *      createjs.Sound.on("fileload", handleLoad); // add an event listener for when load is completed
			 *      createjs.Sound.registerSound("myAudioPath/mySound.ogg", "myID", 3);
			 *      createjs.Sound.registerSound({ogg:"path1/mySound.ogg", mp3:"path2/mySoundNoExtension"}, "myID", 3);
			 
	**/
	static function registerSound(src:Dynamic, ?id:String, ?data:Dynamic, basePath:String, ?defaultPlayProps:Dynamic):Dynamic;
	/**
		
			 * Register an array of audio files for loading and future playback in Sound. It is recommended to register all
			 * sounds that need to be played back in order to properly prepare and preload them. Sound does internal preloading
			 * when required.
			 * 
			 * <h4>Example</h4>
			 * 
			 * 		var assetPath = "./myAudioPath/";
			 *      var sounds = [
			 *          {src:"asset0.ogg", id:"example"},
			 *          {src:"asset1.ogg", id:"1", data:6},
			 *          {src:"asset2.mp3", id:"works"}
			 *          {src:{mp3:"path1/asset3.mp3", ogg:"path2/asset3NoExtension"}, id:"better"}
			 *      ];
			 *      createjs.Sound.alternateExtensions = ["mp3"];	// if the passed extension is not supported, try this extension
			 *      createjs.Sound.on("fileload", handleLoad); // call handleLoad when each sound loads
			 *      createjs.Sound.registerSounds(sounds, assetPath);
			 
	**/
	static function registerSounds(sounds:Array<Dynamic>, basePath:String):Dynamic;
	/**
		
			 * Remove a sound that has been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
			 * {{#crossLink "Sound/registerSounds"}}{{/crossLink}}.
			 * <br />Note this will stop playback on active instances playing this sound before deleting them.
			 * <br />Note if you passed in a basePath, you need to pass it or prepend it to the src here.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      createjs.Sound.removeSound("myID");
			 *      createjs.Sound.removeSound("myAudioBasePath/mySound.ogg");
			 *      createjs.Sound.removeSound("myPath/myOtherSound.mp3", "myBasePath/");
			 *      createjs.Sound.removeSound({mp3:"musicNoExtension", ogg:"music.ogg"}, "myBasePath/");
			 
	**/
	static function removeSound(src:Dynamic, basePath:String):Bool;
	/**
		
			 * Remove an array of audio files that have been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
			 * {{#crossLink "Sound/registerSounds"}}{{/crossLink}}.
			 * <br />Note this will stop playback on active instances playing this audio before deleting them.
			 * <br />Note if you passed in a basePath, you need to pass it or prepend it to the src here.
			 * 
			 * <h4>Example</h4>
			 * 
			 * 		assetPath = "./myPath/";
			 *      var sounds = [
			 *          {src:"asset0.ogg", id:"example"},
			 *          {src:"asset1.ogg", id:"1", data:6},
			 *          {src:"asset2.mp3", id:"works"}
			 *      ];
			 *      createjs.Sound.removeSounds(sounds, assetPath);
			 
	**/
	static function removeSounds(sounds:Array<Dynamic>, basePath:String):Dynamic;
	/**
		
			 * Remove all sounds that have been registered with {{#crossLink "Sound/registerSound"}}{{/crossLink}} or
			 * {{#crossLink "Sound/registerSounds"}}{{/crossLink}}.
			 * <br />Note this will stop playback on all active sound instances before deleting them.
			 * 
			 * <h4>Example</h4>
			 * 
			 *     createjs.Sound.removeAllSounds();
			 
	**/
	static function removeAllSounds():Void;
	/**
		
			 * Check if a source has been loaded by internal preloaders. This is necessary to ensure that sounds that are
			 * not completed preloading will not kick off a new internal preload if they are played.
			 * 
			 * <h4>Example</h4>
			 * 
			 *     var mySound = "assetPath/asset0.ogg";
			 *     if(createjs.Sound.loadComplete(mySound) {
			 *         createjs.Sound.play(mySound);
			 *     }
			 
	**/
	static function loadComplete(src:String):Bool;
	/**
		
			 * Play a sound and get a {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} to control. If the sound fails to
			 * play, an AbstractSoundInstance will still be returned, and have a playState of {{#crossLink "Sound/PLAY_FAILED:property"}}{{/crossLink}}.
			 * Note that even on sounds with failed playback, you may still be able to call the {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}},
			 * method, since the failure could be due to lack of available channels. If the src does not have a supported
			 * extension or if there is no available plugin, a default AbstractSoundInstance will still be returned, which will
			 * not play any audio, but will not generate errors.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      createjs.Sound.on("fileload", handleLoad);
			 *      createjs.Sound.registerSound("myAudioPath/mySound.mp3", "myID", 3);
			 *      function handleLoad(event) {
			 *      	createjs.Sound.play("myID");
			 *      	// store off AbstractSoundInstance for controlling
			 *      	var myInstance = createjs.Sound.play("myID", {interrupt: createjs.Sound.INTERRUPT_ANY, loop:-1});
			 *      }
			 * 
			 * NOTE: To create an audio sprite that has not already been registered, both startTime and duration need to be set.
			 * This is only when creating a new audio sprite, not when playing using the id of an already registered audio sprite.
			 
	**/
	static function play(src:String, ?props:Dynamic):soundjs.AbstractSoundInstance;
	/**
		
			 * Creates a {{#crossLink "AbstractSoundInstance"}}{{/crossLink}} using the passed in src. If the src does not have a
			 * supported extension or if there is no available plugin, a default AbstractSoundInstance will be returned that can be
			 * called safely but does nothing.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      var myInstance = null;
			 *      createjs.Sound.on("fileload", handleLoad);
			 *      createjs.Sound.registerSound("myAudioPath/mySound.mp3", "myID", 3);
			 *      function handleLoad(event) {
			 *      	myInstance = createjs.Sound.createInstance("myID");
			 *      	// alternately we could call the following
			 *      	myInstance = createjs.Sound.createInstance("myAudioPath/mySound.mp3");
			 *      }
			 * 
			 * NOTE to create an audio sprite that has not already been registered, both startTime and duration need to be set.
			 * This is only when creating a new audio sprite, not when playing using the id of an already registered audio sprite.
			 
	**/
	static function createInstance(src:String, ?startTime:Float, ?duration:Float):soundjs.AbstractSoundInstance;
	/**
		
			 * Stop all audio (global stop). Stopped audio is reset, and not paused. To play audio that has been stopped,
			 * call AbstractSoundInstance {{#crossLink "AbstractSoundInstance/play"}}{{/crossLink}}.
			 * 
			 * <h4>Example</h4>
			 * 
			 *     createjs.Sound.stop();
			 
	**/
	static function stop():Void;
	/**
		
			 * Static initializer to mix EventDispatcher methods into a target object or prototype.
			 * 
			 * 		EventDispatcher.initialize(MyClass.prototype); // add to the prototype of the class
			 * 		EventDispatcher.initialize(myObject); // add to a specific instance
			 
	**/
	static function initialize(target:Dynamic):Void;
	/**
		
			 * Adds the specified event listener. Note that adding multiple listeners to the same function will result in
			 * multiple callbacks getting fired.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      displayObject.addEventListener("click", handleClick);
			 *      function handleClick(event) {
			 *         // Click happened.
			 *      }
			 
	**/
	static function addEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	/**
		
			 * A shortcut method for using addEventListener that makes it easier to specify an execution scope, have a listener
			 * only run once, associate arbitrary data with the listener, and remove the listener.
			 * 
			 * This method works by creating an anonymous wrapper function and subscribing it with addEventListener.
			 * The wrapper function is returned for use with `removeEventListener` (or `off`).
			 * 
			 * <b>IMPORTANT:</b> To remove a listener added with `on`, you must pass in the returned wrapper function as the listener, or use
			 * {{#crossLink "Event/remove"}}{{/crossLink}}. Likewise, each time you call `on` a NEW wrapper function is subscribed, so multiple calls
			 * to `on` with the same params will create multiple listeners.
			 * 
			 * <h4>Example</h4>
			 * 
			 * 		var listener = myBtn.on("click", handleClick, null, false, {count:3});
			 * 		function handleClick(evt, data) {
			 * 			data.count -= 1;
			 * 			console.log(this == myBtn); // true - scope defaults to the dispatcher
			 * 			if (data.count == 0) {
			 * 				alert("clicked 3 times!");
			 * 				myBtn.off("click", listener);
			 * 				// alternately: evt.remove();
			 * 			}
			 * 		}
			 
	**/
	static function on(type:String, listener:Dynamic, ?scope:Dynamic, ?once:Bool, ?data:Dynamic, ?useCapture:Bool):Dynamic;
	/**
		
			 * Removes the specified event listener.
			 * 
			 * <b>Important Note:</b> that you must pass the exact function reference used when the event was added. If a proxy
			 * function, or function closure is used as the callback, the proxy/closure reference must be used - a new proxy or
			 * closure will not work.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      displayObject.removeEventListener("click", handleClick);
			 
	**/
	static function removeEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Void;
	/**
		
			 * A shortcut to the removeEventListener method, with the same parameters and return value. This is a companion to the
			 * .on method.
			 * 
			 * <b>IMPORTANT:</b> To remove a listener added with `on`, you must pass in the returned wrapper function as the listener. See 
			 * {{#crossLink "EventDispatcher/on"}}{{/crossLink}} for an example.
			 
	**/
	static function off(type:String, listener:Dynamic, ?useCapture:Bool):Void;
	/**
		
			 * Removes all listeners for the specified type, or all listeners of all types.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      // Remove all listeners
			 *      displayObject.removeAllEventListeners();
			 * 
			 *      // Remove all click listeners
			 *      displayObject.removeAllEventListeners("click");
			 
	**/
	static function removeAllEventListeners(?type:String):Void;
	/**
		
			 * Dispatches the specified event to all listeners.
			 * 
			 * <h4>Example</h4>
			 * 
			 *      // Use a string event
			 *      this.dispatchEvent("complete");
			 * 
			 *      // Use an Event instance
			 *      var event = new createjs.Event("progress");
			 *      this.dispatchEvent(event);
			 
	**/
	static function dispatchEvent(eventObj:Dynamic, ?bubbles:Bool, ?cancelable:Bool):Bool;
	/**
		
			 * Indicates whether there is at least one listener for the specified event type.
			 
	**/
	static function hasEventListener(type:String):Bool;
	/**
		
			 * Indicates whether there is at least one listener for the specified event type on this object or any of its
			 * ancestors (parent, parent's parent, etc). A return value of true indicates that if a bubbling event of the
			 * specified type is dispatched from this object, it will trigger at least one listener.
			 * 
			 * This is similar to {{#crossLink "EventDispatcher/hasEventListener"}}{{/crossLink}}, but it searches the entire
			 * event flow for a listener, not just this object.
			 
	**/
	static function willTrigger(type:String):Bool;
}
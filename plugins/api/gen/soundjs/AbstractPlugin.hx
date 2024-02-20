package soundjs;

/**
 * A default plugin class used as a base for all other plugins.
 */
/**
	
	 * A default plugin class used as a base for all other plugins.
	 
**/
@:native('createjs.AbstractPlugin') extern class AbstractPlugin {
	function new():Void;
	/**
		
			 * Pre-register a sound for preloading and setup. This is called by {{#crossLink "Sound"}}{{/crossLink}}.
			 * Note all plugins provide a <code>Loader</code> instance, which <a href="http://preloadjs.com" target="_blank">PreloadJS</a>
			 * can use to assist with preloading.
			 
	**/
	function register(loadItem:String):Dynamic;
	/**
		
			 * Internally preload a sound.
			 
	**/
	function preload(loader:preloadjs.loaders.AbstractLoader):Void;
	/**
		
			 * Checks if preloading has started for a specific source. If the source is found, we can assume it is loading,
			 * or has already finished loading.
			 
	**/
	function isPreloadStarted(src:String):Bool;
	/**
		
			 * Checks if preloading has finished for a specific source.
			 
	**/
	function isPreloadComplete(src:String):Bool;
	/**
		
			 * Remove a sound added using {{#crossLink "WebAudioPlugin/register"}}{{/crossLink}}. Note this does not cancel a preload.
			 
	**/
	function removeSound(src:String):Void;
	/**
		
			 * Remove all sounds added using {{#crossLink "WebAudioPlugin/register"}}{{/crossLink}}. Note this does not cancel a preload.
			 
	**/
	function removeAllSounds(src:String):Void;
	/**
		
			 * Create a sound instance. If the sound has not been preloaded, it is internally preloaded here.
			 
	**/
	function create(src:String, startTime:Float, duration:Float):soundjs.AbstractSoundInstance;
	/**
		
			 * Set the master volume of the plugin, which affects all SoundInstances.
			 
	**/
	function setVolume(value:Float):Bool;
	/**
		
			 * Get the master volume of the plugin, which affects all SoundInstances.
			 
	**/
	function getVolume():Float;
	/**
		
			 * Mute all sounds via the plugin.
			 
	**/
	function setMute(value:Bool):Bool;
	/**
		
			 * Determine if the plugin can be used in the current browser/OS.
			 
	**/
	static function isSupported():Bool;
}
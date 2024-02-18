package preloadjs.utils;

/**
 * Convenience methods for creating various elements used by PrelaodJS.
 */
/**
	
	 * Convenience methods for creating various elements used by PrelaodJS.
	 
**/
@:native('createjs.DomUtils') extern class DomUtils {
	/**
		
			 * Check if item is a valid HTMLImageElement
			 
	**/
	static function isImageTag(item:Dynamic):Bool;
	/**
		
			 * Check if item is a valid HTMLAudioElement
			 
	**/
	static function isAudioTag(item:Dynamic):Bool;
	/**
		
			 * Check if item is a valid HTMLVideoElement
			 
	**/
	static function isVideoTag(item:Dynamic):Bool;
}
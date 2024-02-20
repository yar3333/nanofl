package soundjs.htmlaudio;

/**
 * HTMLAudioTagPool is an object pool for HTMLAudio tag instances.
 */
/**
	
	 * HTMLAudioTagPool is an object pool for HTMLAudio tag instances.
	 
**/
@:native('createjs.HTMLAudioTagPool') extern class HTMLAudioTagPool {
	/**
		
			 * Get an audio tag with the given source.
			 
	**/
	static function get(src:String):Void;
	/**
		
			 * Return an audio tag to the pool.
			 
	**/
	static function set(src:String, tag:js.html.Element):Void;
	/**
		
			 * Delete stored tag reference and return them to pool. Note that if the tag reference does not exist, this will fail.
			 
	**/
	static function remove(src:String):Bool;
	/**
		
			 * Gets the duration of the src audio in milliseconds
			 
	**/
	static function getDuration(src:String):Float;
}
package preloadjs.loaders;

/**
 * A loader for video files.
 */
/**
	
	 * A loader for video files.
	 
**/
@:native('createjs.VideoLoader') extern class VideoLoader extends preloadjs.loaders.AbstractMediaLoader {
	function new(loadItem:Dynamic, preferXHR:Bool):Void;
	/**
		
			 * Determines if the loader can load a specific item. This loader can only load items that are of type
			 * {{#crossLink "Types/VIDEO:property"}}{{/crossLink}}.
			 
	**/
	static function canLoadItem(item:Dynamic):Bool;
}
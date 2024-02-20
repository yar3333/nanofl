package preloadjs.loaders;

/**
 * A loader for JavaScript files.
 */
/**
	
	 * A loader for JavaScript files.
	 
**/
@:native('createjs.JavaScriptLoader') extern class JavaScriptLoader extends preloadjs.loaders.AbstractLoader {
	function new(loadItem:Dynamic, preferXHR:Bool):Void;
	/**
		
			 * Determines if the loader can load a specific item. This loader can only load items that are of type
			 * {{#crossLink "Types/JAVASCRIPT:property"}}{{/crossLink}}
			 
	**/
	static function canLoadItem(item:Dynamic):Bool;
}
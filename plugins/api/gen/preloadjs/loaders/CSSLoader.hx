package preloadjs.loaders;

/**
 * A loader for CSS files.
 */
/**
	
	 * A loader for CSS files.
	 
**/
@:native('createjs.CSSLoader') extern class CSSLoader extends preloadjs.loaders.AbstractLoader {
	function new(loadItem:Dynamic, preferXHR:Bool):Void;
	/**
		
			 * Determines if the loader can load a specific item. This loader can only load items that are of type
			 * {{#crossLink "Types/CSS:property"}}{{/crossLink}}.
			 
	**/
	static function canLoadItem(item:Dynamic):Bool;
}
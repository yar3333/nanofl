package preloadjs.loaders;

/**
 * A loader for CSS files.
 */
/**
	
	 * A loader for CSS files.
	 
**/
@:native('createjs.XMLLoader') extern class XMLLoader extends preloadjs.loaders.AbstractLoader {
	function new(loadItem:Dynamic):Void;
	/**
		
			 * Determines if the loader can load a specific item. This loader can only load items that are of type
			 * {{#crossLink "Types/XML:property"}}{{/crossLink}}.
			 
	**/
	static function canLoadItem(item:Dynamic):Bool;
}
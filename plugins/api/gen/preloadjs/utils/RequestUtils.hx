package preloadjs.utils;

/**
 * Utilities that assist with parsing load items, and determining file types, etc.
 */
/**
	
	 * Utilities that assist with parsing load items, and determining file types, etc.
	 
**/
@:native('createjs.RequestUtils') extern class RequestUtils {
	/**
		
			 * Determine if a specific type should be loaded as a binary file. Currently, only images and items marked
			 * specifically as "binary" are loaded as binary. Note that audio is <b>not</b> a binary type, as we can not play
			 * back using an audio tag if it is loaded as binary. Plugins can change the item type to binary to ensure they get
			 * a binary result to work with. Binary files are loaded using XHR2. Types are defined as static constants on
			 * {{#crossLink "AbstractLoader"}}{{/crossLink}}.
			 
	**/
	static function isBinary(type:String):Bool;
	/**
		
			 * Determine if a specific type is a text-based asset, and should be loaded as UTF-8.
			 
	**/
	static function isText(type:String):Bool;
	/**
		
			 * Determine the type of the object using common extensions. Note that the type can be passed in with the load item
			 * if it is an unusual extension.
			 
	**/
	static function getTypeByExtension(extension:String):String;
}
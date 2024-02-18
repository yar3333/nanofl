package preloadjs.loaders;

/**
 * A loader for binary files. This is useful for loading web audio, or content that requires an ArrayBuffer.
 */
/**
	
	 * A loader for binary files. This is useful for loading web audio, or content that requires an ArrayBuffer.
	 
**/
@:native('createjs.BinaryLoader') extern class BinaryLoader extends preloadjs.loaders.AbstractLoader {
	function new(loadItem:Dynamic):Void;
	/**
		
			 * Determines if the loader can load a specific item. This loader can only load items that are of type
			 * {{#crossLink "Types/BINARY:property"}}{{/crossLink}}
			 
	**/
	static function canLoadItem(item:Dynamic):Bool;
}
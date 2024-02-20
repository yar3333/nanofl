package preloadjs.utils;

/**
 * A few data utilities for formatting different data types.
 */
/**
	
	 * A few data utilities for formatting different data types.
	 
**/
@:native('createjs.DataUtils') extern class DataUtils {
	/**
		
			 * Parse a string into an Object.
			 
	**/
	function parseJSON(value:String):Dynamic;
	/**
		
			 * Parse XML using the DOM. This is required when preloading XML or SVG.
			 
	**/
	static function parseXML(text:String):js.html.Document;
}
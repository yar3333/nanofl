package preloadjs.utils;

/**
 * Utilities that assist with parsing load items, and determining file types, etc.
 */
/**
	
	 * Utilities that assist with parsing load items, and determining file types, etc.
	 
**/
@:native('createjs.URLUtils') extern class URLUtils {
	/**
		
			 * The Regular Expression used to test file URLS for an absolute path.
			 
	**/
	static var ABSOLUTE_PATH : Dynamic;
	/**
		
			 * The Regular Expression used to test file URLS for a relative path.
			 
	**/
	static var RELATIVE_PATH : Dynamic;
	/**
		
			 * The Regular Expression used to test file URLS for an extension. Note that URIs must already have the query string
			 * removed.
			 
	**/
	static var EXTENSION_PATT : Dynamic;
	/**
		
			 * Parse a file path to determine the information we need to work with it. Currently, PreloadJS needs to know:
			 * <ul>
			 *     <li>If the path is absolute. Absolute paths start with a protocol (such as `http://`, `file://`, or
			 *     `//networkPath`)</li>
			 *     <li>If the path is relative. Relative paths start with `../` or `/path` (or similar)</li>
			 *     <li>The file extension. This is determined by the filename with an extension. Query strings are dropped, and
			 *     the file path is expected to follow the format `name.ext`.</li>
			 * </ul>
			 
	**/
	static function parseURI(path:String):Dynamic;
	/**
		
			 * Formats an object into a query string for either a POST or GET request.
			 
	**/
	static function formatQueryString(data:Dynamic, ?query:Array<Dynamic>):Void;
	/**
		
			 * A utility method that builds a file path using a source and a data object, and formats it into a new path.
			 
	**/
	static function buildURI(src:String, ?data:Dynamic):String;
	static function isCrossDomain(item:Dynamic):Bool;
	static function isLocal(item:Dynamic):Bool;
}
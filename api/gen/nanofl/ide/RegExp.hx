package nanofl.ide;

/**
 * Use "using" in your code to mix static methods into String.
 */
/**
	
	 * Use "using" in your code to mix static methods into String.
	 
**/
@:native("RegExp") extern class RegExp {
	function new(pattern:String, flags:String):Void;
	var global(default, null) : Bool;
	var ignoreCase(default, null) : Bool;
	var lastIndex(default, null) : Int;
	var multiline(default, null) : Bool;
	var source(default, null) : String;
	function exec(s:String):Array<Dynamic>;
	function test(s:String):Bool;
}
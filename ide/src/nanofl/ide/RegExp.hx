package nanofl.ide;

/**
 * Use "using" in your code to mix static methods into String.
 */
@:native("RegExp")
extern class RegExp
{
	var global (default,null) : Bool;
	var ignoreCase (default,null) : Bool;
	var lastIndex (default,null) : Int;
	var multiline (default,null) : Bool;
	var source (default,null) : String;
	
	function new(pattern:String, flags:String) : Void;
	function exec(s:String) : Array<Dynamic>;
	function test(s:String) : Bool;
	
	static inline function match(s:String, re:RegExp) : Array<Dynamic> return (cast s).match(re);
	static inline function search(s:String, re:RegExp) : Array<Dynamic> return (cast s).search(re);
	static inline function replaceRE(s:String, re:RegExp, by:String) : Array<Dynamic> return (cast s).replace(re, by);
	static inline function splitRE(s:String, re:RegExp) : Array<Dynamic> return (cast s).split(re);
}
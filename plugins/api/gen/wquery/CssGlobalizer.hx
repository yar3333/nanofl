package wquery;

extern class CssGlobalizer {
	function new(klassName:String):Void;
	var prefix : String;
	function className(name:String):String;
	function selector(selector:String):String;
	function styles(text:String):String;
	function doc(baseNode:js.html.Element):Void;
	function fixJq(jq:js.JQuery):js.JQuery;
}
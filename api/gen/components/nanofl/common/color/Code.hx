package components.nanofl.common.color;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var cssClass : String;
	var display : Bool;
	var showAlpha : Bool;
	@:isVar
	var value(get, set) : String;
	private function get_value():String;
	private function set_value(v:String):String;
	var allowEmpty(get, set) : Bool;
	private function get_allowEmpty():Bool;
	private function set_allowEmpty(v:Bool):Bool;
	var visibility(get, set) : Bool;
	private function get_visibility():Bool;
	private function set_visibility(v:Bool):Bool;
	var panel(get, never) : js.JQuery;
	private function get_panel():js.JQuery;
	function showPanel():Void;
	function hidePanel():Void;
	function show():Void;
	function hide():Void;
}
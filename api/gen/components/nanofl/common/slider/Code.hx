package components.nanofl.common.slider;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var min : Float;
	var max : Float;
	var step : Float;
	var correction : Float;
	var exponentially : Bool;
	var value(get, set) : Float;
	private function get_value():Float;
	private function set_value(v:Float):Float;
	function show():Void;
	function hide():Void;
	function toggle(b:Bool):Void;
}
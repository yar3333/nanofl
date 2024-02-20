package components.nanofl.others.gradientselector;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function getItems():Array<{ public var ratio(default, default) : Float; public var color(default, default) : String; }>;
	function get():{ var colors : Array<String>; var ratios : Array<Float>; };
	function set(colors:Array<String>, ratios:Array<Float>):Void;
	function show():Void;
	function hide():Void;
}
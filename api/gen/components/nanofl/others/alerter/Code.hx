package components.nanofl.others.alerter;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function info(text:String, ?duration:Int):Void;
	function warning(text:String, ?duration:Int):Void;
	function error(text:String, ?duration:Int):Void;
	function reset():Void;
}
package components.nanofl.others.fpsmeter;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var editorUpdateCounter : Int;
	var editorUpdateTime : Float;
	function enable():Void;
}
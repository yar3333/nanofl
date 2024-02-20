package components.nanofl.others.statusbar;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var text(get, set) : String;
	private function get_text():String;
	private function set_text(text:String):String;
	function height():Int;
}
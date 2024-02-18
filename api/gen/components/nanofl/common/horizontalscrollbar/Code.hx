package components.nanofl.common.horizontalscrollbar;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var position(get, set) : Int;
	var size(get, set) : Int;
	private function get_position():Int;
	private function set_position(p:Int):Int;
	private function get_size():Int;
	private function set_size(v:Int):Int;
}
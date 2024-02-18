package components.nanofl.movie.timelinelayer;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var selected(get, never) : Bool;
	private function get_selected():Bool;
	var event_iconClick : wquery.Event<js.JQuery.JqEvent>;
	var event_titleClick : wquery.Event<js.JQuery.JqEvent>;
	var event_editedClick : wquery.Event<js.JQuery.JqEvent>;
	var event_visibleClick : wquery.Event<js.JQuery.JqEvent>;
	var event_lockedClick : wquery.Event<js.JQuery.JqEvent>;
	function beginEditTitle():Void;
}
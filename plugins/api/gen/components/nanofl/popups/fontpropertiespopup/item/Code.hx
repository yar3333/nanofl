package components.nanofl.popups.fontpropertiespopup.item;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var event_removeVariant : wquery.Event<js.JQuery.JqEvent>;
	override function remove():Void;
}
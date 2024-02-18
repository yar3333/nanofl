package components.nanofl.popups.fontpropertiespopup;

extern class Code extends components.nanofl.popups.basepopup.Code {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function show(?font:nanofl.engine.libraryitems.FontItem):Void;
}
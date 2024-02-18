package components.nanofl.popups.preferencespopup;

extern class Code extends components.nanofl.popups.tabbablepopup.Code {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	override function show(?callb:() -> Void):Void;
}
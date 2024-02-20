package components.nanofl.popups.promptpopup;

extern class Code extends components.nanofl.popups.basepopup.Code {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function show(title:String, label:String, ?text:String, success:String -> Void):Void;
}
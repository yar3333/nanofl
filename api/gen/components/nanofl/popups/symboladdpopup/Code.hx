package components.nanofl.popups.symboladdpopup;

extern class Code extends components.nanofl.popups.basepopup.Code {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function show(title:String, name:String, success:({ public var regY(default, default) : Int; public var regX(default, default) : Int; public var name(default, default) : String; }) -> Void):Void;
}
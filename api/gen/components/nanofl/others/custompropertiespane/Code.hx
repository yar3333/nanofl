package components.nanofl.others.custompropertiespane;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	var properties : Array<nanofl.engine.CustomProperty>;
	var params : Dynamic;
	function bind(properties:Array<nanofl.engine.CustomProperty>, params:Dynamic):Void;
	function clear():Void;
}
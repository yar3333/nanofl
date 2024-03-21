package components.nanofl.popups.exportprogresspopup;

extern class Code extends components.nanofl.popups.basepopup.Code {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function show(outputFile:String, cancelFunc:() -> Void):Void;
	function close():Void;
	function setPercent(percent:Int):Void;
	function setInfo(text:String):Void;
}
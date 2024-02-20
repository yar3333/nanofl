package components.nanofl.others.output;

extern class Code extends wquery.Component implements nanofl.ide.ui.views.IOutputView {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function writeInfo(message:String):Void;
	function writeError(message:String):Void;
	function writeWarning(message:String):Void;
	function writeCompileError(file:String, line:Int, startCh:Int, endCh:Int, message:String):Void;
	function clear():Void;
	function show():Void;
	function hide():Void;
	function activate():Void;
	function resize(maxWidth:Int, maxHeight:Int):Void;
	function on(event:String, callb:js.JQuery.JqEvent -> Void):Void;
	function hasSelected():Bool;
	function getSelectedText():String;
}
package components.nanofl.others.properties;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function update(?rightNow:Bool):Void;
	function resize(maxWidth:Int, maxHeight:Int):Void;
	function show():Void;
	function hide():Void;
	function on(event:String, callb:js.JQuery.JqEvent -> Void):Void;
	function activate():Void;
}
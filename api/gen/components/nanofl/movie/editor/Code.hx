package components.nanofl.movie.editor;

extern class Code extends wquery.Component {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function updateToolControls():Void;
	function resize(maxWidth:Int, maxHeight:Int):Void;
	function on(event:String, callb:js.JQuery.JqEvent -> Void):Void;
	function getMousePosOnDisplayObject(e:js.JQuery.JqEvent):nanofl.engine.geom.Point;
	function show():Void;
	function hide():Void;
}
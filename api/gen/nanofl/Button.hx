package nanofl;

extern class Button extends nanofl.MovieClip {
	function new(symbol:nanofl.engine.libraryitems.MovieClipItem):Void;
	override function onMouseDown(e:easeljs.events.MouseEvent):Void;
	override function onMouseMove(e:easeljs.events.MouseEvent):Void;
	override function onMouseUp(e:easeljs.events.MouseEvent):Void;
}
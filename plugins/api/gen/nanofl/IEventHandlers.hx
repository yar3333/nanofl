package nanofl;

interface IEventHandlers {
	function onEnterFrame():Void;
	function onMouseDown(e:easeljs.events.MouseEvent):Void;
	function onMouseMove(e:easeljs.events.MouseEvent):Void;
	function onMouseUp(e:easeljs.events.MouseEvent):Void;
}
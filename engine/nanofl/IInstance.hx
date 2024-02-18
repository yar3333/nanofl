package nanofl;

import easeljs.events.MouseEvent;

interface IInstance
{
	function onEnterFrame() : Void;
	function onMouseDown(e:MouseEvent) : Void;
	function onMouseMove(e:MouseEvent) : Void;
	function onMouseUp(e:MouseEvent) : Void;
}
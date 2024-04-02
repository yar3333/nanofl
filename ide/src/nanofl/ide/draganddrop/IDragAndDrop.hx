package nanofl.ide.draganddrop;

import js.JQuery;
import js.html.File;

interface IDragAndDrop
{
	/**
	 * Specify selector if you want to delegate from parent element specified by `elem`. In other case, set `selector` to null.
	 * If you use selector, then you must manualy add `draggable="true"` attribute to the draggable elements.
	 */
	function draggable(elem:JQuery, selector:String, getInfo:(e:JqEvent)->DragInfo, ?removeMoved:DragInfo->Void) : Void;
	
	function droppable(elem:JQuery, ?selector:String, getDragImageType:(type:DragDataType, params:DragInfoParams)->DragImageType, processDropData:(type:DragDataType, params:DragInfoParams, data:String, e:JqEvent)->Bool, ?processDropFiles:Array<File>->JqEvent->Void) : Void;
}

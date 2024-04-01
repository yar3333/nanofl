package nanofl.ide.draganddrop;

import js.JQuery;

interface IDropProcessor
{
	function getDragImageType(type:DragDataType, params:DragInfoParams) : DragImageType;
    function processDrop(type:DragDataType, params:DragInfoParams, data:String, e:JqEvent) : Bool;
}
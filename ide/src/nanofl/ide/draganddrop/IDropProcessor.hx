package nanofl.ide.draganddrop;

import js.JQuery;

interface IDropProcessor
{
	function getDragImageType(type:String, params:Dynamic) : DragImageType;
    function processDrop(type:String, params:Dynamic, data:String, e:JqEvent) : Bool;
}
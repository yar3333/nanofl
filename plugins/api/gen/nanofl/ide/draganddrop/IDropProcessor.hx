package nanofl.ide.draganddrop;

interface IDropProcessor {
	function getDragImageType(type:String, params:Dynamic):nanofl.ide.draganddrop.DragImageType;
	function processDrop(type:String, params:Dynamic, data:String, e:js.JQuery.JqEvent):Bool;
}
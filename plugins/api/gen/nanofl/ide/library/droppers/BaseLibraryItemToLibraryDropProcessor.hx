package nanofl.ide.library.droppers;

extern class BaseLibraryItemToLibraryDropProcessor extends nanofl.ide.InjectContainer implements nanofl.ide.draganddrop.IDropProcessor {
	function new():Void;
	function getDragImageType(type:String, params:Dynamic):nanofl.ide.draganddrop.DragImageType;
	function processDrop(type:String, params:Dynamic, data:String, e:js.JQuery.JqEvent):Bool;
}
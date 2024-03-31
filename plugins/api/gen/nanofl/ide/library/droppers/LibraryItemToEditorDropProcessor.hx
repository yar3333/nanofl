package nanofl.ide.library.droppers;

extern class LibraryItemToEditorDropProcessor extends nanofl.ide.InjectContainer implements nanofl.ide.draganddrop.IDropProcessor {
	function new():Void;
	function getDragImageType(type:String, params:Dynamic):nanofl.ide.draganddrop.DragImageType;
	function processDrop(type:String, params:Dynamic, data:String, e:js.JQuery.JqEvent):Bool;
	static function processItem(app:nanofl.ide.Application, view:nanofl.ide.ui.View, item:nanofl.ide.libraryitems.IIdeLibraryItem, e:js.JQuery.JqEvent):Void;
}
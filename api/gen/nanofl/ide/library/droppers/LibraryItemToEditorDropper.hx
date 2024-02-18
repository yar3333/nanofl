package nanofl.ide.library.droppers;

extern class LibraryItemToEditorDropper extends nanofl.ide.InjectContainer implements nanofl.ide.draganddrop.IDropArea {
	function new():Void;
	function getDragImageType(data:htmlparser.HtmlNodeElement):nanofl.ide.draganddrop.DragImageType;
	function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, e:js.JQuery.JqEvent):Void;
	static function processItem(app:nanofl.ide.Application, view:nanofl.ide.ui.View, item:nanofl.ide.libraryitems.IIdeLibraryItem, e:js.JQuery.JqEvent):Void;
}
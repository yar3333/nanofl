package nanofl.ide.library.droppers;

extern class LibraryItemToLibraryDropper extends nanofl.ide.library.droppers.BaseLibraryItemToLibraryDropper implements nanofl.ide.draganddrop.IDropArea {
	function new(app:nanofl.ide.Application, items:components.nanofl.library.libraryitems.Code):Void;
	function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, e:js.JQuery.JqEvent):Void;
}
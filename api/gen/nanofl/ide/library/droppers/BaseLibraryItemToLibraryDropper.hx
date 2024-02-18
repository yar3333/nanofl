package nanofl.ide.library.droppers;

extern class BaseLibraryItemToLibraryDropper {
	function new(app:nanofl.ide.Application, items:components.nanofl.library.libraryitems.Code):Void;
	function getDragImageType(data:htmlparser.HtmlNodeElement):nanofl.ide.draganddrop.DragImageType;
}
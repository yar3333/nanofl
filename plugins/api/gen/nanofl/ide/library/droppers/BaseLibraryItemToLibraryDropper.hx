package nanofl.ide.library.droppers;

extern class BaseLibraryItemToLibraryDropper extends nanofl.ide.InjectContainer {
	function new():Void;
	function getDragImageType(data:htmlparser.HtmlNodeElement):nanofl.ide.draganddrop.DragImageType;
}
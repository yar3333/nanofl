package nanofl.ide.library;

extern class LibraryDragAndDropTools {
	static function getDragParams(document:nanofl.ide.Document, item:nanofl.ide.libraryitems.IIdeLibraryItem, items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>):nanofl.ide.draganddrop.DragInfoParams;
	static function getDragData(document:nanofl.ide.Document, item:nanofl.ide.libraryitems.IIdeLibraryItem, items:Array<nanofl.ide.libraryitems.IIdeLibraryItem>):String;
	static function getDragImageTypeIconText(view:nanofl.ide.ui.View, type:nanofl.ide.draganddrop.DragDataType, params:nanofl.ide.draganddrop.DragInfoParams):nanofl.ide.draganddrop.DragImageType;
	static function getDragImageTypeRectangle(document:nanofl.ide.Document, type:nanofl.ide.draganddrop.DragDataType, params:nanofl.ide.draganddrop.DragInfoParams):nanofl.ide.draganddrop.DragImageType;
	static function dropToLibraryItemsFolder(document:nanofl.ide.Document, view:nanofl.ide.ui.View, dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.XmlDocument, folder:String):Void;
	static function dropItemsIntoFolderInner(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, document:nanofl.ide.Document, folder:String):js.lib.Promise<Array<nanofl.ide.libraryitems.IIdeLibraryItem>>;
	static function addLibraryItemIntoEditor(app:nanofl.ide.Application, view:nanofl.ide.ui.View, item:nanofl.ide.libraryitems.IIdeLibraryItem, e:js.JQuery.JqEvent):Void;
	static function getTargetFolderForDrop(document:nanofl.ide.Document, namePath:String):String;
}
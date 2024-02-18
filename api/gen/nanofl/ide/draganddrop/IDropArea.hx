package nanofl.ide.draganddrop;

interface IDropArea {
	function getDragImageType(data:htmlparser.HtmlNodeElement):nanofl.ide.draganddrop.DragImageType;
	function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, e:js.JQuery.JqEvent):Void;
}
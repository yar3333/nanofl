package nanofl.ide.draganddrop;

import htmlparser.HtmlNodeElement;
import js.JQuery.JqEvent;

interface IDropArea
{
	function getDragImageType(data:HtmlNodeElement) : DragImageType;
	function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent) : Void;
}
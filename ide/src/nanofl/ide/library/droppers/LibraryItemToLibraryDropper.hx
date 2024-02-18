package nanofl.ide.library.droppers;

import htmlparser.HtmlNodeElement;
import js.JQuery.JqEvent;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDropArea;

class LibraryItemToLibraryDropper extends BaseLibraryItemToLibraryDropper implements IDropArea
{
	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent)
	{
		if (items.readOnly) return;
		
		dropToLibraryItemsFolder(dropEffect, data, "");
	}
}
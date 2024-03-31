package nanofl.ide.library.droppers;

import js.JQuery;
import htmlparser.XmlDocument;
import nanofl.ide.draganddrop.DropEffect;

class LibraryItemToLibraryDropper extends BaseLibraryItemToLibraryDropper
{
	function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent) : Void
	{
		dropToLibraryItemsFolder(dropEffect, data, "");
	}
}
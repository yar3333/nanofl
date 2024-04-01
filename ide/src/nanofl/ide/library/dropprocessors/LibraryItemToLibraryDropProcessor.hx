package nanofl.ide.library.dropprocessors;

import js.JQuery;
import htmlparser.XmlDocument;
import nanofl.ide.draganddrop.DropEffect;

class LibraryItemToLibraryDropProcessor extends BaseLibraryItemToLibraryDropProcessor
{
	function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent) : Void
	{
		dropToLibraryItemsFolder(dropEffect, data, "");
	}
}
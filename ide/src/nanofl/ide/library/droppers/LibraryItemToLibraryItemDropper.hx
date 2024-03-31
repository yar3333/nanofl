package nanofl.ide.library.droppers;

import haxe.io.Path;
import htmlparser.XmlDocument;
import js.JQuery;
import nanofl.engine.libraryitems.FolderItem;
import nanofl.ide.Application;
import nanofl.ide.draganddrop.DropEffect;
using stdlib.Lambda;

class LibraryItemToLibraryItemDropper extends BaseLibraryItemToLibraryDropper
{
	function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent) : Void
	{
		dropToLibraryItemsFolder(dropEffect, data, getTargetFolderForDrop(app, e));
	}
	
	public static function getTargetFolderForDrop(app:Application, e:JqEvent) : String
	{
		var folder = e.currentTarget.getAttribute("data-name-path");
		if (folder == null) folder = "";
		if (folder != "" && !Std.isOfType(app.document.library.getItem(folder), FolderItem))
		{
			folder = Path.directory(folder);
		}
		return folder;
	}
}
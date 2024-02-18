package nanofl.ide.library.droppers;

import haxe.io.Path;
import htmlparser.HtmlNodeElement;
import js.JQuery.JqEvent;
import nanofl.engine.libraryitems.FolderItem;
import nanofl.ide.Application;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDropArea;
using stdlib.Lambda;

class LibraryItemToLibraryItemDropper extends BaseLibraryItemToLibraryDropper implements IDropArea
{
	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent)
	{
		if (items.readOnly) return;
		
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
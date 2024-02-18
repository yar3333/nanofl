package nanofl.ide.library.droppers;

import htmlparser.HtmlNodeElement;
import nanofl.ide.libraryitems.IIdeLibraryItem;
import nanofl.ide.Application;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.library.LibraryItems;
import stdlib.Debug;
using stdlib.Lambda;

class BaseLibraryItemToLibraryDropper
{
	var app : Application;
	var items : components.nanofl.library.libraryitems.Code;
	
	public function new(app:Application, items:components.nanofl.library.libraryitems.Code)
	{
		this.app = app;
		this.items = items;
	}
	
	public function getDragImageType(data:HtmlNodeElement) : DragImageType
	{
		if (items.readOnly) return null;
		return DragImageType.ICON_TEXT(data.getAttribute("icon"), data.getAttribute("text")); // or namePath
	}
	
	function dropToLibraryItemsFolder(dropEffect:DropEffect, data:HtmlNodeElement, folder:String)
	{
		Debug.assert(folder != null);
		
		var saveActiveNamePath = items.activeNamePath;
		items.activeNamePath = "";
		LibraryItems.drop(dropEffect, data, app.document, folder).then(function(droppedItems:Array<IIdeLibraryItem>)
		{
			if (droppedItems.length > 0)
			{
				items.select(droppedItems.map(x -> x.namePath));
				items.activeNamePath = data.getAttribute("namePath");
			}
			else
			{
				items.activeNamePath = saveActiveNamePath;
			}
			app.document.library.update();
		});
	}
}
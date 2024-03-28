package nanofl.ide.library.droppers;

import nanofl.ide.ui.View;
import htmlparser.HtmlNodeElement;
import nanofl.ide.Application;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.library.LibraryItems;
import stdlib.Debug;
using stdlib.Lambda;

@:rtti
class BaseLibraryItemToLibraryDropper extends InjectContainer
{
	@inject var app : Application;
	@inject var view : View;
	
	public function getDragImageType(data:HtmlNodeElement) : DragImageType
	{
		if (view.library.readOnly) return null;
		return DragImageType.ICON_TEXT(data.getAttribute("icon"), data.getAttribute("text")); // or namePath
	}
	
	function dropToLibraryItemsFolder(dropEffect:DropEffect, data:HtmlNodeElement, folder:String)
	{
		Debug.assert(folder != null);
		
		final saveActiveItem = view.library.activeItem;
		view.library.activeItem = null;
		LibraryItems.drop(dropEffect, data, app.document, folder).then(droppedItems ->
		{
			if (droppedItems.length > 0)
			{
				view.library.select(droppedItems.map(x -> x.namePath));
				view.library.activeItem = droppedItems[0];
			}
			else
			{
				view.library.activeItem = saveActiveItem;
			}
			view.library.update();
		});
	}
}
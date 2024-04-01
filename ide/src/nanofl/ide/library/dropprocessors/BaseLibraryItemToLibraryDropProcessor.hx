package nanofl.ide.library.dropprocessors;

import nanofl.ide.draganddrop.DragInfoParams;
import js.html.DragEvent;
import nanofl.ide.draganddrop.DragDataType;
import js.JQuery;
import htmlparser.XmlDocument;
import nanofl.ide.Application;
import nanofl.ide.draganddrop.IDropProcessor;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.library.LibraryItems;
import nanofl.ide.ui.View;
import stdlib.Debug;
using stdlib.Lambda;

@:rtti
abstract class BaseLibraryItemToLibraryDropProcessor extends InjectContainer
    implements IDropProcessor
{
	@inject var app : Application;
	@inject var view : View;
	
	public function getDragImageType(type:DragDataType, params:DragInfoParams) : DragImageType
	{
		if (type != DragDataType.LIBRARYITEMS || view.library.readOnly) return null;

		return DragImageType.ICON_TEXT(params.icon, params.text); // or namePath
	}

    final public function processDrop(type:DragDataType, params:DragInfoParams, data:String, e:JqEvent) : Bool
    {
        if (type != DragDataType.LIBRARYITEMS || view.library.readOnly) return false;
        
        processDropInner((cast e.originalEvent:DragEvent).dataTransfer.dropEffect, new XmlDocument(data), e);
        return true;
    }

    abstract function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent) : Void;
	
	function dropToLibraryItemsFolder(dropEffect:DropEffect, data:XmlDocument, folder:String)
	{
		Debug.assert(folder != null);
		
		final saveActiveItem = view.library.activeItem;
		view.library.activeItem = null;

        LibraryDragAndDropTools.dropItemsIntoFolder(dropEffect, data, app.document, folder).then(droppedItems ->
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
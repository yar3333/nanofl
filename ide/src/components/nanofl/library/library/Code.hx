package components.nanofl.library.library;

import js.html.DragEvent;
import js.html.File;
import htmlparser.XmlDocument;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.draganddrop.DragDataType;
import nanofl.ide.library.LibraryDragAndDropTools;
import nanofl.ide.ui.View;

@:rtti
class Code extends components.nanofl.library.libraryview.Code
{
	static var imports =
	{
		"context-menu": components.nanofl.common.contextmenu.Code,
		"library-toolbar": components.nanofl.library.librarytoolbar.Code
	};
	
	@inject var dragAndDrop : DragAndDrop;
	@inject var view : View;
	
	override function init()
	{
		super.init();
		
		dragAndDrop.ready.then(api ->
		{
			api.droppable
			(
				template().container,
                null,
                (type, params) -> LibraryDragAndDropTools.getDragImageTypeIconText(view, type, params),

                (type, params, data, e) ->
                {
                    if (type != DragDataType.LIBRARYITEMS || view.library.readOnly) return false;
                    
                    final dropEffect = (cast e.originalEvent:DragEvent).dataTransfer.dropEffect;                                        
                    LibraryDragAndDropTools.dropToLibraryItemsFolder(app.document, dropEffect, params, new XmlDocument(data), "");
                    return true;
                },
                
				(files:Array<File>, _) ->
				{
					app.document.library.addUploadedFiles(files, "");
				}
			);
		});
		
		template().contextMenu.build(template().centerContainer, preferences.storage.getMenu("libraryContextMenu"));
	}
	
	@:allow(nanofl.ide.editor.EditorLibrary.removeSelected)
	function removeSelected()
	{
		template().items.removeSelected();
	}
	
	@:allow(nanofl.ide.editor.EditorLibrary.renameByUser)
	function renameByUser(namePath:String) : Void
	{
		template().items.renameByUser(namePath);
	}
}
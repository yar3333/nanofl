package components.nanofl.library.library;

import js.html.File;
import nanofl.ide.draganddrop.DragAndDrop;
import nanofl.ide.library.droppers.LibraryItemToLibraryDropper;

@:rtti
class Code extends components.nanofl.library.libraryview.Code
{
	static var imports =
	{
		"context-menu": components.nanofl.common.contextmenu.Code,
		"library-toolbar": components.nanofl.library.librarytoolbar.Code
	};
	
	@inject var dragAndDrop : DragAndDrop;
	
	override function init()
	{
		super.init();
		
		dragAndDrop.ready.then(api ->
		{
			api.droppable
			(
				template().container,
				new LibraryItemToLibraryDropper(),
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
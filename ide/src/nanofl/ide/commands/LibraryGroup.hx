package nanofl.ide.commands;

import nanofl.ide.Clipboard;
import nanofl.ide.ui.Popups;

@:rtti
class LibraryGroup extends BaseGroup
{
	@inject var popups : Popups;
	@inject var clipboard : Clipboard;
	
	public function newEmptyMovieClip()		app.document.library.createEmptyMovieClip();
	public function newFolder()				app.document.library.createFolder();
	public function addFontManually()		popups.fontProperties.show();
	public function importFiles()			app.document.library.importFiles();
	public function remove()				app.document.library.removeSelected();
	public function deselectAll()			app.document.library.deselectAll();
	public function rename()				if (app.document.library.activeItem != null) app.document.library.renameByUser(app.document.library.activeItem.namePath);
	public function gotoPrev()				app.document.library.gotoPrevItem(true);
	public function gotoNext()				app.document.library.gotoNextItem(true);
	public function gotoPrevExtSelect()		app.document.library.gotoPrevItem(false);
	public function gotoNextExtSelect()		app.document.library.gotoNextItem(false);
	public function optimize()				app.document.library.optimize();
	public function removeUnused()			app.document.library.removeUnusedItems();
	public function selectUnused()			app.document.library.selectUnusedItems();
	public function importFont()			app.document.library.importFont();
	public function importImages()			app.document.library.importImages();
	public function importSounds()			app.document.library.importSounds();
	public function importMeshes()			app.document.library.importMeshes();
	public function properties()			app.document.library.showPropertiesPopup();
	public function createFolder()			app.document.library.createFolder();
	
	public function cut()					tempActiveView(ActiveView.LIBRARY, clipboard.cut);
	public function copy()					tempActiveView(ActiveView.LIBRARY, clipboard.copy);
	public function paste()					tempActiveView(ActiveView.LIBRARY, clipboard.paste);
}

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
	public function rename()				app.document.library.renameSelectedByUser();
	public function gotoPrev()				app.document.library.gotoPrevItem(true);
	public function gotoNext()				app.document.library.gotoNextItem(true);
	public function gotoPrevExtSelect()		app.document.library.gotoPrevItem(false);
	public function gotoNextExtSelect()		app.document.library.gotoNextItem(false);
	public function optimize()				app.document.library.optimize();
	public function removeUnused()			app.document.library.removeUnusedItems();
	public function selectUnused()			app.document.library.selectUnusedItems();
	public function importFont()			app.document.library.importFont();
	public function properties()			app.document.library.showPropertiesPopup();
	public function createFolder()			app.document.library.createFolder();
	public function duplicate()			    app.document.library.duplicate();
	public function openInAssociated()		app.document.library.openInAssociated();
	public function showInExplorer()		app.document.library.showInExplorer();
	
	public function cut()					tempActiveView(ActiveView.LIBRARY, clipboard.cut);
	public function copy()					tempActiveView(ActiveView.LIBRARY, clipboard.copy);
	public function paste()					tempActiveView(ActiveView.LIBRARY, clipboard.paste);
}

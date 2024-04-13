package nanofl.ide.ui;

import nanofl.ide.ui.views.*;

@:rtti
interface View
{
	var mainMenu(get, never) : IMainMenuView;
	var movie(get, never) : MovieView;
	var library(get, never) : LibraryView;
	var properties(get, never) : PropertiesView;
	var waiter(get, never) : Waiter;
	var shadow(get, never) : Shadow;
	var alerter(get, never) : Alerter;
	var fpsMeter(get, never) : FpsMeter;
	var startPage(get, never) : StartPage;
	
    @:allow(nanofl.ide.OpenedFiles)
    private var openedFiles(get, never) : OpenedFilesView;
}

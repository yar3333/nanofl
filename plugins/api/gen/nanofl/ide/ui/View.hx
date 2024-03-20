package nanofl.ide.ui;

interface View {
	var mainMenu(get, never) : nanofl.ide.ui.views.IMainMenuView;
	var movie(get, never) : nanofl.ide.ui.views.MovieView;
	var library(get, never) : nanofl.ide.ui.views.LibraryView;
	var properties(get, never) : nanofl.ide.ui.views.PropertiesView;
	var waiter(get, never) : nanofl.ide.ui.views.Waiter;
	var shadow(get, never) : nanofl.ide.ui.views.Shadow;
	var alerter(get, never) : nanofl.ide.ui.views.Alerter;
	var fpsMeter(get, never) : nanofl.ide.ui.views.FpsMeter;
	var output(get, never) : nanofl.ide.ui.views.IOutputView;
	var startPage(get, never) : nanofl.ide.ui.views.StartPage;
}
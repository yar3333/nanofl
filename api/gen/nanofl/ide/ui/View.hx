package nanofl.ide.ui;

extern class View {
	var mainMenu(get, never) : nanofl.ide.ui.views.IMainMenuView;
	private function get_mainMenu():nanofl.ide.ui.views.IMainMenuView;
	var movie(get, never) : nanofl.ide.ui.views.MovieView;
	private function get_movie():nanofl.ide.ui.views.MovieView;
	var library(get, never) : nanofl.ide.ui.views.LibraryView;
	private function get_library():nanofl.ide.ui.views.LibraryView;
	var properties(get, never) : nanofl.ide.ui.views.PropertiesView;
	private function get_properties():nanofl.ide.ui.views.PropertiesView;
	var waiter(get, never) : nanofl.ide.ui.views.Waiter;
	private function get_waiter():nanofl.ide.ui.views.Waiter;
	var shadow(get, never) : nanofl.ide.ui.views.Shadow;
	private function get_shadow():nanofl.ide.ui.views.Shadow;
	var alerter(get, never) : nanofl.ide.ui.views.Alerter;
	private function get_alerter():nanofl.ide.ui.views.Alerter;
	var fpsMeter(get, never) : nanofl.ide.ui.views.FpsMeter;
	private function get_fpsMeter():nanofl.ide.ui.views.FpsMeter;
	var output(get, never) : nanofl.ide.ui.views.IOutputView;
	private function get_output():nanofl.ide.ui.views.IOutputView;
	var startPage(get, never) : nanofl.ide.ui.views.StartPage;
	private function get_startPage():nanofl.ide.ui.views.StartPage;
}
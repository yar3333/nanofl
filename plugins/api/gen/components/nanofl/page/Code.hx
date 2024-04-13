package components.nanofl.page;

extern class Code extends wquery.Component implements nanofl.ide.ui.View implements nanofl.ide.ILayout {
	function new(parent:wquery.Component, parentNode:haxe.extern.EitherType<String, haxe.extern.EitherType<js.html.Element, js.JQuery>>, ?params:Dynamic, ?attachMode:wquery.AttachMode):Void;
	function getTemplate():components.nanofl.page.Template;
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
	var startPage(get, never) : nanofl.ide.ui.views.StartPage;
	private function get_startPage():nanofl.ide.ui.views.StartPage;
	var openedFiles(get, never) : nanofl.ide.ui.views.OpenedFilesView;
	private function get_openedFiles():nanofl.ide.ui.views.OpenedFilesView;
	function showLibraryPanel():Void;
	function showPropertiesPanel():Void;
}
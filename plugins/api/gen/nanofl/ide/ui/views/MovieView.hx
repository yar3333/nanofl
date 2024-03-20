package nanofl.ide.ui.views;

typedef MovieView = {
	var editor : components.nanofl.movie.editor.Code;
	function hide():Void;
	var navigator : nanofl.ide.ui.views.NavigatorView;
	function resize():Void;
	function show():Void;
	var statusBar : nanofl.ide.ui.views.StatusBar;
	var timeline : nanofl.ide.ui.views.TimelineView;
	var toolbar : nanofl.ide.ui.views.Toolbar;
	var zoomer : nanofl.ide.ui.views.Zoomer;
};
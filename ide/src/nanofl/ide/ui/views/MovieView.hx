package nanofl.ide.ui.views;

typedef MovieView =
{
	var timeline : components.nanofl.movie.timeline.Code;
	var editor : components.nanofl.movie.editor.Code;
	var toolbar : Toolbar;
	var navigator : NavigatorView;
	var zoomer : Zoomer;
	var statusBar : StatusBar;
	
	function show() : Void;
	function hide() : Void;
	
	function resize() : Void;
}

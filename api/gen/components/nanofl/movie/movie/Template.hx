package components.nanofl.movie.movie;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var timeline(get, never) : components.nanofl.movie.timeline.Code;
	var frameContainer(get, never) : js.JQuery;
	var toolbar(get, never) : components.nanofl.movie.toolbar.Code;
	var navigatorLine(get, never) : js.JQuery;
	var navigator(get, never) : components.nanofl.movie.navigator.Code;
	var zoomer(get, never) : components.nanofl.movie.zoomer.Code;
	var editor(get, never) : components.nanofl.movie.editor.Code;
	var statusBar(get, never) : components.nanofl.others.statusbar.Code;
}
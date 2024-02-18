package components.nanofl.library.librarytoolbar;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var newMovieClip(get, never) : js.JQuery;
	var newFolder(get, never) : js.JQuery;
	var properties(get, never) : js.JQuery;
	var removeItems(get, never) : js.JQuery;
}
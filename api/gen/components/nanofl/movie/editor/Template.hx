package components.nanofl.movie.editor;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var content(get, never) : js.JQuery;
	var contextMenu(get, never) : components.nanofl.common.contextmenu.Code;
}
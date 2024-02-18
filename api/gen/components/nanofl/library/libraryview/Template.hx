package components.nanofl.library.libraryview;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var preview(get, never) : components.nanofl.library.librarypreview.Code;
	var centerContainer(get, never) : js.JQuery;
	var items(get, never) : components.nanofl.library.libraryitems.Code;
}
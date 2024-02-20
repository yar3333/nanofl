package components.nanofl.library.librarypreview;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var canvas(get, never) : js.JQuery;
	var sound(get, never) : js.JQuery;
}
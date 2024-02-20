package components.nanofl.library.libraryitem;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var item(get, never) : js.JQuery;
	var name(get, never) : js.JQuery;
}
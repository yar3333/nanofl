package components.nanofl.common.contextmenu;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var content(get, never) : js.JQuery;
}
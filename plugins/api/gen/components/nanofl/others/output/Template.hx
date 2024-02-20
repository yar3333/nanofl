package components.nanofl.others.output;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var contextMenu(get, never) : components.nanofl.common.contextmenu.Code;
}
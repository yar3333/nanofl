package components.nanofl.common.dropdownmenu;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var shadow(get, never) : js.JQuery;
	var menu(get, never) : js.JQuery;
}
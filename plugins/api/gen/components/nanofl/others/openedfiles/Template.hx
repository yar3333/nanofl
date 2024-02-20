package components.nanofl.others.openedfiles;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var toggleMenu(get, never) : js.JQuery;
	var menu(get, never) : components.nanofl.common.dropdownmenu.Code;
	var tabs(get, never) : js.JQuery;
}
package components.nanofl.others.gradientselector;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var content(get, never) : js.JQuery;
	var gradient(get, never) : js.JQuery;
	var controls(get, never) : js.JQuery;
	var color(get, never) : components.nanofl.common.color.Code;
}
package components.nanofl.common.color;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var color(get, never) : js.JQuery;
}
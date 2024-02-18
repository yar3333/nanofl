package components.nanofl.common.slider;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var label(get, never) : js.JQuery;
	var slider(get, never) : js.JQuery;
	var value(get, never) : js.JQuery;
	var units(get, never) : js.JQuery;
}
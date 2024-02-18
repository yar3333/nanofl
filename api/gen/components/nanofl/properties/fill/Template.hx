package components.nanofl.properties.fill;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var type(get, never) : js.JQuery;
	var color(get, never) : components.nanofl.common.color.Code;
	var gradient(get, never) : components.nanofl.others.gradientselector.Code;
	var bitmap(get, never) : components.nanofl.others.bitmapselector.Code;
	var repeatContainer(get, never) : js.JQuery;
	var repeat(get, never) : js.JQuery;
}
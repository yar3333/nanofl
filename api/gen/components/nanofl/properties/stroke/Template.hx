package components.nanofl.properties.stroke;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var type(get, never) : js.JQuery;
	var color(get, never) : components.nanofl.common.color.Code;
	var gradient(get, never) : components.nanofl.others.gradientselector.Code;
	var bitmap(get, never) : components.nanofl.others.bitmapselector.Code;
	var thickness(get, never) : components.nanofl.common.slider.Code;
	var ignoreScale(get, never) : js.JQuery;
	var caps(get, never) : js.JQuery;
	var joints(get, never) : js.JQuery;
	var miterLimit(get, never) : components.nanofl.common.slider.Code;
}
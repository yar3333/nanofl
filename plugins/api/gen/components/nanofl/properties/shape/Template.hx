package components.nanofl.properties.shape;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var radius(get, never) : components.nanofl.common.slider.Code;
}
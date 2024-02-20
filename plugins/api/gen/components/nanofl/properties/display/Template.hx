package components.nanofl.properties.display;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var blendMode(get, never) : js.JQuery;
}
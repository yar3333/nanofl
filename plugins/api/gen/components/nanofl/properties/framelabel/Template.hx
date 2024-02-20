package components.nanofl.properties.framelabel;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var label(get, never) : js.JQuery;
}
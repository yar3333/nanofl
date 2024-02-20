package components.nanofl.properties.instance;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var name(get, never) : js.JQuery;
	var namePathContainer(get, never) : js.JQuery;
	var namePath(get, never) : js.JQuery;
}
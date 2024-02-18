package components.nanofl.properties.paragraph;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var align(get, never) : js.JQuery;
	var lineSpacing(get, never) : js.JQuery;
}
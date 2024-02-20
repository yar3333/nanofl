package components.nanofl.properties.character;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var family(get, never) : js.JQuery;
	var style(get, never) : js.JQuery;
	var fillColor(get, never) : components.nanofl.common.color.Code;
	var size(get, never) : components.nanofl.common.slider.Code;
	var strokeSize(get, never) : js.JQuery;
	var strokeColor(get, never) : components.nanofl.common.color.Code;
	var kerning(get, never) : js.JQuery;
	var letterSpacing(get, never) : js.JQuery;
}
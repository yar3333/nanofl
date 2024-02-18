package components.nanofl.others.custompropertiespane.item_color;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var colorContainer(get, never) : js.JQuery;
	var colorSelector(get, never) : components.nanofl.common.color.Code;
}
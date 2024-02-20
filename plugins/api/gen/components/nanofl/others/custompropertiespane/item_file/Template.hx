package components.nanofl.others.custompropertiespane.item_file;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var value(get, never) : js.JQuery;
	var browse(get, never) : js.JQuery;
}
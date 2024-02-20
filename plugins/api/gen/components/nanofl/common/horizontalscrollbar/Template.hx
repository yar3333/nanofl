package components.nanofl.common.horizontalscrollbar;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var bar(get, never) : js.JQuery;
}
package components.nanofl.common.waiter;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
}
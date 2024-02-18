package components.nanofl.others.alerter;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
}
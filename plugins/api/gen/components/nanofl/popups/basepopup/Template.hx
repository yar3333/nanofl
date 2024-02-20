package components.nanofl.popups.basepopup;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var overlay(get, never) : js.JQuery;
	var popup(get, never) : js.JQuery;
	var close(get, never) : js.JQuery;
	var title(get, never) : js.JQuery;
	var ok(get, never) : js.JQuery;
	var cancel(get, never) : js.JQuery;
}
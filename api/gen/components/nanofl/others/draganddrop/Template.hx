package components.nanofl.others.draganddrop;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var iconText(get, never) : js.JQuery;
	var icon(get, never) : js.JQuery;
	var text(get, never) : js.JQuery;
	var rectangle(get, never) : js.JQuery;
}
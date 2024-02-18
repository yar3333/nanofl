package components.nanofl.others.startpage;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var recents(get, never) : js.JQuery;
	var creates(get, never) : js.JQuery;
	var docs(get, never) : js.JQuery;
}
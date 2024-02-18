package components.nanofl.others.bitmapselector;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var container(get, never) : js.JQuery;
	var prev(get, never) : js.JQuery;
	var content(get, never) : js.JQuery;
	var image(get, never) : js.JQuery;
	var next(get, never) : js.JQuery;
}
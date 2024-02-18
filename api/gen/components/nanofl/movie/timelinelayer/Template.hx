package components.nanofl.movie.timelinelayer;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var layerRow(get, never) : js.JQuery;
	var icon(get, never) : js.JQuery;
	var title(get, never) : js.JQuery;
	var edited(get, never) : js.JQuery;
	var visible(get, never) : js.JQuery;
	var locked(get, never) : js.JQuery;
	var framesContent(get, never) : js.JQuery;
}
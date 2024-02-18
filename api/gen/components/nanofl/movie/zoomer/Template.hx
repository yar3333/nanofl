package components.nanofl.movie.zoomer;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var select(get, never) : js.JQuery;
}
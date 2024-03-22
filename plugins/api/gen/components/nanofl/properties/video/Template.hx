package components.nanofl.properties.video;

@:access(wquery.Component) extern class Template extends components.nanofl.properties.base.Template {
	function new(component:wquery.Component):Void;
	var currentTime(get, never) : js.JQuery;
	var seekTo(get, never) : js.JQuery;
}
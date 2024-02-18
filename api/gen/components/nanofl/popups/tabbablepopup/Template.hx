package components.nanofl.popups.tabbablepopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var tabbable(get, never) : js.JQuery;
	var parts(get, never) : js.JQuery;
	var panes(get, never) : js.JQuery;
}
package components.nanofl.popups.promptpopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var label(get, never) : js.JQuery;
	var text(get, never) : js.JQuery;
}
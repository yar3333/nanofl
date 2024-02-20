package components.nanofl.popups.fontimportpopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var text(get, never) : js.JQuery;
}
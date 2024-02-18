package components.nanofl.popups.registerpopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var trialMessage(get, never) : js.JQuery;
	var key(get, never) : js.JQuery;
	var register(get, never) : js.JQuery;
}
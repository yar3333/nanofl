package components.nanofl.popups.aboutapplicationpopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var version(get, never) : js.JQuery;
	var trialMessage(get, never) : js.JQuery;
}
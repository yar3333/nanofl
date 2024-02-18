package components.nanofl.popups.soundpropertiespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var linkage(get, never) : js.JQuery;
}
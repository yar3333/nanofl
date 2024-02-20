package components.nanofl.popups.custompropertiespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var customProperties(get, never) : components.nanofl.others.custompropertiespane.Code;
}
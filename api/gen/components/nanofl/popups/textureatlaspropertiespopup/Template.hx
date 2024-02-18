package components.nanofl.popups.textureatlaspropertiespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var name(get, never) : js.JQuery;
	var width(get, never) : js.JQuery;
	var height(get, never) : js.JQuery;
	var padding(get, never) : js.JQuery;
}
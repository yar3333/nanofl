package components.nanofl.popups.fontpropertiespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var family(get, never) : js.JQuery;
	var variantsPlaceholder(get, never) : js.JQuery;
	var addVariant(get, never) : js.JQuery;
}
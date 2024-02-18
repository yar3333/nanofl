package components.nanofl.popups.preferencespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.tabbablepopup.Template {
	function new(component:wquery.Component):Void;
	var generalPropertiesPane(get, never) : js.JQuery;
	var checkNewVersionPeriod(get, never) : js.JQuery;
	var customPropertiesPane(get, never) : js.JQuery;
	var customPropertiesPaneTitle(get, never) : js.JQuery;
	var scrollable(get, never) : js.JQuery;
	var customPropertiesPaneNoProperties(get, never) : js.JQuery;
	var customProperties(get, never) : components.nanofl.others.custompropertiespane.Code;
}
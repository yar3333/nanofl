package components.nanofl.popups.fontpropertiespopup.item;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var row(get, never) : js.JQuery;
	var style(get, never) : js.JQuery;
	var weight(get, never) : js.JQuery;
	var locals(get, never) : js.JQuery;
	var formatAndUrls(get, never) : js.JQuery;
	var removeVariant(get, never) : js.JQuery;
}
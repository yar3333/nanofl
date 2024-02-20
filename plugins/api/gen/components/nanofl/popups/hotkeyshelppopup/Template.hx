package components.nanofl.popups.hotkeyshelppopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var pane(get, never) : js.JQuery;
	var hotkeys(get, never) : js.JQuery;
}
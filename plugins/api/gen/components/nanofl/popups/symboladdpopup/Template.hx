package components.nanofl.popups.symboladdpopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var name(get, never) : js.JQuery;
	var registration(get, never) : js.JQuery;
}
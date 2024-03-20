package components.nanofl.popups.exportprogresspopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var outputFile(get, never) : js.JQuery;
	var progressbar(get, never) : js.JQuery;
	var info(get, never) : js.JQuery;
}
package components.nanofl.popups.sharefordevicespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var linkID(get, never) : js.JQuery;
	var url(get, never) : js.JQuery;
	var generateNewLinkID(get, never) : js.JQuery;
}
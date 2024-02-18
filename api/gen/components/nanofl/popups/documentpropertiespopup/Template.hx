package components.nanofl.popups.documentpropertiespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var width(get, never) : js.JQuery;
	var height(get, never) : js.JQuery;
	var backgroundColor(get, never) : components.nanofl.common.color.Code;
	var framerate(get, never) : js.JQuery;
	var scaleMode(get, never) : js.JQuery;
	var autoPlay(get, never) : js.JQuery;
	var loop(get, never) : js.JQuery;
	var sceneLinkedClass(get, never) : js.JQuery;
}
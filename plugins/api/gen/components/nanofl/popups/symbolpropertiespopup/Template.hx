package components.nanofl.popups.symbolpropertiespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var likeButton(get, never) : js.JQuery;
	var autoPlay(get, never) : js.JQuery;
	var loop(get, never) : js.JQuery;
	var exportAsSprite(get, never) : js.JQuery;
	var meshItem(get, never) : js.JQuery;
	var renderAreaSize(get, never) : js.JQuery;
	var loadLights(get, never) : js.JQuery;
	var linkedClass(get, never) : js.JQuery;
	var relatedSound(get, never) : js.JQuery;
}
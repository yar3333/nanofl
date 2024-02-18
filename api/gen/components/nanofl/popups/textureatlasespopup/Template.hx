package components.nanofl.popups.textureatlasespopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var libraryContainer(get, never) : js.JQuery;
	var library(get, never) : components.nanofl.library.libraryview.Code;
	var toAtlas(get, never) : js.JQuery;
	var fromAtlas(get, never) : js.JQuery;
	var atlases(get, never) : js.JQuery;
	var newAtlas(get, never) : js.JQuery;
	var atlasProperties(get, never) : js.JQuery;
	var deleteAtlas(get, never) : js.JQuery;
	var atlasContainer(get, never) : js.JQuery;
	var atlas(get, never) : components.nanofl.library.libraryview.Code;
}
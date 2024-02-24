package components.nanofl.popups.publishsettingspopup;

@:access(wquery.Component) extern class Template extends components.nanofl.popups.basepopup.Template {
	function new(component:wquery.Component):Void;
	var useTextureAtlases(get, never) : js.JQuery;
	var manageTextureAtlases(get, never) : js.JQuery;
	var isConvertImagesIntoJpeg(get, never) : js.JQuery;
	var jpegQuality(get, never) : js.JQuery;
	var audioQuality(get, never) : js.JQuery;
	var urlOnClick(get, never) : js.JQuery;
	var useLocalScripts(get, never) : js.JQuery;
	var publish(get, never) : js.JQuery;
}
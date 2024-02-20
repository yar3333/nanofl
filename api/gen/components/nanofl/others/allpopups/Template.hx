package components.nanofl.others.allpopups;

@:access(wquery.Component) extern class Template {
	function new(component:wquery.Component):Void;
	var prompt(get, never) : components.nanofl.popups.promptpopup.Code;
	var documentProperties(get, never) : components.nanofl.popups.documentpropertiespopup.Code;
	var fontProperties(get, never) : components.nanofl.popups.fontpropertiespopup.Code;
	var fontImport(get, never) : components.nanofl.popups.fontimportpopup.Code;
	var symbolAdd(get, never) : components.nanofl.popups.symboladdpopup.Code;
	var symbolProperties(get, never) : components.nanofl.popups.symbolpropertiespopup.Code;
	var soundProperties(get, never) : components.nanofl.popups.soundpropertiespopup.Code;
	var aboutApplication(get, never) : components.nanofl.popups.aboutapplicationpopup.Code;
	var textureAtlases(get, never) : components.nanofl.popups.textureatlasespopup.Code;
	var customProperties(get, never) : components.nanofl.popups.custompropertiespopup.Code;
	var textureAtlasProperties(get, never) : components.nanofl.popups.textureatlaspropertiespopup.Code;
	var preferences(get, never) : components.nanofl.popups.preferencespopup.Code;
	var hotkeysHelp(get, never) : components.nanofl.popups.hotkeyshelppopup.Code;
	var publishSettings(get, never) : components.nanofl.popups.publishsettingspopup.Code;
}
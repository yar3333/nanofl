package components.nanofl.others.allpopups;

@:access(wquery.Component)
class Template
{
	var component : wquery.Component;
	
	public var prompt(get, never) : components.nanofl.popups.promptpopup.Code;
	inline function get_prompt() return cast component.children.prompt;
	
	public var documentProperties(get, never) : components.nanofl.popups.documentpropertiespopup.Code;
	inline function get_documentProperties() return cast component.children.documentProperties;
	
	public var fontProperties(get, never) : components.nanofl.popups.fontpropertiespopup.Code;
	inline function get_fontProperties() return cast component.children.fontProperties;
	
	public var fontImport(get, never) : components.nanofl.popups.fontimportpopup.Code;
	inline function get_fontImport() return cast component.children.fontImport;
	
	public var symbolAdd(get, never) : components.nanofl.popups.symboladdpopup.Code;
	inline function get_symbolAdd() return cast component.children.symbolAdd;
	
	public var symbolProperties(get, never) : components.nanofl.popups.symbolpropertiespopup.Code;
	inline function get_symbolProperties() return cast component.children.symbolProperties;
	
	public var soundProperties(get, never) : components.nanofl.popups.soundpropertiespopup.Code;
	inline function get_soundProperties() return cast component.children.soundProperties;
	
	public var aboutApplication(get, never) : components.nanofl.popups.aboutapplicationpopup.Code;
	inline function get_aboutApplication() return cast component.children.aboutApplication;
	
	public var textureAtlases(get, never) : components.nanofl.popups.textureatlasespopup.Code;
	inline function get_textureAtlases() return cast component.children.textureAtlases;
	
	public var customProperties(get, never) : components.nanofl.popups.custompropertiespopup.Code;
	inline function get_customProperties() return cast component.children.customProperties;
	
	public var textureAtlasProperties(get, never) : components.nanofl.popups.textureatlaspropertiespopup.Code;
	inline function get_textureAtlasProperties() return cast component.children.textureAtlasProperties;
	
	public var preferences(get, never) : components.nanofl.popups.preferencespopup.Code;
	inline function get_preferences() return cast component.children.preferences;
	
	public var hotkeysHelp(get, never) : components.nanofl.popups.hotkeyshelppopup.Code;
	inline function get_hotkeysHelp() return cast component.children.hotkeysHelp;
	
	public var publishSettings(get, never) : components.nanofl.popups.publishsettingspopup.Code;
	inline function get_publishSettings() return cast component.children.publishSettings;
    
	public var exportProgress(get, never) : components.nanofl.popups.exportprogresspopup.Code;
	inline function get_exportProgress() return cast component.children.exportProgress;

	public function new(component:wquery.Component) this.component = component;
}
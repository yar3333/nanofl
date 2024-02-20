package nanofl.ide.ui;

extern class Popups extends nanofl.ide.InjectContainer {
	function new(container:Container):Void;
	var prompt(get, never) : components.nanofl.popups.promptpopup.Code;
	private function get_prompt():components.nanofl.popups.promptpopup.Code;
	var documentProperties(get, never) : components.nanofl.popups.documentpropertiespopup.Code;
	private function get_documentProperties():components.nanofl.popups.documentpropertiespopup.Code;
	var fontProperties(get, never) : components.nanofl.popups.fontpropertiespopup.Code;
	private function get_fontProperties():components.nanofl.popups.fontpropertiespopup.Code;
	var fontImport(get, never) : components.nanofl.popups.fontimportpopup.Code;
	private function get_fontImport():components.nanofl.popups.fontimportpopup.Code;
	var symbolAdd(get, never) : components.nanofl.popups.symboladdpopup.Code;
	private function get_symbolAdd():components.nanofl.popups.symboladdpopup.Code;
	var symbolProperties(get, never) : components.nanofl.popups.symbolpropertiespopup.Code;
	private function get_symbolProperties():components.nanofl.popups.symbolpropertiespopup.Code;
	var soundProperties(get, never) : components.nanofl.popups.soundpropertiespopup.Code;
	private function get_soundProperties():components.nanofl.popups.soundpropertiespopup.Code;
	var aboutApplication(get, never) : components.nanofl.popups.aboutapplicationpopup.Code;
	private function get_aboutApplication():components.nanofl.popups.aboutapplicationpopup.Code;
	var textureAtlases(get, never) : components.nanofl.popups.textureatlasespopup.Code;
	private function get_textureAtlases():components.nanofl.popups.textureatlasespopup.Code;
	var customProperties(get, never) : components.nanofl.popups.custompropertiespopup.Code;
	private function get_customProperties():components.nanofl.popups.custompropertiespopup.Code;
	var textureAtlasProperties(get, never) : components.nanofl.popups.textureatlaspropertiespopup.Code;
	private function get_textureAtlasProperties():components.nanofl.popups.textureatlaspropertiespopup.Code;
	var preferences(get, never) : components.nanofl.popups.preferencespopup.Code;
	private function get_preferences():components.nanofl.popups.preferencespopup.Code;
	var hotkeysHelp(get, never) : components.nanofl.popups.hotkeyshelppopup.Code;
	private function get_hotkeysHelp():components.nanofl.popups.hotkeyshelppopup.Code;
	var publishSettings(get, never) : components.nanofl.popups.publishsettingspopup.Code;
	private function get_publishSettings():components.nanofl.popups.publishsettingspopup.Code;
	function showConfirm(title:String, text:String, but0:String, but1:String, but2:String):js.lib.Promise<{ public var response(default, default) : Float; public var checkboxChecked(default, default) : Bool; }>;
	function showOpenFile(title:String, filters:Array<{ public var name(default, default) : String; public var extensions(default, default) : Array<String>; }>, ?multiple:Bool):js.lib.Promise<{ public var filePaths(default, default) : Array<String>; public var canceled(default, default) : Bool; public var bookmarks(default, default) : Array<String>; }>;
	function showSaveFile(title:String, filters:Array<{ public var name(default, default) : String; public var extensions(default, default) : Array<String>; }>):js.lib.Promise<{ public var filePath(default, default) : String; public var canceled(default, default) : Bool; public var bookmark(default, default) : String; }>;
}
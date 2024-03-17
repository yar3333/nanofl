package nanofl.ide.ui;

import js.lib.Promise;

private typedef ContainerInner =
{
	var prompt(get, never): components.nanofl.popups.promptpopup.Code;
	var documentProperties(get, never): components.nanofl.popups.documentpropertiespopup.Code;
	var fontProperties(get, never): components.nanofl.popups.fontpropertiespopup.Code;
	var fontImport(get, never): components.nanofl.popups.fontimportpopup.Code;
	var symbolAdd(get, never): components.nanofl.popups.symboladdpopup.Code;
	var symbolProperties(get, never): components.nanofl.popups.symbolpropertiespopup.Code;
	var soundProperties(get, never): components.nanofl.popups.soundpropertiespopup.Code;
	var aboutApplication(get, never): components.nanofl.popups.aboutapplicationpopup.Code;
	var textureAtlases(get, never): components.nanofl.popups.textureatlasespopup.Code;
	var customProperties(get, never): components.nanofl.popups.custompropertiespopup.Code;
	var textureAtlasProperties(get, never): components.nanofl.popups.textureatlaspropertiespopup.Code;
	var preferences(get, never): components.nanofl.popups.preferencespopup.Code;
	var hotkeysHelp(get, never): components.nanofl.popups.hotkeyshelppopup.Code;
	var publishSettings(get, never): components.nanofl.popups.publishsettingspopup.Code;
}

private typedef Container =
{
	function getTemplate() :
	{
		var popupsContainer(get, never) :
		{
			function getPopups() : ContainerInner;
		}
	};
}

@:rtti
class Popups extends InjectContainer
{
    @inject var dialogs : nanofl.ide.sys.Dialogs;

	var container : Container;
	
	public var prompt(get, never) : components.nanofl.popups.promptpopup.Code;
	function get_prompt() return container.getTemplate().popupsContainer.getPopups().prompt;
	
	public var documentProperties(get, never) : components.nanofl.popups.documentpropertiespopup.Code;
	function get_documentProperties() return container.getTemplate().popupsContainer.getPopups().documentProperties;
	
	public var fontProperties(get, never) : components.nanofl.popups.fontpropertiespopup.Code;
	function get_fontProperties() return container.getTemplate().popupsContainer.getPopups().fontProperties;
	
	public var fontImport(get, never) : components.nanofl.popups.fontimportpopup.Code;
	function get_fontImport() return container.getTemplate().popupsContainer.getPopups().fontImport;
	
	public var symbolAdd(get, never) : components.nanofl.popups.symboladdpopup.Code;
	function get_symbolAdd() return container.getTemplate().popupsContainer.getPopups().symbolAdd;
	
	public var symbolProperties(get, never) : components.nanofl.popups.symbolpropertiespopup.Code;
	function get_symbolProperties() return container.getTemplate().popupsContainer.getPopups().symbolProperties;
	
	public var soundProperties(get, never) : components.nanofl.popups.soundpropertiespopup.Code;
	function get_soundProperties() return container.getTemplate().popupsContainer.getPopups().soundProperties;
	
	public var aboutApplication(get, never) : components.nanofl.popups.aboutapplicationpopup.Code;
	function get_aboutApplication() return container.getTemplate().popupsContainer.getPopups().aboutApplication;
	
	public var textureAtlases(get, never) : components.nanofl.popups.textureatlasespopup.Code;
	function get_textureAtlases() return container.getTemplate().popupsContainer.getPopups().textureAtlases;
	
	public var customProperties(get, never) : components.nanofl.popups.custompropertiespopup.Code;
	function get_customProperties() return container.getTemplate().popupsContainer.getPopups().customProperties;
	
	public var textureAtlasProperties(get, never) : components.nanofl.popups.textureatlaspropertiespopup.Code;
	function get_textureAtlasProperties() return container.getTemplate().popupsContainer.getPopups().textureAtlasProperties;
	
	public var preferences(get, never) : components.nanofl.popups.preferencespopup.Code;
	function get_preferences() return container.getTemplate().popupsContainer.getPopups().preferences;
	
	public var hotkeysHelp(get, never) : components.nanofl.popups.hotkeyshelppopup.Code;
	function get_hotkeysHelp() return container.getTemplate().popupsContainer.getPopups().hotkeysHelp;
	
	public var publishSettings(get, never) : components.nanofl.popups.publishsettingspopup.Code;
	function get_publishSettings() return container.getTemplate().popupsContainer.getPopups().publishSettings;
	
	public function showConfirm(title:String, text:String, but0:String, but1:String, but2:String) : Promise<{ response:Float, checkboxChecked:Bool }>
	{
        return dialogs.showMessageBox
		({
            type: "question",
            buttons: [but0, but1, but2],
            title: title,
            message: text
		});
	}
	
	public function showOpenFile(title:String, filters:Array<{ name:String, extensions:Array<String> }>) : Promise<String>
	{
        return dialogs.showOpenDialog
		({
            title: title,
            filters: filters,
            properties: ["openFile"]
		})
        .then(r ->
        {
            if (r == null || r.canceled || r.filePaths == null || r.filePaths.length == 0) return null;
            return r.filePaths[0];
        });
	}	
    
    public function showOpenFiles(title:String, filters:Array<{ name:String, extensions:Array<String> }>) : Promise<Array<String>>
	{
        return dialogs.showOpenDialog
		({
            title: title,
            filters: filters,
            properties: ["openFile", "multiSelections"]
		})        
        .then(r ->
        {
            if (r == null || r.canceled || r.filePaths == null || r.filePaths.length == 0) return null;
            return r.filePaths;
        });
	}
	
	public function showSaveFile(title:String, filters:Array<{ name:String, extensions:Array<String> }>) : Promise<String>
	{
		return dialogs.showSaveDialog
        ({
            title: title,
            filters: filters
		})
        .then(r ->
        {
            if (r == null || r.canceled || r.filePath == null || r.filePath == "") return null;
            return r.filePath;
        });
	}
	
	public function new(container:Container)
	{
        super();
		this.container = container;
	}
}
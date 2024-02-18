package components.nanofl.popups.preferencespopup;

import js.lib.Error;
import nanofl.engine.CustomProperty;
import nanofl.ide.plugins.CustomizablePlugin;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.ide.plugins.ImporterPlugins;
import nanofl.ide.plugins.LoaderPlugins;
import nanofl.ide.preferences.Preferences;
import nanofl.ide.ui.Popups;
using nanofl.ide.plugins.CustomizablePluginTools;
using stdlib.Lambda;
using StringTools;
using stdlib.Lambda;

@:rtti
class Code extends components.nanofl.popups.tabbablepopup.Code
{
	static var imports =
	{
		"custom-properties-table-form": components.nanofl.others.custompropertiestableform.Code
	};

	@inject var popups : Popups;
	@inject var preferences : Preferences;

	var editedParams : Map<String, Dynamic>;

	override function initPopup()
    {
        super.initPopup();
        
        template().checkNewVersionPeriod.val(preferences.application.checkNewVersionPeriod);

		editedParams = new Map();
    }
    
    override function getLinks() : Array<String>
    {
        var links =
        [
            createHeaderTab("Application"),
            createItemTab(template().generalPropertiesPane, "general", "application", "General", "custom-icon-properties", false)
        ];
        
        links = links.concat(getPluginLinks("Importers", "importer", ImporterPlugins.plugins));
        links = links.concat(getPluginLinks("Exporters", "exporter", ExporterPlugins.plugins));
        links = links.concat(getPluginLinks("Loaders",   "loader",   LoaderPlugins.plugins));
        
        return links;
    }
    
    function getPluginLinks<T:CustomizablePlugin>(header:String, prefix:String, plugins:Map<String,T>) : Array<String>
    {
        var r = plugins.keys()
            .filter(x -> plugins.get(x).properties != null && plugins.get(x).properties.length > 0)
            .sorted()
            .map(x -> createPluginTab(plugins.get(x), prefix));
        if (r.length > 0)
        {
            r.unshift(createHeaderTab(header));
        }
        return r;
    }
    
    override function initPane(command:String)
    {
        var partAndName = command.split("-");
        
        switch (partAndName[0])
        {
            case "importer":
                var plugin = ImporterPlugins.plugins.get(partAndName[1]);
                bindCustomPropertiesPane(plugin.menuItemName, plugin.properties, getParamObj(plugin.getPreferenceKey(), {}));
                
            case "exporter":
                var plugin = ExporterPlugins.plugins.get(partAndName[1]);
                bindCustomPropertiesPane(plugin.menuItemName, plugin.properties, getParamObj(plugin.getPreferenceKey(), {}));
                
            case "loader":
                var plugin = LoaderPlugins.plugins.get(partAndName[1]);
                bindCustomPropertiesPane(plugin.menuItemName, plugin.properties, getParamObj(plugin.getPreferenceKey(), {}));
                
            case "application":
                // nothing to do
                
            case _:
                throw new Error("Unknow command '" + command + "'.");
        }
    }
    
    override function onOK()
    {
		for (p in editedParams.keys().sorted())
        {
            setRawParamObj(p, editedParams.get(p));
        }
            
        preferences.application.checkNewVersionPeriod = template().checkNewVersionPeriod.val();
        
        preferences.storage.applyToIDE();
    }
    
    function getRawParamObj(key:String, defValue:Dynamic) : Dynamic
    {
        return preferences.storage.getObject(key, defValue);
    }
    
    function setRawParamObj(key:String, value:Dynamic) : Void
    {
        preferences.storage.set(key, value);
    }
    
    ///////////////////////////////////////////
	
	override public function show(?callb:Void->Void) 
	{
		super.show(callb);
		template().scrollable.height(template().customPropertiesPane.parent().height() - 30/*template().customPropertiesPaneTitle.outerHeight(true)*/);
	}
	
	function createCustomTab(command:String, prefix:String, name:String, icon:String, grey:Bool, ?preHtml:String) : String
	{
		return createItemTab(template().customPropertiesPane, command, prefix, name, icon, grey, preHtml);
	}
	
	function createPluginTab(p:CustomizablePlugin, prefix:String)
	{
		return createCustomTab(p.name, prefix, p.menuItemName, p.menuItemIcon, p.properties == null || p.properties.length == 0);
	}
	
	function bindCustomPropertiesPane(title:String, properties:Array<CustomProperty>, data:Dynamic)
	{
		template().customPropertiesPaneTitle.html(title);
		
		if (properties != null && properties.length > 0)
		{
			template().customPropertiesPaneNoProperties.hide();
			template().customProperties.bind(properties, data);
		}
		else
		{
			template().customProperties.clear();
			template().customPropertiesPaneNoProperties.show();
		}
	}
	
	function getParamObj(key:String, defValue:Dynamic) : Dynamic
	{
		if (!editedParams.exists(key))
		{
			editedParams.set(key, getRawParamObj(key, defValue));
		}
		return editedParams.get(key);
	}
}
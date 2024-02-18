package nanofl.ide.plugins;

import js.lib.Error;
import nanofl.engine.CustomPropertiesTools;
import nanofl.ide.preferences.PreferencesStorage;
import nanofl.ide.plugins.LoaderPlugins;

class CustomizablePluginTools
{
	public static function getPreferenceKey(plugin:CustomizablePlugin) : String
	{
		var type : String = null;
		
		if (ImporterPlugins.plugins.exists(plugin.name)) type = "importer";
		else
		if (ExporterPlugins.plugins.exists(plugin.name)) type = "exporter";
		else
		if (LoaderPlugins.plugins.exists(plugin.name)) type = "loader";
		else
		{
			throw new Error("Unsupported plugin type (" + plugin.name + ").");
		}
		
		return "plugins." + type + "." + plugin.name;
	}
	
	public static function getParams(plugin:CustomizablePlugin, preferenceStorage:PreferencesStorage) : Dynamic
	{
		return CustomPropertiesTools.fix(preferenceStorage.getObject(getPreferenceKey(plugin), {}), plugin.properties);
	}
}

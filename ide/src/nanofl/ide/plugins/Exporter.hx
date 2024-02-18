package nanofl.ide.plugins;

import nanofl.engine.CustomPropertiesTools;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.plugins.ExporterPlugins;

class Exporter
{
	public var pluginName(default, null) : String;
	public var params(default, null) : Dynamic;
	
	public function new(pluginName:String, params:Dynamic)
	{
		this.pluginName = pluginName;
		this.params = params;
	}
	
	public function run(srcFilePath:String, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Bool
	{
		var plugin = ExporterPlugins.plugins.get(pluginName);
		if (plugin != null)
		{
            var pluginApi = new PluginApi();
			return plugin.exportDocument(pluginApi, CustomPropertiesTools.fix(params, plugin.properties), srcFilePath, destFilePath, documentProperties, library);
		}
		else
		{
			trace("ERROR: Save document '" + destFilePath + "' fail - plugin '" + pluginName + "' not found.");
			return false;
		}
	}
}

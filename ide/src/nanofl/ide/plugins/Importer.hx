package nanofl.ide.plugins;

import js.lib.Promise;
import nanofl.engine.CustomPropertiesTools;
import nanofl.ide.DocumentProperties;
import nanofl.ide.library.IdeLibrary;
import nanofl.ide.plugins.ImporterPlugins;

class Importer
{
	public var pluginName(default, null) : String;
	public var params(default, null) : Dynamic;
	
	public function new(pluginName:String, ?params:Dynamic)
	{
		this.pluginName = pluginName;
		this.params = params;
	}
	
	public function run(srcFilePath:String, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Promise<Bool>
	{
		var plugin = ImporterPlugins.plugins.get(pluginName);
		
		if (plugin != null)
		{
            var pluginApi = new PluginApi();
			return plugin.importDocument(pluginApi,
            {
                params: CustomPropertiesTools.fix(params, plugin.properties),
                srcFilePath: srcFilePath,
                destFilePath: destFilePath,
                documentProperties: documentProperties,
                library: library,
            });
		}
		else
		{
			trace("ERROR: Load document '" + srcFilePath + "' fail - plugin '" + pluginName + "' not found.");
			return Promise.resolve(false);
		}
	}
	
	public function getPublishPath(originalPath:String) : String
	{
		var plugin = ImporterPlugins.plugins.get(pluginName);
		return plugin.getPublishPath(originalPath);
	}
}

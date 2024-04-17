package nanofl.ide.plugins;

import stdlib.Timer;
import js.lib.Promise;
import haxe.io.Path;
import nanofl.ide.sys.Folders;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.ui.View;
using stdlib.Lambda;

@:rtti
class Plugins extends InjectContainer
{
	@inject var folders : Folders;
	@inject var fileSystem : FileSystem;
	@inject var view : View;
	
	public function reload(alertOnSuccess=true) : Promise<{}>
	{
		log("Load plugins...");

        var r = Promise.resolve({});
		
		for (path in getPluginPaths())
		{
			log("Load plugin: " + path);
			//nanofl.engine.plugins.FilterPlugins.activeSource = Serializer.run(fileSystem.getContent(path));
            r = r.then(_ -> ExternalScriptLoader.loadAndExecute(path))
                 .catchError(e ->
                 {
                    var errorMessage = 'Error in plugin "' + path.substring(folders.plugins.length + 1) + '"';
                    Timer.delay(() -> view.alerter.error(errorMessage), 1);
                 });
		}

        return r.then(_ ->
        {
			if (alertOnSuccess) view.alerter.info("All plugins (re)loaded.");
            log("Exporters = " + nanofl.ide.plugins.ExporterPlugins.plugins.count());
            view.mainMenu.update();
            return null;
        });
	}
	
	function getPluginPaths() : Array<String>
	{
		var r = [];
		
		var pluginsDir = folders.plugins;
		if (fileSystem.exists(pluginsDir))
		{
			for (subdir in fileSystem.readDirectory(pluginsDir).filter(x -> fileSystem.isDirectory(pluginsDir + "/" + x)))
			{
				var basePath = pluginsDir + "/" + subdir;
				for (plugin in fileSystem.readDirectory(basePath))
				{
					var basePath = basePath + "/" + plugin;
					if (fileSystem.isDirectory(basePath))
					{
						if (fileSystem.exists(basePath + "/" + plugin + ".js"))
						{
							r.push(basePath + "/" + plugin + ".js");
						}
					}
					else
					{
						if (Path.extension(plugin) == "js")
						{
							r.push(basePath);
						}
					}
				}
			}
		}
		
		return r;
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}

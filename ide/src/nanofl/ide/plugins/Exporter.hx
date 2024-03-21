package nanofl.ide.plugins;

import js.lib.Promise;
import nanofl.engine.CustomPropertiesTools;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Polygon;
import nanofl.ide.Document;
import nanofl.ide.ui.Popups;
using stdlib.Lambda;

class Exporter
{
	public var pluginName(default, null) : String;
	public var params(default, null) : Dynamic;
	
	public function new(pluginName:String, params:Dynamic)
	{
		this.pluginName = pluginName;
		this.params = params;
	}

    public function run(document:Document, path:String, popups:Popups) : Promise<Bool>
	{
        final plugin = ExporterPlugins.plugins.get(pluginName);
        if (plugin == null)
        {
            trace("ERROR: Save document '" + path + "' fail - plugin '" + pluginName + "' not found.");
            return Promise.resolve(false);
        }

        Edges.showSelection = false;
        Polygon.showSelection = false;

        final args : ExporterArgs = 
        {
            params: CustomPropertiesTools.fix(params, plugin.properties),
            srcFilePath: document.path,
            destFilePath: path,
            documentProperties: document.properties,
            library: document.library.getRawLibrary(),
            originalFilePath: document.originalPath,
            setProgressPercent: percent -> popups.exportProgress.setPercent(percent),
            setProgressInfo: text -> popups.exportProgress.setInfo(text),
            wantToCancel: false,
        };
        
        popups.exportProgress.show(path, () -> args.wantToCancel = true);

        return plugin.exportDocument(new PluginApi(), args)
            .finally(() ->
            {
                popups.exportProgress.close();

                Edges.showSelection = true;
                Polygon.showSelection = true;
            })
            .catchError(e ->
            {
                trace(e);
                return false;
            });
	}
}

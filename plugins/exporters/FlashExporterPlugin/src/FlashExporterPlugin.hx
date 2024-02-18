import htmlparser.XmlBuilder;
import nanofl.engine.CustomProperty;
import nanofl.ide.DocumentProperties;
import nanofl.ide.plugins.ExporterPlugins;
import nanofl.ide.plugins.IExporterPlugin;
import nanofl.ide.sys.FileSystem;
import nanofl.ide.plugins.PluginApi;

class FlashExporterPlugin implements IExporterPlugin
{
	static function main()
    {
        ExporterPlugins.register(new FlashExporterPlugin());
    }
	
	public var name = "FlashExporter";
	
	public var menuItemName = "Adobe Flash Document (*.fla;*.xfl)";
	public var menuItemIcon = "url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAACXBIWXMAAAsSAAALEgHS3X78AAACNUlEQVQoz21Qz0uUURQ997033zhjZvhjapps1RAkqYt0U1O4MAiLwUWEhEEQtKl2LdoEIkR/gFsX1S4iZgjbJiFEizSwTCgoYhgtSUTnm5nP+d47LWZGgzxwuffCORzOEZKYm5szw8PDvel0+nilUqEAAhIAAKUoIiYMwz/FYnEhl8v52WxWQBL5fB4jIyOTJFmtVnf4D6y1liQLhcLP0dHR6wAi+XweBgBmZ2fR0tIiALDt+64WBI5fv8FqjSB1FFok7O7u7pmenn5sjGE2m81hdXVVAODGxMQUSW5tbOxUnzzjzoP7LN+5xw3f59bmJq21oXOO6+vrhVQqdd6ICACA1tb38xeQd2/haiHcwQ5EvAjCIIDv+7pSqYSJRCKltT5k2ChB2tqAtd9QS4tgZxfkyhi8k2lY60BjEIYhrLUKAEjWDwBgtQosfEC4tAz2n4EaGoRKJqGVQiQSQTQaRSwWa9KVYq2mAcB8/uKwsgxvsI/hzAyCh5OAtVBKQWsNrTWMMU0hjBMJz7W2tt+OxQf4aQnOiWJnArrnWJ3R6EBEoJTaEyYXP2beDAxdCFKHLweVCvXYNR29OgZXKoEk6NyucLdIEsafevQyTCQ6zHZJSV8/vEsXQRFgL8++jspVgy7v+w8XP5Isyfg42HbA2XLZ0dVB0pHNr2EPULW/fnX2/a2bQ3d/rT2Nne4Fg8B68biKeJ7y9pmGO4Uk5ufnJZPJnEqn0yfK5bKVZpj/QRFhsVhc+QuQDi4zdLU6egAAAABJRU5ErkJggg==)";
	public var fileFilterDescription = "Adobe Flash Documents (*.fla;*.xfl)";
	public var fileFilterExtensions = [ "fla", "xfl" ];
	
	public var properties : Array<CustomProperty> = null;
	
    public function new() {}
	
    public function exportDocument(api:PluginApi, params:Dynamic, srcFilePath:String, destFilePath:String, documentProperties:nanofl.ide.DocumentProperties, library:nanofl.ide.library.IdeLibrary) : Bool
	{
        trace("Plugin.exportDocument " + srcFilePath + " => " + destFilePath);
		var scene = library.getSceneItem();
		trace("scene.layers.length = " + scene.layers.length);
		
		var xml = new XmlBuilder();
		xml.begin("root").attr("a", "123");
			xml.begin("inner");
			xml.content("text");
			xml.end();
		xml.end();
		
		api.fileSystem.saveContent(destFilePath, xml.toString());
		
		return true;
	}
}
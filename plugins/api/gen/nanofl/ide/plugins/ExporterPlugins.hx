package nanofl.ide.plugins;

extern class ExporterPlugins {
	static var plugins(default, null) : haxe.ds.Map<String, nanofl.ide.plugins.IExporterPlugin>;
	static function register(plugin:nanofl.ide.plugins.IExporterPlugin):Void;
	static function getByExtension(ext:String):nanofl.ide.plugins.IExporterPlugin;
}
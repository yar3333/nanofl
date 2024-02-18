package nanofl.ide.plugins;

extern class ImporterPlugins {
	static var plugins(default, null) : haxe.ds.Map<String, nanofl.ide.plugins.IImporterPlugin>;
	static function register(plugin:nanofl.ide.plugins.IImporterPlugin):Void;
	static function getByExtension(ext:String):nanofl.ide.plugins.IImporterPlugin;
}
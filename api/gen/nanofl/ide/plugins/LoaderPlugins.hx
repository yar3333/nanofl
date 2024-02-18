package nanofl.ide.plugins;

extern class LoaderPlugins {
	static var plugins(default, null) : haxe.ds.Map<String, nanofl.ide.plugins.ILoaderPlugin>;
	static function register(plugin:nanofl.ide.plugins.ILoaderPlugin):Void;
}
package nanofl.engine.plugins;

extern class FilterPlugins {
	static var plugins(default, null) : haxe.ds.Map<String, nanofl.engine.plugins.IFilterPlugin>;
	static function register(plugin:nanofl.engine.plugins.IFilterPlugin):Void;
}
package nanofl.engine.plugins;

@:expose
class FilterPlugins
{
	public static var plugins(default, null) = new Map<String, IFilterPlugin>();
	
	public static function register(plugin:IFilterPlugin)
	{
		plugins.set(plugin.name, plugin);
	}
}
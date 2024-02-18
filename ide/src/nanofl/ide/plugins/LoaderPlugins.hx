package nanofl.ide.plugins;

class LoaderPlugins
{
	public static var plugins(default, null) = new Map<String, ILoaderPlugin>();
	
	public static function register(plugin:ILoaderPlugin)
	{
		plugins.set(plugin.name, plugin);
	}
}
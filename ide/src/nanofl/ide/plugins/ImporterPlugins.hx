package nanofl.ide.plugins;

using stdlib.Lambda;

class ImporterPlugins
{
	public static var plugins(default, null) = new Map<String, IImporterPlugin>();
	
	public static function register(plugin:IImporterPlugin)
	{
		plugins.set(plugin.name, plugin);
	}
	
	public static function getByExtension(ext:String) : IImporterPlugin
	{
		var names = plugins.keys().sorted();
		var name = names.find(x -> plugins.get(x).fileFilterExtensions.has(ext));
		return name != null ? plugins.get(name) : null;
	}
}
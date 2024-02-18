package nanofl.ide.plugins;

using stdlib.Lambda;

class ExporterPlugins
{
	public static var plugins(default, null) = new Map<String, IExporterPlugin>();
	
	public static function register(plugin:IExporterPlugin)
	{
		plugins.set(plugin.name, plugin);
	}
	
	public static function getByExtension(ext:String) : IExporterPlugin
	{
		var names = plugins.keys().sorted();
		var name = names.find(x -> plugins.get(x).fileFilterExtensions.has(ext));
		return name != null ? plugins.get(name) : null;
	}
}
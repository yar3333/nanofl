import nanofl.ide.plugins.ExporterPlugins;

class Main
{
	static function main() 
	{
		ExporterPlugins.register(new WebmVideoExporterPlugin());
	}
}
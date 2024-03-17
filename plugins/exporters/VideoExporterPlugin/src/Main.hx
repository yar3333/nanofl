import nanofl.ide.plugins.ExporterPlugins;

class Main
{
	static function main() 
	{
		ExporterPlugins.register(new Mp4VideoExporterPlugin());
		ExporterPlugins.register(new WebmVideoExporterPlugin());
	}
}
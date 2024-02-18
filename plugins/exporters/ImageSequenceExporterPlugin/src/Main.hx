import nanofl.ide.plugins.ExporterPlugins;

class Main
{
	static function main() 
	{
		ExporterPlugins.register(new PngImageSequenceExporterPlugin());
		ExporterPlugins.register(new JpegImageSequenceExporterPlugin());
	}
}
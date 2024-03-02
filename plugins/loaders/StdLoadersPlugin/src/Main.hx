import nanofl.ide.plugins.LoaderPlugins;

class Main
{
	static function main()
	{
		LoaderPlugins.register(new BitmapLoaderPlugin());
		LoaderPlugins.register(new FontLoaderPlugin());
		LoaderPlugins.register(new SoundLoaderPlugin());
		LoaderPlugins.register(new MovieClipLoaderPlugin());
		LoaderPlugins.register(new MeshLoaderPlugin());
		LoaderPlugins.register(new VideoLoaderPlugin());
	}
}
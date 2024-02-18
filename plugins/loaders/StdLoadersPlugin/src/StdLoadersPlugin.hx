import nanofl.ide.plugins.LoaderPlugins;

class StdLoadersPlugin
{
	static function main()
	{
		LoaderPlugins.register(new BitmapLoaderPlugin());
		LoaderPlugins.register(new FontLoaderPlugin());
		LoaderPlugins.register(new SoundLoaderPlugin());
		LoaderPlugins.register(new MovieClipLoaderPlugin());
		LoaderPlugins.register(new SpriteLoaderPlugin());
		LoaderPlugins.register(new MeshLoaderPlugin());
	}
}
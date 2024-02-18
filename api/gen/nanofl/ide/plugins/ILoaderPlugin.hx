package nanofl.ide.plugins;

interface ILoaderPlugin {
	/**
		
			 * Internal name (for example: "Blender3DLoader", "CreateJSTextureAtlasLoader").
			 
	**/
	var name : String;
	/**
		
			 * Used to determine the order of your plugin in load queue.
			 * Use 0 if you want load() called at the end (if you load simple files).
			 * Use 1000 if you want load() called at the begin (if your loader is complex).
			 
	**/
	var priority : Int;
	/**
		
			 * Like "Blender".
			 
	**/
	var menuItemName : String;
	/**
		
			 * Css class or image url in "url(pathToImage)" format.
			 
	**/
	var menuItemIcon : String;
	/**
		
			 * Custom properties for tune by user. Can be null or empty array if there are no customizable parameters.
			 
	**/
	var properties : Array<nanofl.engine.CustomProperty>;
	/**
		
			 * Method must detect loadable files and return created LibraryItems.
			 * Use file.exclude() for processed files (to prevent loading them from other loaders).
			 
	**/
	function load(api:nanofl.ide.plugins.PluginApi, params:Dynamic, baseDir:String, files:Map<String, nanofl.ide.filesystem.CachedFile>):js.lib.Promise<Array<nanofl.ide.libraryitems.IIdeLibraryItem>>;
}
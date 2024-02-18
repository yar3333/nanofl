package nanofl.ide.plugins;

import js.lib.Promise;
import haxe.io.Path;
import nanofl.engine.CustomProperty;
import nanofl.ide.DocumentProperties;
import nanofl.ide.library.IdeLibrary;

@:expose
interface IImporterPlugin
{
	/**
	 * Internal name (for example: "FlashImporter", "SvgImporter").
	 */
	var name : String;
	
	/**
	 * Like "Adobe Flash Document (*.fla)".
	 */
	var menuItemName : String;
	
	/**
	 * Css class or image url in "url(pathToImage)" format.
	 */
	var menuItemIcon : String;
	
	/**
	 * Like "Flash document".
	 */
	var fileFilterDescription : String;
	
	/**
	 * Like [ "fla", "xfl" ].
	 */
	var fileFilterExtensions : Array<String>;
	
	/**
	 * Custom properties for tune by user. Can be null or empty array if there are no customizable parameters.
	 */
	var properties : Array<CustomProperty>;
	
	/**
	 * This method must import document.
	 * @param	params				Custom parameters specified by user (produced from `properties`).
	 * @param	srcFilePath			Path to supported file (one of the `fileFilterExtensions`).
	 * @param	destFilePath		Path to `*.nfl` file.
	 * @param	documentProperties	Properties of the document.
	 * @param	library				Document's library.
	 * @param	callb				Call this after importing with a success bool flag.
	 */
	function importDocument(api:PluginApi, params:Dynamic, srcFilePath:String, destFilePath:String, documentProperties:DocumentProperties, library:IdeLibrary) : Promise<Bool>;
	
	function getPublishPath(originalPath:String) : String;
}

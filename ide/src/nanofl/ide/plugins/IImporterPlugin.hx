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
	 */
	function importDocument(api:PluginApi, args:ImporterArgs) : Promise<Bool>;
	
	function getPublishPath(originalPath:String) : String;
}

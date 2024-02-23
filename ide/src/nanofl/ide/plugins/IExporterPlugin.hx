package nanofl.ide.plugins;

import js.lib.Promise;
import nanofl.engine.CustomProperty;

@:expose
interface IExporterPlugin
{
	/**
	 * Internal name (for example: "FlashExporter", "SvgExporter").
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
	 * This method must export document.
	 */
    function exportDocument(api:PluginApi, args:ExporterArgs) : Promise<Bool>;
}
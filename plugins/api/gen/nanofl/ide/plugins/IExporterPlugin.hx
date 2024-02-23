package nanofl.ide.plugins;

interface IExporterPlugin {
	/**
		
			 * Internal name (for example: "FlashExporter", "SvgExporter").
			 
	**/
	var name : String;
	/**
		
			 * Like "Adobe Flash Document (*.fla)".
			 
	**/
	var menuItemName : String;
	/**
		
			 * Css class or image url in "url(pathToImage)" format.
			 
	**/
	var menuItemIcon : String;
	/**
		
			 * Like "Flash document".
			 
	**/
	var fileFilterDescription : String;
	/**
		
			 * Like [ "fla", "xfl" ].
			 
	**/
	var fileFilterExtensions : Array<String>;
	/**
		
			 * Custom properties for tune by user. Can be null or empty array if there are no customizable parameters.
			 
	**/
	var properties : Array<nanofl.engine.CustomProperty>;
	/**
		
			 * This method must export document.
			 
	**/
	function exportDocument(api:nanofl.ide.plugins.PluginApi, args:nanofl.ide.plugins.ExporterArgs):js.lib.Promise<Bool>;
}
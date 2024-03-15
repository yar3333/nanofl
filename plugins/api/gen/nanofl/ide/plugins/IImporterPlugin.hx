package nanofl.ide.plugins;

interface IImporterPlugin {
	/**
		
			 * Internal name (for example: "FlashImporter", "SvgImporter").
			 
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
		
			 * This method must import document.
			 
	**/
	function importDocument(api:nanofl.ide.plugins.PluginApi, args:nanofl.ide.plugins.ImporterArgs):js.lib.Promise<Bool>;
	/**
		
		        Used to detect output path on document publish.
		        Must return path to destination directory without ".release" suffix.
		    
	**/
	function getPublishDirectoryBasePath(originalPath:String):String;
}
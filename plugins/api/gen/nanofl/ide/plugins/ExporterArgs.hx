package nanofl.ide.plugins;

typedef ExporterArgs = {
	/**
		
		        Path to destination file (one of the `fileFilterExtensions` of the plugin).
		    
	**/
	var destFilePath : String;
	var documentProperties : nanofl.ide.DocumentProperties;
	var library : nanofl.ide.library.IdeLibrary;
	/**
		
		        Custom parameters specified by user (produced from `properties` of the plugin).
		    
	**/
	var params : Dynamic;
	/**
		
		        Path to `*.nfl` file.
		    
	**/
	var srcFilePath : String;
};
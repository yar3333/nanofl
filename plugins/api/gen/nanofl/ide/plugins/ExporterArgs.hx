package nanofl.ide.plugins;

typedef ExporterArgs = {
	/**
		
		        Path to destination file.
		    
	**/
	var destFilePath(default, null) : String;
	var documentProperties(default, null) : nanofl.ide.DocumentProperties;
	var library(default, null) : nanofl.ide.library.IdeLibrary;
	/**
		
		        Path to originally opened file (if document imported or saved via plugin).
		        If native `*.nfl` opened then `originalFilePath` is `null`.
		    
	**/
	var originalFilePath(default, null) : String;
	/**
		
		        Custom parameters specified by user (produced from `properties` of the plugin).
		    
	**/
	var params(default, null) : Dynamic;
	/**
		
		        Call this from exporter plugin to show current stage on progress popup.
		    
	**/
	function setProgressInfo(text:String):Void;
	/**
		
		        Call this from exporter plugin to show current percent on progress popup.
		    
	**/
	function setProgressPercent(percent:Int):Void;
	/**
		
		        Path to `*.nfl` file.
		    
	**/
	var srcFilePath(default, null) : String;
	/**
		
		        Check this during exporting.
		    
	**/
	var wantToCancel : Bool;
};
package nanofl.ide.plugins;

typedef ExporterArgs =
{
    /**
        Custom parameters specified by user (produced from `properties` of the plugin).
    **/
    var params : Dynamic;
    
    /**
        Path to `*.nfl` file.
    **/
    var srcFilePath : String;
    
    /**
        Path to destination file (one of the `fileFilterExtensions` of the plugin).
    **/
    var destFilePath : String;
    
    var documentProperties : DocumentProperties;
    
    var library : nanofl.ide.library.IdeLibrary;
}
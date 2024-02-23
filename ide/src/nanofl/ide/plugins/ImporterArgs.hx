package nanofl.ide.plugins;

typedef ImporterArgs =
{
    /**
        Custom parameters specified by user (produced from `properties` of the plugin ).
    **/
    var params : Dynamic;

    /**
        Path to file, selected by user (file type is one of the `fileFilterExtensions`).
    **/
    var srcFilePath : String;
    
    /**
        Path to `*.nfl` file.
    **/
    var destFilePath : String;

    var documentProperties : DocumentProperties;
    
    var library : nanofl.ide.library.IdeLibrary;
}
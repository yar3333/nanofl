package nanofl.ide.plugins;

typedef ExporterArgs =
{
    /**
        Custom parameters specified by user (produced from `properties` of the plugin).
    **/
    var params(default, null) : Dynamic;
    
    /**
        Path to `*.nfl` file.
    **/
    var srcFilePath(default, null) : String;
    
    /**
        Path to destination file.
    **/
    var destFilePath(default, null) : String;
    
    var documentProperties(default, null) : DocumentProperties;
    
    var library(default, null) : nanofl.ide.library.IdeLibrary;

    /**
        Path to originally opened file (if document imported or saved via plugin).
        If native `*.nfl` opened then `originalFilePath` is `null`.
    **/
    var originalFilePath(default, null) : String;

    /**
        Call this from exporter plugin to show current percent on progress popup.
    **/
    function setProgressPercent(percent:Int) : Void;
    
    /**
        Call this from exporter plugin to show current stage on progress popup.
    **/
    function setProgressInfo(text:String) : Void;
}
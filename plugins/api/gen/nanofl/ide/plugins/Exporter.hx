package nanofl.ide.plugins;

extern class Exporter {
	function new(pluginName:String, params:Dynamic):Void;
	var pluginName(default, null) : String;
	var params(default, null) : Dynamic;
	function run(srcFilePath:String, destFilePath:String, documentProperties:nanofl.ide.DocumentProperties, library:nanofl.ide.library.IdeLibrary):Bool;
}
package nanofl.ide.plugins;

extern class Exporter {
	function new(pluginName:String, params:Dynamic):Void;
	var pluginName(default, null) : String;
	var params(default, null) : Dynamic;
	function run(document:nanofl.ide.Document, path:String, popups:nanofl.ide.ui.Popups):js.lib.Promise<Bool>;
}
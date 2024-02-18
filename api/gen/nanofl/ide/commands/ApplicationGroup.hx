package nanofl.ide.commands;

extern class ApplicationGroup extends nanofl.ide.commands.BaseGroup {
	function new():Void;
	function preferences():Void;
	function reloadPlugins():Void;
	function showHotkeys():Void;
	function about():Void;
	function quit():Void;
	function openFile(path:String):Void;
}
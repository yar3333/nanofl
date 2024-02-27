package nanofl.ide.sys;

interface Shell {
	function openInExternalBrowser(url:String):Void;
	function runWithEditor(document:String):Bool;
}
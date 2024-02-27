package nanofl.ide.sys;

@:rtti
interface Shell
{
	function openInExternalBrowser(url:String) : Void;
	function runWithEditor(document:String) : Bool;
}
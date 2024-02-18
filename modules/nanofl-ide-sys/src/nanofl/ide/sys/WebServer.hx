package nanofl.ide.sys;

@:rtti
interface WebServer
{
	function openInBrowser(path:String) : Void;
}
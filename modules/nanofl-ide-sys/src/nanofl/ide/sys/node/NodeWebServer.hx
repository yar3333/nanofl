package nanofl.ide.sys.node;

import nanofl.ide.sys.WebServer;

class NodeWebServer implements WebServer
{
	public function new() {}
	
	public function openInBrowser(path:String) : Void
	{
		var url = "file://" + path;
		log("URL = " + url);
		js.Browser.window.open(url, "_blank");
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		haxe.Log.trace(v, infos);
	}
}
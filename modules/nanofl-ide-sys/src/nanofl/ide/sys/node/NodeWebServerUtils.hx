package nanofl.ide.sys.node;

import nanofl.ide.sys.node.core.ElectronApi;
import nanofl.ide.sys.WebServerUtils;

class NodeWebServerUtils implements WebServerUtils
{
	public function new() {}

    public function start(directoryToServe:String) : Int
    {
        static var uid = 0;
        uid++;
        ElectronApi.webServerStart(uid, directoryToServe);
        return uid;
    }

    public function getAddress(pid:Int) : String
    {
        return ElectronApi.webServerGetAddress(pid);
    }

    public function kill(pid:Int) : Void
    {
        ElectronApi.webServerKill(pid);
    }
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
    {
        haxe.Log.trace(v, infos);
    }
}
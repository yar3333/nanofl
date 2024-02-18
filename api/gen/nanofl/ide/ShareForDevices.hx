package nanofl.ide;

extern class ShareForDevices extends nanofl.ide.InjectContainer {
	function new():Void;
	function sendToService(dir:String):js.lib.Promise<{ public var statusCode(default, default) : Int; }>;
	function generateNewLinkID():Void;
}
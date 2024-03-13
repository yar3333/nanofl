package nanofl.ide;

extern class AsyncTicker {
	function new(framerate:Float, tickFunc:() -> js.lib.Promise<{ }>):Void;
	function stop():Void;
}
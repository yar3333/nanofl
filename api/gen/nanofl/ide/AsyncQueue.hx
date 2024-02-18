package nanofl.ide;

extern class AsyncQueue {
	function new():Void;
	var running(default, null) : Bool;
	function add(label:String, f:(() -> Void) -> Void):Void;
}
package nanofl.ide;

extern class CommandLine extends nanofl.ide.InjectContainer {
	function new():Void;
	function process(callb:Int -> Void):Void;
}
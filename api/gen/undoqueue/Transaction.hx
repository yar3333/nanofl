package undoqueue;

extern class Transaction<Operation:(EnumValue)> {
	var operations(default, null) : Array<Operation>;
	function add(operation:Operation):Void;
	function redo():Void;
	function undo():Void;
	function getReversed():undoqueue.Transaction<Operation>;
	function toString():String;
}
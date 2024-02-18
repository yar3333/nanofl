package nanofl.ide.commands;

extern class OpenedFileGroup extends nanofl.ide.commands.BaseGroup {
	function new():Void;
	function save():Void;
	function undo():Void;
	function redo():Void;
	function cut():Void;
	function copy():Void;
	function paste():Void;
	function toggleSelection():Void;
	function deselectAll():Void;
}
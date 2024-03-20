package nanofl.ide.commands;

extern class ClipboardGroup extends nanofl.ide.commands.BaseGroup {
	function new():Void;
	function cut():Void;
	function copy():Void;
	function paste():Void;
}
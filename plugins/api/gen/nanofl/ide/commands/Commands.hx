package nanofl.ide.commands;

extern class Commands {
	function new():Void;
	var application(get, never) : nanofl.ide.commands.ApplicationGroup;
	private function get_application():nanofl.ide.commands.ApplicationGroup;
	var document(get, never) : nanofl.ide.commands.DocumentGroup;
	private function get_document():nanofl.ide.commands.DocumentGroup;
	var editor(get, never) : nanofl.ide.commands.EditorGroup;
	private function get_editor():nanofl.ide.commands.EditorGroup;
	var library(get, never) : nanofl.ide.commands.LibraryGroup;
	private function get_library():nanofl.ide.commands.LibraryGroup;
	var timeline(get, never) : nanofl.ide.commands.TimelineGroup;
	private function get_timeline():nanofl.ide.commands.TimelineGroup;
	var clipboard(get, never) : nanofl.ide.commands.ClipboardGroup;
	private function get_clipboard():nanofl.ide.commands.ClipboardGroup;
	function validateCommand(command:String):Void;
	function run(command:String, ?params:Array<Dynamic>):Bool;
}
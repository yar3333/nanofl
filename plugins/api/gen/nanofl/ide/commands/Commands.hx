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
	var output(get, never) : nanofl.ide.commands.OutputGroup;
	private function get_output():nanofl.ide.commands.OutputGroup;
	var openedFile(get, never) : nanofl.ide.commands.OpenedFileGroup;
	private function get_openedFile():nanofl.ide.commands.OpenedFileGroup;
	var code(get, never) : nanofl.ide.commands.CodeGroup;
	private function get_code():nanofl.ide.commands.CodeGroup;
	function validateCommand(command:String):Void;
	function run(command:String, ?params:Array<Dynamic>):Bool;
}
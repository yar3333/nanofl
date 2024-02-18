package nanofl.ide;

extern class OpenedFile extends nanofl.ide.InjectContainer {
	/**
		
			 * Document UUID (generated on every document object create).
			 
	**/
	var id(default, null) : String;
	var isModified(get, never) : Bool;
	private function get_isModified():Bool;
	function getPath():String;
	function getLongTitle():String;
	function getShortTitle():String;
	function getIcon():String;
	function getTabTextColor():String;
	function getTabBackgroundColor():String;
	function activate(?isCenterView:Bool):Void;
	function deactivate():Void;
	var relatedDocument : nanofl.ide.Document;
	var type(get, never) : nanofl.ide.OpenedFileType;
	private function get_type():nanofl.ide.OpenedFileType;
	function saveWithPrompt():js.lib.Promise<Bool>;
	function close(?force:Bool):js.lib.Promise<{ }>;
	function undoStatusChanged():Void;
	function save():js.lib.Promise<Bool>;
	function undo():Void;
	function redo():Void;
	function dispose():Void;
	function toggleSelection():Void;
	function deselectAll():Void;
	function canBeSaved():Bool;
	function canUndo():Bool;
	function canRedo():Bool;
	function canCut():Bool;
	function canCopy():Bool;
	function canPaste():Bool;
}
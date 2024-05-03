package nanofl.ide;

extern class Document extends nanofl.ide.InjectContainer {
	function new(path:String, properties:nanofl.ide.DocumentProperties, library:nanofl.ide.library.IdeLibrary, ?lastModified:Date):Void;
	/**
		
			 * Document UUID (generated on every document object create).
			 
	**/
	var id(default, null) : String;
	/**
		
			 * Used when document was opened from none-NanoFL format. In other cases is null.
			 
	**/
	var originalPath(default, null) : String;
	/**
		
			 * Used when document was opened from none-NanoFL format. In other cases is null.
			 
	**/
	var originalLastModified(default, null) : Date;
	/**
		
			 * Path to NanoFL document file (*.nfl).
			 
	**/
	var path(default, null) : String;
	var properties(default, null) : nanofl.ide.DocumentProperties;
	var library(default, null) : nanofl.ide.editor.EditorLibrary;
	var lastModified(default, null) : Date;
	var navigator(default, null) : nanofl.ide.navigator.Navigator;
	var editor(default, null) : nanofl.ide.editor.Editor;
	var undoQueue(default, null) : nanofl.ide.undo.document.UndoQueue;
	function getTabTextColor():String;
	function getTabBackgroundColor():String;
	var isModified(get, never) : Bool;
	function activate(?isCenterView:Bool):Void;
	function deactivate():Void;
	function setProperties(properties:nanofl.ide.DocumentProperties):Void;
	private function get_isModified():Bool;
	function save(?force:Bool):js.lib.Promise<Bool>;
	function saveAs(?newPath:String, ?force:Bool):js.lib.Promise<Bool>;
	function export(?destPath:String, ?plugin:nanofl.ide.plugins.IExporterPlugin):js.lib.Promise<Bool>;
	function reload():js.lib.Promise<{ public var removed(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; public var added(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; }>;
	function reloadWoTransactionForced():js.lib.Promise<{ public var removed(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; public var added(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; }>;
	function test():js.lib.Promise<Bool>;
	function publish():js.lib.Promise<Bool>;
	function resize(width:Int, height:Int):Void;
	function canBeSaved():Bool;
	function dispose():Void;
	function saveNative(?force:Bool):Bool;
	function getShortTitle():String;
	function getPath():String;
	function getLongTitle():String;
	function getIcon():String;
	function toggleSelection():Void;
	function deselectAll():Void;
	function undo():Void;
	function redo():Void;
	function canUndo():Bool;
	function canRedo():Bool;
	function canCut():Bool;
	function canCopy():Bool;
	function canPaste():Bool;
	function saveWithPrompt():js.lib.Promise<Bool>;
	function close(?force:Bool):js.lib.Promise<Bool>;
	function undoStatusChanged():Void;
}
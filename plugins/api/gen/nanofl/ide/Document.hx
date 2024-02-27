package nanofl.ide;

extern class Document extends nanofl.ide.OpenedFile {
	function new(path:String, properties:nanofl.ide.DocumentProperties, library:nanofl.ide.library.IdeLibrary, ?lastModified:Date):Void;
	var allowAutoReloading(default, null) : Bool;
	/**
		
			 * Used when document was opened directly from none-NanoFL format. In other cases is null.
			 
	**/
	var originalPath(default, null) : String;
	/**
		
			 * Used when document was opened directly from none-NanoFL format. In other cases is null.
			 
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
	var isTemporary(get, never) : Bool;
	private function get_isTemporary():Bool;
	override function getTabTextColor():String;
	override function getTabBackgroundColor():String;
	override function activate(?isCenterView:Bool):Void;
	override function deactivate():Void;
	function setProperties(properties:nanofl.ide.DocumentProperties):Void;
	override function save(?force:Bool):js.lib.Promise<Bool>;
	function saveAs(?newPath:String, ?force:Bool):js.lib.Promise<Bool>;
	function export(?destPath:String, ?plugin:nanofl.ide.plugins.IExporterPlugin):js.lib.Promise<Bool>;
	function reload():js.lib.Promise<{ public var removed(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; public var added(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; }>;
	function reloadWoTransactionForced():js.lib.Promise<{ public var removed(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; public var added(default, default) : Array<nanofl.ide.libraryitems.IIdeLibraryItem>; }>;
	function test():js.lib.Promise<Bool>;
	function publish():js.lib.Promise<Bool>;
	function resize(width:Int, height:Int):Void;
	override function canBeSaved():Bool;
	override function dispose():Void;
	function saveNative(?force:Bool):Bool;
	function runPreventingAutoReload<T>(f:() -> js.lib.Promise<T>):js.lib.Promise<T>;
	override function getShortTitle():String;
	override function getPath():String;
	override function getLongTitle():String;
	override function getIcon():String;
	override function toggleSelection():Void;
	override function deselectAll():Void;
	override function undo():Void;
	override function redo():Void;
	override function canUndo():Bool;
	override function canRedo():Bool;
	override function canCut():Bool;
	override function canCopy():Bool;
	override function canPaste():Bool;
	static function createTemporary(openedFiles:nanofl.ide.OpenedFiles, folders:nanofl.ide.sys.Folders, ?properties:nanofl.ide.DocumentProperties):nanofl.ide.Document;
	static function load(fileSystem:nanofl.ide.sys.FileSystem, openedFiles:nanofl.ide.OpenedFiles, preferences:nanofl.ide.preferences.Preferences, folders:nanofl.ide.sys.Folders, view:nanofl.ide.ui.View, path:String):js.lib.Promise<nanofl.ide.Document>;
	static function loadRaw(fileSystem:nanofl.ide.sys.FileSystem, path:String, lastModified:Date):js.lib.Promise<{ public var properties(default, default) : nanofl.ide.DocumentProperties; public var library(default, default) : nanofl.ide.library.IdeLibrary; public var lastModified(default, default) : Date; }>;
	static function import_(preferences:nanofl.ide.preferences.Preferences, openedFiles:nanofl.ide.OpenedFiles, folders:nanofl.ide.sys.Folders, view:nanofl.ide.ui.View, path:String, ?importer:nanofl.ide.plugins.Importer):js.lib.Promise<nanofl.ide.Document>;
}
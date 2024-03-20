package nanofl.ide;

extern class Clipboard extends nanofl.ide.InjectContainer {
	function new():Void;
	function canCut():Bool;
	function canCopy():Bool;
	function canPaste():Bool;
	function cut():Bool;
	function copy():Bool;
	function paste():Bool;
	function restoreFocus(?e:js.html.MouseEvent):Void;
	function loadFilesFromClipboard(destDir:String):Void;
	function saveFilesIntoClipboard(baseDir:String, relativePaths:Array<String>):Void;
}
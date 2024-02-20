package nanofl.ide.commands;

extern class LibraryGroup extends nanofl.ide.commands.BaseGroup {
	function new():Void;
	function newEmptyMovieClip():Void;
	function newFolder():Void;
	function addFontManually():Void;
	function importFiles():Void;
	function remove():Void;
	function deselectAll():Void;
	function rename():Void;
	function gotoPrev():Void;
	function gotoNext():Void;
	function gotoPrevExtSelect():Void;
	function gotoNextExtSelect():Void;
	function optimize():Void;
	function removeUnused():Void;
	function selectUnused():Void;
	function importFont():Void;
	function importImages():Void;
	function importSounds():Void;
	function importMeshes():Void;
	function properties():Void;
	function createFolder():Void;
	function cut():Void;
	function copy():Void;
	function paste():Void;
}
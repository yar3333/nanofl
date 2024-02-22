package nanofl.engine;

interface ILibraryItem {
	var library(default, null) : nanofl.engine.Library;
	var namePath : String;
	var type(get, never) : nanofl.engine.LibraryItemType;
	function getIcon():String;
	function clone():nanofl.engine.ILibraryItem;
	function preload():js.lib.Promise<{ }>;
	function loadPropertiesJson(obj:Dynamic):Void;
	function setLibrary(library:nanofl.engine.Library):Void;
	function duplicate(newNamePath:String):nanofl.engine.ILibraryItem;
	function remove():Void;
	function equ(item:nanofl.engine.ILibraryItem):Bool;
	function toString():String;
}
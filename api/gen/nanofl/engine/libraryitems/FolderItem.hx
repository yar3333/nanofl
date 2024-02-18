package nanofl.engine.libraryitems;

extern class FolderItem extends nanofl.engine.libraryitems.LibraryItem {
	function new(namePath:String):Void;
	var opened : Bool;
	override function clone():nanofl.engine.libraryitems.FolderItem;
	override function getIcon():String;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function preload():js.lib.Promise<{ }>;
	override function loadPropertiesJson(obj:Dynamic):Void;
	override function toString():String;
}
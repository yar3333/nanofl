package nanofl.engine.libraryitems;

extern class SoundItem extends nanofl.engine.libraryitems.LibraryItem {
	function new(namePath:String, ext:String):Void;
	var ext : String;
	var linkage : String;
	override function clone():nanofl.engine.libraryitems.SoundItem;
	override function getIcon():String;
	function getUrl():String;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function preload():js.lib.Promise<{ }>;
	override function loadPropertiesJson(obj:Dynamic):Void;
	override function toString():String;
}
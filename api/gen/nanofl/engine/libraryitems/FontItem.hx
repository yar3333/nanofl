package nanofl.engine.libraryitems;

extern class FontItem extends nanofl.engine.libraryitems.LibraryItem {
	function new(namePath:String, ?variants:Array<nanofl.engine.FontVariant>):Void;
	var variants : Array<nanofl.engine.FontVariant>;
	override function clone():nanofl.engine.libraryitems.FontItem;
	override function getIcon():String;
	function toFont():nanofl.engine.Font;
	override function preload():js.lib.Promise<{ }>;
	function addVariant(v:nanofl.engine.FontVariant):Void;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function loadPropertiesJson(obj:Dynamic):Void;
	override function toString():String;
}
package nanofl;

extern class Bitmap extends easeljs.display.Bitmap {
	function new(symbol:nanofl.engine.libraryitems.InstancableItem):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.InstancableItem;
	override function clone(?recursive:Bool):nanofl.Bitmap;
	override function toString():String;
}
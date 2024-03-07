package nanofl;

extern class Bitmap extends easeljs.display.Bitmap implements nanofl.engine.InstanceDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.BitmapItem):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.BitmapItem;
	override function clone(?recursive:Bool):nanofl.Bitmap;
	override function toString():String;
}
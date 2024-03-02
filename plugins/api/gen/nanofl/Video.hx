package nanofl;

extern class Video extends nanofl.SolidContainer {
	function new(symbol:nanofl.engine.libraryitems.VideoItem):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.VideoItem;
	var video : js.html.VideoElement;
	override function clone(?recursive:Bool):nanofl.MovieClip;
	override function toString():String;
}
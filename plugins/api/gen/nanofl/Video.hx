package nanofl;

extern class Video extends nanofl.SolidContainer implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.VideoItem):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.VideoItem;
	var video : js.html.VideoElement;
	var currentFrame(default, null) : Int;
	override function clone(?recursive:Bool):nanofl.MovieClip;
	override function toString():String;
	function advance():js.lib.Promise<{ }>;
}
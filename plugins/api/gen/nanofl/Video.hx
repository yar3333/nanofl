package nanofl;

extern class Video extends nanofl.SolidContainer implements nanofl.engine.AdvancableDisplayObject implements nanofl.engine.InstanceDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.VideoItem):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.VideoItem;
	var video(default, null) : js.html.VideoElement;
	var currentFrame(default, null) : Int;
	var duration(default, null) : Float;
	override function clone(?recursive:Bool):nanofl.MovieClip;
	override function toString():String;
	function advance(?time:Float):Void;
}
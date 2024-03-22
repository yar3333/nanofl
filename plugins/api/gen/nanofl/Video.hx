package nanofl;

typedef VideoParams = {
	@:optional
	var currentTime : Float;
};

extern class Video extends nanofl.SolidContainer implements nanofl.engine.InstanceDisplayObject {
	function new(symbol:nanofl.engine.libraryitems.VideoItem, params:nanofl.Video.VideoParams):Void;
	var symbol(default, null) : nanofl.engine.libraryitems.VideoItem;
	var duration : Float;
	override function clone(?recursive:Bool):nanofl.Video;
	override function toString():String;
}
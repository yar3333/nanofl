package nanofl.ide.displayobjects;

extern class IdeVideo extends nanofl.Video implements nanofl.ide.IdeAdvancableDisplayObject {
	function new(symbol:nanofl.ide.libraryitems.VideoItem, params:nanofl.Video.VideoParams):Void;
	var currentTime : Float;
	function waitLoading():js.lib.Promise<{ }>;
	function advanceTo(advanceFrames:Int, framerate:Float, tweenedElement:nanofl.engine.movieclip.TweenedElement):Void;
	override function clone(?recursive:Bool):nanofl.Video;
}
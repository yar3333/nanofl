package nanofl.engine;

extern class MovieClipGotoHelper {
	@:access(nanofl.MovieClip.currentFrame)
	function new(mc:nanofl.MovieClip, newFrameIndex:Int, framerate:Float):Void;
	var createdDisplayObjects : Array<easeljs.display.DisplayObject>;
	function processLayer(layer:nanofl.engine.movieclip.Layer):Void;
}
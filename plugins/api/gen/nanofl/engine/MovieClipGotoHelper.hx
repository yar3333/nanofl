package nanofl.engine;

extern class MovieClipGotoHelper {
	@:access(nanofl.MovieClip.currentFrame)
	function new(mc:nanofl.MovieClip, newFrameIndex:Int):Void;
	var createdDisplayObjects : Array<easeljs.display.DisplayObject>;
	var keepedAdvancableChildren : Array<nanofl.engine.AdvancableDisplayObject>;
	function processLayer(layer:nanofl.engine.movieclip.Layer):Bool;
}
package nanofl.engine;

extern class MovieClipGotoHelper {
	function new(mc:nanofl.MovieClip, newFrameIndex:Int):Void;
	var createdDisplayObjects : Array<easeljs.display.DisplayObject>;
	var keepedAdvancableChildren : Array<nanofl.engine.AdvancableDisplayObject>;
	function processLayer(layerIndex:Int):Void;
}
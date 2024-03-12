package nanofl.ide.displayobjects;

extern class IdeVideo extends nanofl.Video implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.ide.libraryitems.VideoItem, params:nanofl.Video.VideoParams):Void;
	function advanceToNextFrame(framerate:Float):Void;
	function advanceTo(advanceFrames:Int):Void;
}
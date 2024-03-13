package nanofl.ide.displayobjects;

extern class IdeVideo extends nanofl.Video implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.ide.libraryitems.VideoItem, params:nanofl.Video.VideoParams):Void;
	function advanceToNextFrame():Void;
	function advanceTo(advanceFrames:Int, framerate:Float):Void;
}
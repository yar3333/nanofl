package nanofl.engine;

interface AdvancableDisplayObject {
	function advanceToNextFrame(framerate:Float):Void;
	function advanceTo(advanceFrames:Int):Void;
}
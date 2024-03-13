package nanofl.engine;

interface AdvancableDisplayObject {
	function advanceToNextFrame():Void;
	function advanceTo(advanceFrames:Int, framerate:Float):Void;
}
package nanofl.ide;

interface IdeAdvancableDisplayObject {
	function advanceTo(advanceFrames:Int, framerate:Float, element:nanofl.engine.movieclip.TweenedElement):Void;
}
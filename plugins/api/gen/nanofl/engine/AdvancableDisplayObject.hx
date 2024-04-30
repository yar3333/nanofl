package nanofl.engine;

interface AdvancableDisplayObject {
	function advanceTo(lifetimeOnParent:Int, element:nanofl.engine.movieclip.TweenedElement, framerate:Float):Void;
}
package nanofl.ide.displayobjects;

extern class IdeVideo extends nanofl.Video implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.ide.libraryitems.VideoItem, params:nanofl.Video.VideoParams):Void;
	var currentTime : Float;
	function waitLoading():js.lib.Promise<{ }>;
	function advanceTo(lifetimeOnParent:Int, tweenedElement:nanofl.engine.movieclip.TweenedElement, framerate:Float):Void;
	override function clone(?recursive:Bool):nanofl.Video;
}
package nanofl.ide.displayobjects;

extern class IdeVideo extends nanofl.Video implements nanofl.engine.AdvancableDisplayObject {
	function new(symbol:nanofl.ide.libraryitems.VideoItem, params:nanofl.Video.VideoParams):Void;
	var currentTime : Float;
	function waitLoading():js.lib.Promise<{ }>;
	function advanceToNextFrame():Void;
	function advanceTo(advanceFrames:Int, framerate:Float, tweenedElement:nanofl.engine.movieclip.TweenedElement):Void;
	override function clone(?recursive:Bool):nanofl.Video;
	override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
}
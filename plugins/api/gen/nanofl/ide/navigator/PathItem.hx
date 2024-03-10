package nanofl.ide.navigator;

extern class PathItem {
	function new(instance:nanofl.engine.elements.Instance, ?layerIndex:Int, ?frameIndex:Int):Void;
	var instance : nanofl.engine.elements.Instance;
	var mcItem : nanofl.ide.libraryitems.MovieClipItem;
	var layerIndex(default, null) : Int;
	var frameIndex(default, null) : Int;
	var layer(get, never) : nanofl.engine.movieclip.Layer;
	private function get_layer():nanofl.engine.movieclip.Layer;
	var frame(get, never) : nanofl.engine.movieclip.Frame;
	private function get_frame():nanofl.engine.movieclip.Frame;
	function setLayerIndex(n:Int):Void;
	function setFrameIndex(n:Int):Void;
	function getNavigatorIcon():String;
	function getNavigatorName():String;
	function isScene():Bool;
	function equ(p:nanofl.ide.navigator.PathItem):Bool;
	function getTotalFrames():Int;
	function clone():nanofl.ide.navigator.PathItem;
}
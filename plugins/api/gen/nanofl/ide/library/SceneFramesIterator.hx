package nanofl.ide.library;

extern class SceneFramesIterator {
	function hasNext():Bool;
	function next():js.lib.Promise<js.html.CanvasRenderingContext2D>;
}
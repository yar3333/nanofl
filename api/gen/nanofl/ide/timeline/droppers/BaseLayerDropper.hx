package nanofl.ide.timeline.droppers;

extern class BaseLayerDropper extends nanofl.ide.InjectContainer {
	function new():Void;
	function getDragImageType(data:htmlparser.HtmlNodeElement):nanofl.ide.draganddrop.DragImageType;
}
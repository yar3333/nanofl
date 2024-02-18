package nanofl.ide.timeline.droppers;

extern class LayerToLayerDropper extends nanofl.ide.timeline.droppers.BaseLayerDropper implements nanofl.ide.draganddrop.IDropArea {
	function new(content:js.JQuery):Void;
	function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, e:js.JQuery.JqEvent):Void;
}
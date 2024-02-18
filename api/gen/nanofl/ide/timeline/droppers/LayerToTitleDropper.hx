package nanofl.ide.timeline.droppers;

extern class LayerToTitleDropper extends nanofl.ide.timeline.droppers.BaseLayerDropper implements nanofl.ide.draganddrop.IDropArea {
	function new(layerRow:js.JQuery):Void;
	function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, e:js.JQuery.JqEvent):Void;
}
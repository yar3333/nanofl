package nanofl.ide.timeline.droppers;

extern class LayerToHeaderTitleDropper extends nanofl.ide.timeline.droppers.BaseLayerDropper implements nanofl.ide.draganddrop.IDropArea {
	function new():Void;
	function drop(dropEffect:nanofl.ide.draganddrop.DropEffect, data:htmlparser.HtmlNodeElement, e:js.JQuery.JqEvent):Void;
}
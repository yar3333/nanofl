package nanofl.ide.timeline.droppers;

import htmlparser.HtmlNodeElement;
import js.JQuery.JqEvent;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDropArea;
import nanofl.ide.timeline.droppers.BaseLayerDropper;

class LayerToHeaderTitleDropper
	extends BaseLayerDropper
	implements IDropArea
{
	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent)
	{
		moveLayer(Std.parseInt(data.getAttribute("layerIndex")), 0);
	}
}
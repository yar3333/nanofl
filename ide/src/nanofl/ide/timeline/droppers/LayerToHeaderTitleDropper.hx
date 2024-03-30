package nanofl.ide.timeline.droppers;

import js.JQuery;
import htmlparser.HtmlNodeElement;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.timeline.droppers.BaseLayerDropper;

class LayerToHeaderTitleDropper	extends BaseLayerDropper
{
	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent)
	{
		moveLayer(Std.parseInt(data.getAttribute("layerIndex")), 0);
	}
}
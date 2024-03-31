package nanofl.ide.timeline.droppers;

import js.JQuery;
import htmlparser.XmlDocument;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.timeline.droppers.BaseLayerDropper;

class LayerToHeaderTitleDropper	extends BaseLayerDropper
{
	function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent) : Void
	{
		moveLayer(Std.parseInt(data.getAttribute("layerIndex")), 0);
	}
}
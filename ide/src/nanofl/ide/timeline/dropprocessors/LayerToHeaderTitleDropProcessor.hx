package nanofl.ide.timeline.dropprocessors;

import js.JQuery;
import htmlparser.XmlDocument;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.timeline.dropprocessors.BaseLayerDropProcessor;

class LayerToHeaderTitleDropProcessor extends BaseLayerDropProcessor
{
	function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent) : Void
	{
		moveLayer(Std.parseInt(data.getAttribute("layerIndex")), 0);
	}
}
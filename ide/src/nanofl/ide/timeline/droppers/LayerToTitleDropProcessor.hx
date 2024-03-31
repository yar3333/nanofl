package nanofl.ide.timeline.droppers;

import js.JQuery;
import htmlparser.XmlDocument;
import nanofl.ide.draganddrop.DropEffect;

class LayerToTitleDropProcessor extends BaseLayerDropProcessor
{
	var layerRow : JQuery;
	
	public function new(layerRow:JQuery)
	{
		super();
		
		this.layerRow = layerRow;
	}

	function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent)
	{
		moveLayer(Std.parseInt(data.getAttribute("layerIndex")), layerRow.index());
	}
}
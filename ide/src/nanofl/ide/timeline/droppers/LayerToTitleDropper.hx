package nanofl.ide.timeline.droppers;

import htmlparser.HtmlNodeElement;
import js.JQuery.JqEvent;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDropArea;
import js.JQuery;

class LayerToTitleDropper
	extends BaseLayerDropper
	implements IDropArea
{
	var layerRow : JQuery;
	
	public function new(layerRow:JQuery)
	{
		super();
		
		this.layerRow = layerRow;
	}

	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent)
	{
		moveLayer(Std.parseInt(data.getAttribute("layerIndex")), layerRow.index());
	}
}
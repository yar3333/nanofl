package nanofl.ide.timeline.droppers;

import js.JQuery;
import htmlparser.HtmlNodeElement;
import nanofl.ide.draganddrop.DropEffect;
import nanofl.ide.draganddrop.IDropArea;

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
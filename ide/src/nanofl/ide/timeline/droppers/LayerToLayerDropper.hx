package nanofl.ide.timeline.droppers;

import htmlparser.HtmlNodeElement;
import nanofl.ide.draganddrop.DropEffect;
import js.JQuery;

class LayerToLayerDropper extends BaseLayerDropper
{
	var content : JQuery;
	
	public function new(content:JQuery)
	{
		super();
		
		this.content = content;
	}
	
	public function drop(dropEffect:DropEffect, data:HtmlNodeElement, e:JqEvent)
	{
		var lastLayerRow = content.children(":last-child");
		if (lastLayerRow.length == 0 || e.pageY > lastLayerRow.offset().top + lastLayerRow.height())
		{
			moveLayer(Std.parseInt(data.getAttribute("layerIndex")), layers.length);
		}
	}
}
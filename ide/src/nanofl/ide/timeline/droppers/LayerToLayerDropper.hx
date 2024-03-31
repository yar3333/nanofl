package nanofl.ide.timeline.droppers;

import js.JQuery;
import htmlparser.XmlDocument;
import nanofl.ide.draganddrop.DropEffect;

class LayerToLayerDropper extends BaseLayerDropper
{
	var content : JQuery;
	
	public function new(content:JQuery)
	{
		super();
		
		this.content = content;
	}
	
	function processDropInner(dropEffect:DropEffect, data:XmlDocument, e:JqEvent)
	{
		var lastLayerRow = content.children(":last-child");
		if (lastLayerRow.length == 0 || e.pageY > lastLayerRow.offset().top + lastLayerRow.height())
		{
			moveLayer(Std.parseInt(data.getAttribute("layerIndex")), layers.length);
		}
	}
}
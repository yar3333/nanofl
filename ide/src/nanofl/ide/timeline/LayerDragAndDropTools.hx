package nanofl.ide.timeline;

import stdlib.Timer;
import datatools.ArrayRO;
import nanofl.engine.LayerType;
import nanofl.engine.movieclip.Layer;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.draganddrop.DragInfoParams;
import nanofl.ide.draganddrop.DragDataType;

class LayerDragAndDropTools
{
    public static function getDragImageType(type:DragDataType, params:DragInfoParams) : DragImageType
	{
        if (type != DragDataType.LAYER) return null;
		return DragImageType.ICON_TEXT(params.icon, params.text);
	}

	public static function moveLayer(document:Document, timeline:ITimelineView, srcLayerIndex:Int, destLayerIndex:Int)
	{
        final pathItem = document.navigator.pathItem;
        final layers = pathItem.mcItem.layers;

		if (srcLayerIndex == destLayerIndex
		 || srcLayerIndex == layers.length - 1 && destLayerIndex == layers.length
		 || srcLayerIndex == destLayerIndex + 1 && layers[srcLayerIndex].parentIndex == destLayerIndex
		 || destLayerIndex < layers.length && isLayerChildOf(layers, destLayerIndex, srcLayerIndex)
		) return;
		
		document.undoQueue.beginTransaction({ timeline:true });
		
		var srcLayer = layers[srcLayerIndex];
		var srcLayers = pathItem.mcItem.removeLayerWithChildren(srcLayerIndex);
		
		if (destLayerIndex > srcLayerIndex) destLayerIndex -= srcLayers.length;
		
		if (destLayerIndex == layers.length)
		{
			pathItem.mcItem.addLayersBlock(srcLayers, destLayerIndex);
		}
		else
		{
			var destLayer = layers[destLayerIndex];
			
			switch ([ srcLayer.type, destLayer.type ])
			{
				case [ _,                LayerType.folder ]
					,[ LayerType.normal, LayerType.mask ]
					,[ LayerType.normal, LayerType.guide ]:
					
				pathItem.mcItem.addLayersBlock(srcLayers, destLayerIndex + 1);
				srcLayer.parentIndex = destLayerIndex;
					
				case _:
				if (srcLayerIndex != destLayerIndex + 1)
				{
					pathItem.mcItem.addLayersBlock(srcLayers, destLayerIndex + 1);
					srcLayer.parentIndex = destLayer.parentIndex;
				}
				else
				{
					pathItem.mcItem.addLayersBlock(srcLayers, destLayerIndex);
				}
			}
		}
		
		document.undoQueue.commitTransaction();
		
		Timer.delayAsync(1).then(_ ->
		{
            timeline.update();
            document.editor.rebind();
		});
	}
	
	static function isLayerChildOf(layers:ArrayRO<Layer>, childIndex:Int, parentIndex:Int)
	{
		final pi = layers[childIndex].parentIndex;
		if (pi == null) return false;
		if (pi == parentIndex) return true;
		return isLayerChildOf(layers, pi, parentIndex);
	}
}
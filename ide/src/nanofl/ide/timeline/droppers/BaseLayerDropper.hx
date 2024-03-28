package nanofl.ide.timeline.droppers;

import stdlib.Timer;
import datatools.ArrayRO;
import htmlparser.HtmlNodeElement;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.LayerType;
import nanofl.ide.Application;
import nanofl.ide.navigator.PathItem;
import nanofl.ide.draganddrop.DragImageType;
import nanofl.ide.ui.View;

@:rtti
class BaseLayerDropper extends InjectContainer
{
	@inject var app : Application;
	@inject var view : View;
	
	var pathItem(get, never) : PathItem;
	@:noCompletion function get_pathItem() : PathItem
	{
		// TODO: remove cast
        return cast app.document.navigator.pathItem;
	}
	
	var layers(get, never) : ArrayRO<Layer>; function get_layers() : ArrayRO<Layer> return pathItem.mcItem.layers;
	
	public function getDragImageType(data:HtmlNodeElement)
	{
		return DragImageType.ICON_TEXT(data.getAttribute("icon"), data.getAttribute("text"));
	}
	
	function moveLayer(srcLayerIndex:Int, destLayerIndex:Int)
	{
		if (srcLayerIndex == destLayerIndex
		 || srcLayerIndex == layers.length - 1 && destLayerIndex == layers.length
		 || srcLayerIndex == destLayerIndex + 1 && layers[srcLayerIndex].parentIndex == destLayerIndex
		 || destLayerIndex < layers.length && isLayerChildOf(destLayerIndex, srcLayerIndex)
		) return;
		
		app.document.undoQueue.beginTransaction({ timeline:true });
		
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
		
		app.document.undoQueue.commitTransaction();
		
		Timer.delayAsync(1).then(_ ->
		{
            view.movie.timeline.update();
            app.document.editor.rebind();
		});
	}
	
	function isLayerChildOf(childIndex:Int, parentIndex:Int)
	{
		var pi = layers[childIndex].parentIndex;
		if (pi == null) return false;
		if (pi == parentIndex) return true;
		return isLayerChildOf(pi, parentIndex);
	}	
}

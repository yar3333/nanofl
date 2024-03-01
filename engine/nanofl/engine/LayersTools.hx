package nanofl.engine;

import stdlib.Std;
import datatools.ArrayRO;
using stdlib.Lambda;

private typedef TLayer =
{
	var layersContainer : Dynamic;
	var parentIndex : Int;
	var visible : Bool;
	function getFrame(frameIndex:Int) : Dynamic;
	function getTotalFrames() : Int;
}

private typedef Container<Layer> =
{
	var _layers : Array<Layer>;
}

private typedef ContainerRO<Layer> =
{
	var layers(get, never) : ArrayRO<Layer>;
}

class LayersTools
{
	public static function addLayer<Layer:TLayer>(obj:Container<Layer>, layer:Layer)
	{
		layer.layersContainer = obj;
		obj._layers.push(layer);
	}
	
	/**
	 * Add block of layers into timeline.
	 * Assume that layers' parentIndex referenced inside block.
	 */
	public static function addLayersBlock<Layer:TLayer>(obj:Container<Layer>, layersToAdd:Array<Layer>, ?index:Int)
	{
		if (index == null || index < 0 || index > obj._layers.length) index = obj._layers.length;
		
		for (layer in obj._layers)
		{
			if (layer.parentIndex != null && layer.parentIndex >= index)
			{
				layer.parentIndex += layersToAdd.length;
			}
		}
		
		var n = index;
		for (layer in layersToAdd)
		{
			layer.layersContainer = obj;
			if (layer.parentIndex != null) layer.parentIndex += index;
			obj._layers.insert(n, layer);
			n++;
		}
	}
	
	public static function removeLayer<Layer:TLayer>(obj:Container<Layer>, index:Int) : Void
	{
		obj._layers.splice(index, 1);
		for (layer in obj._layers)
		{
			if (layer.parentIndex != null)
			{
				if (layer.parentIndex == index) layer.parentIndex = null;
				else
				if (layer.parentIndex > index) layer.parentIndex--;
			}
		}		
	}
	
	public static function removeLayerWithChildren<Layer:TLayer>(obj:Container<Layer>, index:Int) : Array<Layer>
	{
		var n = index + 1; while (n < obj._layers.length && isLayerChildOf(obj, n, index)) n++;

        final layerToRemoveCount = n - index;
		
		for (layer in obj._layers.slice(n))
		{
			if (layer.parentIndex != null && layer.parentIndex > index)
			{
				layer.parentIndex -= layerToRemoveCount;
			}
		}
		
		final removedLayers = obj._layers.splice(index, layerToRemoveCount);
		for (layer in removedLayers) layer.parentIndex -= index;
		removedLayers[0].parentIndex = null;
		
		return removedLayers;
	}
	
	static function isLayerChildOf<Layer:TLayer>(obj:Container<Layer>, childIndex:Int, parentIndex:Int)
	{
		var pi = obj._layers[childIndex].parentIndex;
		if (pi == null) return false;
		if (pi == parentIndex) return true;
		return isLayerChildOf(obj, pi, parentIndex);
	}
	
	public static function getFramesAt<Layer:TLayer, Frame>(obj:ContainerRO<Layer>, frameIndex:Int) : Array<Frame>
	{
		var r = [];
		
		var i = obj.layers.length - 1;
		while (i >= 0)
		{
			if (obj.layers[i].visible)
			{
				var frame = obj.layers[i].getFrame(frameIndex);
				if (frame != null) r.push(frame);
			}
			i--;
		}
		
		return r;
	}
	
	public static function getTotalFrames<Layer:TLayer>(obj:ContainerRO<Layer>) : Int
	{
		var r = 0;
		for (layer in obj.layers)
		{
			r = Std.max(r, layer.getTotalFrames());
		}
		return r;
	}
}
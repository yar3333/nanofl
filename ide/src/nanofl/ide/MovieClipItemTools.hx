package nanofl.ide;

import nanofl.engine.fills.BitmapFill;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.ShapeElement;
import nanofl.ide.libraryitems.MovieClipItem;
using stdlib.Lambda;

class MovieClipItemTools
{
	public static function findInstances(item:MovieClipItem, callb:Instance->{ item:MovieClipItem, layerIndex:Int, keyFrameIndex:Int }->Void) : Void
	{
		iterateInstances(item, (instance:Instance, e) ->
		{
			callb(instance, { item:item, layerIndex:e.layerIndex, keyFrameIndex:e.keyFrameIndex });
			if (Std.isOfType(instance.symbol, MovieClipItem))
			{
				findInstances((cast instance.symbol:MovieClipItem), callb);
			}
		});
	}
	
	public static function getInstances(item:MovieClipItem) : Array<Instance>
	{
        final r = new Array<Instance>();
        iterateInstances(item, (instance, _) -> r.push(instance));
        return r;
    }
    
    public static function iterateInstances(item:MovieClipItem, callb:Instance->{ layerIndex:Int, keyFrameIndex:Int }->Void) : Void
	{
		iterateElements(item, (element:Element, e) ->
		{
			if (Std.isOfType(element, Instance))
			{
				callb((cast element:Instance), e);
			}
		});
	}
	
	public static function getElements(item:MovieClipItem) : Array<Element>
	{
        var r = [];
        iterateElements(item, (element, _) -> r.push(element));
        return r;
    }

	public static function iterateElements(item:MovieClipItem, callb:Element->{ layerIndex:Int, keyFrameIndex:Int }->Void)
	{
		for (layerIndex in 0...item.layers.length)
		{
            iterateElementsOnLayer(item, layerIndex, callb);
		}
	}

	public static function iterateElementsOnLayer(item:MovieClipItem, layerIndex:Int, callb:Element->{ layerIndex:Int, keyFrameIndex:Int }->Void)
	{
        final layer = item.layers[layerIndex];
        for (keyFrameIndex in 0...layer.keyFrames.length)
        {
            final keyFrame = layer.keyFrames[keyFrameIndex];
            for (element in keyFrame.elements)
            {
                callb(element, { keyFrameIndex:keyFrameIndex, layerIndex:layerIndex });
            }
        }
	}
	
    public static function getUsedNamePathCount(item:MovieClipItem, ?r:Map<String, Int>) : Map<String, Int>
    {
        if (r == null) r = new Map<String, Int>();

        var elements = getElements(item);

        for (instance in elements.filterByType(Instance))
        {
            var np = instance.namePath;
            if (!r.exists(np)) r.set(np, 1);
            else               r.set(np, r.get(np) + 1);

            if (Std.isOfType(instance.symbol, MovieClipItem))
            {
                getUsedNamePathCount((cast instance.symbol : MovieClipItem), r);
            }
        }

        for (shape in elements.filterByType(ShapeElement))
        {
            for (polygon in shape.polygons)
            {
                if (Std.isOfType(polygon.fill, BitmapFill))
                {
                    var np = (cast polygon.fill : BitmapFill).bitmapPath;
                    if (!r.exists(np)) r.set(np, 1);
                    else               r.set(np, r.get(np) + 1);
                }
            }
        }

        return r;
    }

    public static function getUsedNamePaths(item:MovieClipItem, deep:Bool, useTextureAtlases:Bool, ?r:Array<String>) : Array<String>
    {
        if (r == null) r = new Array<String>();

        if (!stdlib.StringTools.isNullOrEmpty(item.relatedSound)) r.push(item.relatedSound);
        
        if (useTextureAtlases && item.textureAtlas != "" && item.textureAtlas != null) return r;

        var elements = getElements(item);

        for (instance in elements.filterByType(Instance))
        {
            var np = instance.namePath;
            if (!r.contains(np)) r.push(np);

            if (deep && Std.isOfType(instance.symbol, MovieClipItem))
            {
                getUsedNamePaths((cast instance.symbol : MovieClipItem), true, useTextureAtlases, r);
            }
        }

        for (shape in elements.filterByType(ShapeElement))
        {
            for (polygon in shape.polygons)
            {
                if (Std.isOfType(polygon.fill, BitmapFill))
                {
                    var np = (cast polygon.fill : BitmapFill).bitmapPath;
                    if (!r.contains(np)) r.push(np);
                }
            }
        }
        
        return r;
    }    
}
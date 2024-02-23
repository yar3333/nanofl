package nanofl.engine;

import nanofl.engine.LayerType;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Elements;
import nanofl.engine.elements.Instance;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.engine.geom.Matrix;
import nanofl.engine.elements.ShapeElement;

class MovieClipItemTools
{
    public static function findShapes(item:MovieClipItem, allFrames:Bool, ?matrix:Matrix, callb:ShapeElement->{ item:MovieClipItem, layerIndex:Int, matrix:Matrix, insideMask:Bool }->Void)
    {
        if (matrix == null) matrix = new Matrix();
        
        findShapesInner(item, allFrames, matrix, false, callb);
        findMovieClipItems(item, allFrames, matrix, function(item, matrix, insideMask) findShapesInner(item, allFrames, matrix, insideMask, callb));
    }
        
    static function findShapesInner(item:MovieClipItem, allFrames:Bool, matrix:Matrix, insideMask:Bool, callb:ShapeElement->{ item:MovieClipItem, layerIndex:Int, keyFrameIndex:Int, matrix:Matrix, insideMask:Bool }->Void)
    {
        iterateElements(item, allFrames, insideMask, (element:Element, e) ->
        {
            if (Std.isOfType(element, ShapeElement))
            {
                callb((cast element:ShapeElement), { item:item, layerIndex:e.layerIndex, keyFrameIndex:e.keyFrameIndex, matrix:matrix, insideMask:e.insideMask });
            }
        });
    }
        
    public static function findMovieClipItems(item:MovieClipItem, allFrames:Bool, ?matrix:Matrix, callb:MovieClipItem->Matrix->Bool->Void)
    {
        findInstances(item, allFrames, matrix, (instance:Instance, e) ->
        {
            if (Std.isOfType(instance.symbol, MovieClipItem))
            {
                callb((cast instance.symbol:MovieClipItem), matrix.clone().appendMatrix(instance.matrix), e.insideMask);
            }
        });
    }
	
    public static function findInstances(item:MovieClipItem, allFrames:Bool, ?matrix:Matrix, callb:Instance->{ item:MovieClipItem, layerIndex:Int, keyFrameIndex:Int, matrix:Matrix, insideMask:Bool }->Void, insideMask=false)
    {
        if (matrix == null) matrix = new Matrix();
        
        iterateInstances(item, allFrames, insideMask, (instance:Instance, e) ->
        {
            callb(instance, { item:item, layerIndex:e.layerIndex, keyFrameIndex:e.keyFrameIndex, matrix:matrix, insideMask:e.insideMask });
            if (Std.isOfType(instance.symbol, MovieClipItem))
            {
                findInstances((cast instance.symbol:MovieClipItem), allFrames, matrix.clone().appendMatrix(instance.matrix), callb, insideMask);
            }
        });
    }

    public static function iterateInstances(item:MovieClipItem, allFrames:Bool, insideMask=false, callb:Instance->{ layerIndex:Int, keyFrameIndex:Int, insideMask:Bool }->Void)
    {
        iterateElements(item, allFrames, insideMask, (element:Element, e) ->
        {
            if (Std.isOfType(element, Instance))
            {
                callb((cast element:Instance), e);
            }
        });
    }
    
    public static function iterateElements(item:MovieClipItem, allFrames:Bool, insideMask=false, callb:Element->{ layerIndex:Int, keyFrameIndex:Int, insideMask:Bool }->Void)
    {
        for (layerIndex in 0...item.layers.length)
        {
            var layer = item.layers[layerIndex];
            if (layer.keyFrames.length > 0)
            {
                var localInsideMask = insideMask || layer.type == LayerType.mask;
                for (keyFrameIndex in 0...(allFrames ? layer.keyFrames.length : 1))
                {
                    var keyFrame = layer.keyFrames[keyFrameIndex];
                    for (element in Elements.expandGroups(keyFrame.elements))
                    {
                        callb(element, { keyFrameIndex:keyFrameIndex, layerIndex:layerIndex, insideMask:localInsideMask });
                    }
                }
            }
        }
    }
}
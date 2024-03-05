package nanofl.engine;

import easeljs.display.DisplayObject;
import nanofl.engine.LayerType;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.elements.Instance;
import nanofl.engine.libraryitems.MovieClipItem;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

class MovieClipGotoHelper
{
    final mc : MovieClip;
    final oldFrameIndex : Int;
    final newFrameIndex : Int;
    final symbol : MovieClipItem;

    var movieClipChanged = false;
    
    public final createdDisplayObjects = new Array<DisplayObject>();
    public final keepedAdvancableChildren : Array<AdvancableDisplayObject>;

    public function new(mc:MovieClip, newFrameIndex:Int)
    {
        if (mc.currentFrame == newFrameIndex)
        {
            keepedAdvancableChildren = mc.children.filterByType(AdvancableDisplayObject);
            return;
        }

        keepedAdvancableChildren = new Array<AdvancableDisplayObject>();

        this.mc = mc;
        this.oldFrameIndex = mc.currentFrame;
        this.newFrameIndex = newFrameIndex;
        this.symbol = mc.symbol;
		
		for (layerIndex in 0...symbol.layers.length)
		{
			processLayer(layerIndex);
		}
		
		if (movieClipChanged) DisplayObjectTools.smartUncache(mc);
		
		mc.currentFrame = newFrameIndex;
    }


    public function processLayer(layerIndex:Int) : Void
    {
        var layerChanged = false;
        
        var layer = symbol.layers[layerIndex];
        var oldFrame = layer.getFrame(oldFrameIndex);
        var newFrame = layer.getFrame(newFrameIndex);
        
        if (oldFrame != null && newFrame != null && oldFrame.keyFrame == newFrame.keyFrame)
        {
            var tweenedElements = layer.getTweenedElements(newFrameIndex);
            var layerChildren = mc.getLayerChildren(layerIndex);
            Debug.assert(tweenedElements.length == layerChildren.length, "tweenedElements.length=" + tweenedElements.length + " != layerChildren.length=" + layerChildren.length);
            for (i in 0...tweenedElements.length)
            {
                final dispObj = layerChildren[i];

                //dispObj.visible = layer.type == LayerType.normal;

                if (dispObj.visible)
                {
                    final tweenedElement = tweenedElements[i];
                    
                    if (tweenedElement.current != tweenedElement.original)
                    {
                        Debug.assert(Std.isOfType(tweenedElement.current, Instance));
                        (cast tweenedElement.current:Instance).updateDisplayObjectTweenedProperties(dispObj);
                    }
                }
                
                if (Std.isOfType(dispObj, AdvancableDisplayObject))
                {
                    keepedAdvancableChildren.push((cast dispObj : AdvancableDisplayObject));
                }
            }
            layerChanged = true;
        }
        //else // keep children between related keyframes on motion tween
        //if (oldFrame != null && newFrame != null && newFrameIndex == oldFrameIndex + 1 && oldFrame.keyFrame.hasMotionTween()) 
        //{


        //}
        else if (oldFrame != null || newFrame != null)
        {
            if (oldFrame != null)
            {
                var j = 0; while (j < mc.children.length)
                {
                    if (mc.layerOfChild.get(mc.children[j]) == layerIndex) mc.removeChildAt(j);
                    else j++;
                }
            }
            
            if (newFrame != null)
            {
                for (tweenedElement in layer.getTweenedElements(newFrameIndex))
                {
                    var obj = tweenedElement.current.createDisplayObject(null);
                    obj.visible = layer.type == LayerType.normal;
                    mc.addChildToLayer(obj, layerIndex);
                    createdDisplayObjects.push(obj);
                }
            }
            
            layerChanged = true;
        }
        
        if (layerChanged)
        {
            movieClipChanged = true;
            
            if (layer.type == LayerType.mask)
            {
                for (i in 0...symbol.layers.length)
                {
                    if (symbol.layers[i].parentIndex == layerIndex)
                    {
                        for (child in mc.getLayerChildren(i)) child.uncache();
                    }
                }
            }
        }        
    }
}
package nanofl.engine;

import js.lib.Error;
import easeljs.display.Shape;
import nanofl.engine.elements.Element;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.Layer;
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
    
    public final createdDisplayObjects = new Array<DisplayObject>();
    public final keepedAdvancableChildren : Array<AdvancableDisplayObject>;

    @:access(nanofl.MovieClip.currentFrame)
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
		
		for (layer in symbol.layers)
		{
			processLayer(layer);
		}
		
		mc.currentFrame = newFrameIndex;
    }

    public function processLayer(layer:Layer) : Void
    {
        var oldFrame = layer.getFrame(oldFrameIndex);
        var newFrame = layer.getFrame(newFrameIndex);

        if (oldFrame == null && newFrame == null) return;
        
        if (oldFrame != null && newFrame != null && oldFrame.keyFrame == newFrame.keyFrame)
        {
            processSameKeyFrame(layer, newFrame);
        }
        else if (oldFrame != null && newFrame != null)
        {
            processRelativeKeyFrames(layer, oldFrame, newFrame);
        }
        else if (oldFrame != null || newFrame != null)
        {
            processSeparatedKeyFrames(layer, oldFrame, newFrame);
        }
    }

    function processSameKeyFrame(layer:Layer, newFrame:Frame) : Bool
    {
        var tweenedElements = newFrame.keyFrame.getTweenedElements(newFrame.subIndex);
        var displayObjects = mc.getChildrenByLayerIndex(layer.getIndex());
        
        Debug.assert(tweenedElements.length == displayObjects.length, "tweenedElements.length=" + tweenedElements.length + " != displayObjects.length=" + displayObjects.length);
        
        for (i in 0...tweenedElements.length)
        {
            final dispObj = displayObjects[i];

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
        
        return true; // layerChanged
    }

    function processRelativeKeyFrames(layer:Layer, oldFrame:Frame, newFrame:Frame) : Bool
    {
        final layerIndex = layer.getIndex();
        final tweenedElements = newFrame.keyFrame.getTweenedElements(newFrame.subIndex);
        final displayObjects = mc.getChildrenByLayerIndex(layer.getIndex());

        var matched = 0; while (matched < tweenedElements.length)
        {
            final elem = tweenedElements[matched].current;
            final dispObj = displayObjects[matched];
            if (!isElementMatchDisplayObject(elem, dispObj)) break;
            
            switch (elem.type)
            {
                case ElementType.shape:
                    mc.replaceChild(dispObj, createDisplayObject(layer, layerIndex, elem));

                case ElementType.instance:
                    (cast elem:Instance).updateDisplayObjectTweenedProperties(dispObj);

                case ElementType.text:
                    mc.replaceChild(dispObj, createDisplayObject(layer, layerIndex, elem));

                case ElementType.group:
                    throw new Error("Element type 'group' is unexpected.");
            }

            matched++;
        }

        while (displayObjects.length > matched)
        {
            mc.removeChild(displayObjects.pop());
        }

        final layerIndex = layer.getIndex();
        for (tweenedElement in tweenedElements.slice(matched))
        {
            createDisplayObject(layer, layerIndex, tweenedElement.current);
        }
        
        return true;
    }

    function processSeparatedKeyFrames(layer:Layer, oldFrame:Frame, newFrame:Frame) : Bool
    {
        final layerIndex = layer.getIndex();

        if (oldFrame != null)
        {
            for (child in mc.getChildrenByLayerIndex(layerIndex))
            {
                mc.removeChild(child);
            }
        }
        
        if (newFrame != null)
        {
            for (tweenedElement in layer.getTweenedElements(newFrameIndex))
            {
                createDisplayObject(layer, layerIndex, tweenedElement.current);
            }
        }

        return true;
    }

    function createDisplayObject(layer:Layer, layerIndex:Int, element:Element) : DisplayObject
    {
        var obj = element.createDisplayObject();
        obj.visible = layer.type == LayerType.normal;
        mc.addChildToLayer(obj, layerIndex);
        createdDisplayObjects.push(obj);
        return obj;
    }

    static function isElementMatchDisplayObject(elem:Element, dispObj:DisplayObject) : Bool
    {
        return switch (elem.type)
        {
            case ElementType.instance: Std.isOfType(dispObj, InstanceDisplayObject) && (cast elem : Instance).namePath == (cast dispObj : InstanceDisplayObject).symbol.namePath;
            case ElementType.shape: Std.isOfType(dispObj, Shape);
            case ElementType.text: Std.isOfType(dispObj, TextField);
            case ElementType.group: throw new Error("Element type 'group' is unexpected.");
        }
    }
}
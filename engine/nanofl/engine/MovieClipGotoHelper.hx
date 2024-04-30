package nanofl.engine;

import easeljs.display.DisplayObject;
import easeljs.display.Shape;
import nanofl.engine.ElementLifeTracker;
import nanofl.engine.LayerType;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.elements.Element;
import nanofl.engine.elements.Instance;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.engine.movieclip.Frame;
import nanofl.engine.movieclip.Layer;
import nanofl.engine.movieclip.TweenedElement;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

class MovieClipGotoHelper
{
    final mc : MovieClip;
    final oldFrameIndex : Int;
    final newFrameIndex : Int;
    final framerate : Float;
    final symbol : MovieClipItem;
    
    public final createdDisplayObjects = new Array<DisplayObject>();

    @:access(nanofl.MovieClip.currentFrame)
    public function new(mc:MovieClip, newFrameIndex:Int, framerate:Float)
    {
        if (mc.currentFrame == newFrameIndex) return;

        this.mc = mc;
        this.oldFrameIndex = mc.currentFrame;
        this.newFrameIndex = newFrameIndex;
        this.framerate = framerate;
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
    }

    function processSameKeyFrame(layer:Layer, newFrame:Frame) : Bool
    {
        final tracker = ElementLifeTracker.createForLayer(symbol, layer.getIndex(), false);

        var tweenedElements = newFrame.keyFrame.getTweenedElements(newFrame.subIndex);
        var displayObjects = mc.getChildrenByLayerIndex(layer.getIndex());
        
        Debug.assert(tweenedElements.length == displayObjects.length, "tweenedElements.length=" + tweenedElements.length + " != displayObjects.length=" + displayObjects.length);
        
        for (i in 0...tweenedElements.length)
        {
            final dispObj = displayObjects[i];

            final tweenedElement = tweenedElements[i];

            if (tweenedElement.current != tweenedElement.original)
            {
                Debug.assert(Std.isOfType(tweenedElement.current, Instance));
                (cast tweenedElement.current:Instance).updateDisplayObjectTweenedProperties(dispObj);
            }

            advance(dispObj, tracker, tweenedElement);
        }
        
        return true; // layerChanged
    }

    function processRelativeKeyFrames(layer:Layer, oldFrame:Frame, newFrame:Frame) : Bool
    {
        final tracker = ElementLifeTracker.createForLayer(symbol, layer.getIndex(), false);

        final layerIndex = layer.getIndex();
        final tweenedElements = newFrame.keyFrame.getTweenedElements(newFrame.subIndex);
        final displayObjects = mc.getChildrenByLayerIndex(layer.getIndex());

        var matched = 0; while (matched < tweenedElements.length && matched < displayObjects.length)
        {
            final tweenedElement = tweenedElements[matched];
            final elem = tweenedElement.current;
            var dispObj = displayObjects[matched];
            if (!isElementMatchDisplayObject(elem, dispObj))
            {
                if (!elem.type.match(ElementType.shape) && Std.isOfType(dispObj, Shape))
                {
                    mc.removeChild(dispObj);
                    displayObjects.splice(matched, 1);
                    if (matched >= displayObjects.length) break;
                    dispObj = displayObjects[matched];
                }
                else if (elem.type.match(ElementType.shape) && !Std.isOfType(dispObj, Shape))
                {
                    dispObj = mc.addChildToLayer(new Shape(), layerIndex, dispObj);
                    displayObjects.insert(matched, dispObj);
                }
                else
                {
                    break;
                }
            }
            
            switch (elem.type)
            {
                case ElementType.shape:
                    final newDispObj = createDisplayObject(layer, layerIndex, elem);
                    mc.replaceChild(dispObj, newDispObj);
                    dispObj = newDispObj;

                case ElementType.instance:
                    (cast elem:Instance).updateDisplayObjectTweenedProperties(dispObj);

                case ElementType.text:
                    final newDispObj = createDisplayObject(layer, layerIndex, elem);
                    mc.replaceChild(dispObj, newDispObj);
                    dispObj = newDispObj;
            }

            advance(dispObj, tracker, tweenedElement);

            matched++;
        }

        while (displayObjects.length > matched)
        {
            mc.removeChild(displayObjects.pop());
        }

        final layerIndex = layer.getIndex();
        for (tweenedElement in tweenedElements.slice(matched))
        {
            final dispObj = createDisplayObject(layer, layerIndex, tweenedElement.current);
            advance(dispObj, tracker, tweenedElement);
        }
        
        return true;
    }

    function createDisplayObject(layer:Layer, layerIndex:Int, element:Element) : DisplayObject
    {
        final obj = element.createDisplayObject();
        obj.visible = layer.type == LayerType.normal;
        mc.addChildToLayer(obj, layerIndex);
        createdDisplayObjects.push(obj);
        return obj;
    }

    function advance(dispObj:DisplayObject, tracker:ElementLifeTracker, tweenedElement:TweenedElement)
    {
        if (!Std.isOfType(dispObj, AdvancableDisplayObject)) return;
        
        final track = tracker.getTrackOne(tweenedElement.original);
        if (track != null)
        {
            (cast dispObj:AdvancableDisplayObject).advanceTo
            (
                newFrameIndex - track.startFrameIndex, 
                tweenedElement 
                #if ide , framerate #end
            );
        }
    }

    static function isElementMatchDisplayObject(elem:Element, dispObj:DisplayObject) : Bool
    {
        return switch (elem.type)
        {
            case ElementType.instance: Std.isOfType(dispObj, InstanceDisplayObject) && (cast elem : Instance).namePath == (cast dispObj : InstanceDisplayObject).symbol.namePath;
            case ElementType.shape: Std.isOfType(dispObj, Shape);
            case ElementType.text: Std.isOfType(dispObj, TextField);
        }
    }
}
package nanofl.ide;

import nanofl.engine.movieclip.Layer;
import js.lib.Set;
import nanofl.engine.LibraryItemType;
import nanofl.engine.ElementType;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.Element;
import nanofl.engine.libraryitems.MovieClipItem;
using nanofl.engine.MovieClipItemTools;

typedef ElementLifeTrack =
{
    var element : Element;
    var startFrameIndex : Int;
    var lifetimeFrames : Int;
}

class ElementLifeTracker
{
    public final tracks = new Array<ElementLifeTrack>();

    function new() {}

    public static function createForMovieClip(item:MovieClipItem, deep:Bool) : ElementLifeTracker
    {
        var r = new ElementLifeTracker();
        r.processMovieClipItem(item, 0, item.getTotalFrames(), deep, new Set<Element>());
        return r;
    }

    public static function createForLayer(item:MovieClipItem, layerIndex:Int, deep:Bool) : ElementLifeTracker
    {
        final itemTotalFrames = item.getTotalFrames();
        var r = new ElementLifeTracker();
        r.processLayer(item, layerIndex, itemTotalFrames, 0, itemTotalFrames, deep, new Set<Element>());
        return r;
    }

    function processMovieClipItem(item:MovieClipItem, globalFrameIndex:Int, lifetimeOnParent:Int, deep:Bool, ignoreElements:Set<Element>)
    {
        final itemTotalFrames = item.getTotalFrames();
        for (layerIndex in 0...item.layers.length)
        {
            processLayer(item, layerIndex, itemTotalFrames, 0, itemTotalFrames, deep, ignoreElements);
        }
    }
    
    function processLayer(item:MovieClipItem, layerIndex:Int, itemTotalFrames:Int, globalFrameIndex:Int, lifetimeOnParent:Int, deep:Bool, ignoreElements:Set<Element>)
    {
        final layer = item.layers[layerIndex];
        
        for (keyFrameIndex in 0...layer.keyFrames.length)
        {
            final keyFrame = layer.keyFrames[keyFrameIndex];
            for (element in keyFrame.elements)
            {
                if (ignoreElements.has(element)) continue;
                if (!item.autoPlay && keyFrameIndex > 0) continue;

                final frameIndex = keyFrame.getIndex();
                final duration = detectElementDuration(item, layer, keyFrameIndex, element, ignoreElements);
                final lifetimeFrames = frameIndex + duration < itemTotalFrames ? duration : lifetimeOnParent;
                
                final parent : MovieClipItem = cast element.parent;
                stdlib.Debug.assert(Std.isOfType(parent, MovieClipItem));

                tracks.push
                ({
                    element: element,
                    startFrameIndex: globalFrameIndex + frameIndex,
                    lifetimeFrames: lifetimeFrames
                });
                
                if (deep)
                {
                    if (element.type == ElementType.instance && (cast element:Instance).symbol.type == LibraryItemType.movieclip)
                    {
                        final instance : Instance = cast element;
                        final mcChild : MovieClipItem = cast instance.symbol;
                        processMovieClipItem(mcChild, globalFrameIndex + frameIndex, lifetimeFrames, true, ignoreElements);
                    }
                }
            }
        }
    }

    function detectElementDuration(parent:MovieClipItem, layer:Layer, keyFrameIndex:Int, element:Element, ignoreElements:Set<Element>) : Int
    {
        final baseKeyFrame = layer.keyFrames[keyFrameIndex];
        
        if (element.type != ElementType.instance) return baseKeyFrame.duration;

        var r = baseKeyFrame.duration;
        for (keyFrame in layer.keyFrames.slice(keyFrameIndex + 1))
        {
            for (i in 0...(baseKeyFrame.elements.indexOf(element) + 1))
            {
                final a = keyFrame.elements[i];
                final b = baseKeyFrame.elements[i];
                
                if (a.type != b.type) return r;
                if (a.type != ElementType.instance) continue;
                if ((cast a:Instance).namePath != (cast b:Instance).namePath) return r;
                
                ignoreElements.add(a);
                r += keyFrame.duration;
            }
        }
        return r;
    }
}
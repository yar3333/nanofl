package nanofl.engine;

import js.lib.Set;
import stdlib.Debug;
import nanofl.engine.LibraryItemType;
import nanofl.engine.ElementType;
import nanofl.engine.elements.Instance;
import nanofl.engine.elements.Element;
import nanofl.engine.libraryitems.MovieClipItem;
import nanofl.engine.movieclip.Layer;
using nanofl.engine.MovieClipItemTools;
using stdlib.Lambda;

class ElementLifeTracker
{
    var ignoreElements = new Set<Element>();
    
    public final tracks = new Array<ElementLifeTrack>();

    function new() {}

    public static function createForMovieClip(item:MovieClipItem, deep:Bool) : ElementLifeTracker
    {
        var r = new ElementLifeTracker();
        r.processMovieClipItem(item, 0, item.getTotalFrames(), deep);
        r.ignoreElements = null;
        return r;
    }

    public static function createForLayer(item:MovieClipItem, layerIndex:Int, deep:Bool) : ElementLifeTracker
    {
        final itemTotalFrames = item.getTotalFrames();
        var r = new ElementLifeTracker();
        r.processLayer(item, layerIndex, itemTotalFrames, 0, itemTotalFrames, deep);
        r.ignoreElements = null;
        return r;
    }

    function processMovieClipItem(item:MovieClipItem, globalFrameIndex:Int, lifetimeOnParent:Int, deep:Bool)
    {
        final itemTotalFrames = item.getTotalFrames();
        for (layerIndex in 0...item.layers.length)
        {
            processLayer(item, layerIndex, itemTotalFrames, 0, itemTotalFrames, deep);
        }
    }
    
    function processLayer(item:MovieClipItem, layerIndex:Int, itemTotalFrames:Int, globalFrameIndex:Int, lifetimeOnParent:Int, deep:Bool)
    {
        final layer = item.layers[layerIndex];
        
        for (keyFrameIndex in 0...layer.keyFrames.length)
        {
            final keyFrame = layer.keyFrames[keyFrameIndex];
            for (element in keyFrame.elements)
            {
                if (ignoreElements.has(element)) continue;
                if (!item.autoPlay && keyFrameIndex > 0) continue;

                final sameElementSequence = [ element ];
                final duration = detectRelatedElementsAndDuration(layer, keyFrameIndex, element, sameElementSequence);
                
                final frameIndex = keyFrame.getIndex();
                final lifetimeFrames = frameIndex + duration < itemTotalFrames 
                                        ? duration 
                                        : lifetimeOnParent - frameIndex;

                tracks.push
                ({
                    sameElementSequence: sameElementSequence,
                    startFrameIndex: globalFrameIndex + frameIndex,
                    lifetimeFrames: lifetimeFrames
                });
                
                if (deep)
                {
                    if (element.type == ElementType.instance && (cast element:Instance).symbol.type == LibraryItemType.movieclip)
                    {
                        final instance : Instance = cast element;
                        final mcChild : MovieClipItem = cast instance.symbol;
                        processMovieClipItem(mcChild, globalFrameIndex + frameIndex, lifetimeFrames, true);
                    }
                }
            }
        }
    }

    function detectRelatedElementsAndDuration(baseLayer:Layer, baseKeyFrameIndex:Int, baseElement:Element, sameElementSequence:Array<Element>) : Int
    {
        final baseKeyFrame = baseLayer.keyFrames[baseKeyFrameIndex];
        
        if (baseElement.type != ElementType.instance) return baseKeyFrame.duration;

        final baseElements = baseKeyFrame.elements.skipWhile(x -> x.type == ElementType.shape);

        var r = baseKeyFrame.duration;
        for (curKeyFrame in baseLayer.keyFrames.slice(baseKeyFrameIndex + 1))
        {
            final curInstance = findMatch(baseElements, curKeyFrame.elements.skipWhile(x -> x.type == ElementType.shape), (cast baseElement : Instance));
            if (curInstance == null) break;
            ignoreElements.add(curInstance);
            sameElementSequence.push(curInstance);
            r += curKeyFrame.duration;
        }
        return r;
    }

    static function findMatch(a:Array<Element>, b:Array<Element>, instanceInA:Instance) : Instance
    {
        final limit = a.indexOf(instanceInA);
        Debug.assert(limit >= 0);

        if (b.length < limit + 1) return null;
        
        for (i in 0...(limit + 1))
        {
            final elemA = a[i];
            final elemB = b[i];
            
            if (elemA.type != elemB.type) return null;
            if (elemA.type != ElementType.instance) return null;
            if ((cast elemA:Instance).namePath != (cast elemB:Instance).namePath) return null;
            if ((cast elemA:Instance).symbol.type.match(LibraryItemType.video) && (cast elemB:Instance).videoCurrentTime != null) return null;
        }

        return (cast b[limit] : Instance);
    }

    public function getTrackOne(element:Element) : ElementLifeTrack
    {
        final tracks = tracks.filter(x -> x.sameElementSequence.contains(element));
        if (tracks.length == 0) return null;
        Debug.assert(tracks.length == 1);
        return tracks[0];
    }
}
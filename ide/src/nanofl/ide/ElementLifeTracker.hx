package nanofl.ide;

import nanofl.engine.LibraryItemType;
import nanofl.engine.ElementType;
import nanofl.engine.elements.Instance;
import nanofl.ide.libraryitems.MovieClipItem;
import nanofl.engine.elements.Element;
using nanofl.ide.MovieClipItemTools;

typedef ElementLifeTrack =
{
    var element : Element;
    var globalFrameIndex : Int;
    var lifetimeFrames : Int;
}

class ElementLifeTracker
{
    final checkAutoPlay : Bool;

    public final tracks = new Array<ElementLifeTrack>();

    public function new(item:MovieClipItem, checkAutoPlay:Bool)
    {
        this.checkAutoPlay = checkAutoPlay;
  
        processMovieClipItem(item, 0, item.getTotalFrames());
    }
    
    function processMovieClipItem(item:MovieClipItem, globalFrameIndex:Int, lifetimeOnParent:Int)
    {
        final itemTotalFrames = item.getTotalFrames();

        item.iterateElements((element, data) ->
        {
            if (checkAutoPlay && !item.autoPlay && data.keyFrameIndex > 0) return;

            final layer = item.layers[data.layerIndex];
            final keyFrame = layer.keyFrames[data.keyFrameIndex];
            final frameIndex = keyFrame.getIndex();
            final lifetimeFrames = frameIndex + keyFrame.duration < itemTotalFrames ? keyFrame.duration : lifetimeOnParent;

            tracks.push
            ({
                element: element,
                globalFrameIndex: globalFrameIndex + frameIndex,
                lifetimeFrames: lifetimeFrames
            });
            
            if (element.type == ElementType.instance && (cast element:Instance).symbol.type == LibraryItemType.movieclip)
            {
                final instance : Instance = cast element;
                final mcChild : MovieClipItem = cast instance.symbol;
                processMovieClipItem(mcChild, globalFrameIndex + frameIndex, lifetimeFrames);
            }
        });
    }
}
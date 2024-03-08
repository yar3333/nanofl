package nanofl.ide;

import nanofl.ide.libraryitems.MovieClipItem;
import stdlib.Std;
import stdlib.Debug;
import easeljs.display.Container;
import easeljs.display.DisplayObject;

class MovieClipAdvanceToHelper 
{
    public static function advanceTo(mcDispObj:MovieClip, lifetimeOnParent:Int) : Void
    {
        Debug.assert(mcDispObj.currentFrame == 0);
        if (lifetimeOnParent == 0) return;

        if (!mcDispObj.paused)
        {
            mcDispObj.gotoFrame(mcDispObj.loop ? lifetimeOnParent % mcDispObj.getTotalFrames() 
                                               : Std.min(lifetimeOnParent, mcDispObj.getTotalFrames() - 1));
        }

        final mcItem : MovieClipItem = cast mcDispObj.symbol;

        final tracker = new ElementLifeTracker(mcItem);
        
    }
}
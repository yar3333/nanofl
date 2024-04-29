package nanofl.ide.displayobjects;

import js.lib.Promise;
import stdlib.Std;
import nanofl.Video.VideoParams;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.movieclip.TweenedElement;
import nanofl.ide.libraryitems.VideoItem;

class IdeVideo extends nanofl.Video
    implements AdvancableDisplayObject
{
    public var currentTime : Float;
    
    public function new(symbol:VideoItem, params:VideoParams)
    {
        super(symbol, null);
        
        this.currentTime = params?.currentTime ?? 0;
    }

    public function waitLoading() : Promise<{}>
    {
        return VideoCache.getImageAsync((cast symbol:VideoItem).getUrl(), currentTime).then(canvas ->
        {
            removeAllChildren();
            addChild(new easeljs.display.Bitmap(canvas));
            return null;
        });
    }

    public function advanceTo(lifetimeOnParent:Int, framerate:Float, tweenedElement:TweenedElement) : Void
    {
        if (!symbol.autoPlay || tweenedElement.original != tweenedElement.current) return;

        final advanceFrames = lifetimeOnParent + Math.round(currentTime * framerate);

        final totalFrames = Std.int(duration * framerate);

        final currentFrame = symbol.loop ? advanceFrames % totalFrames : Std.min(totalFrames - 1, advanceFrames);

        currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / framerate + 0.0001);
        
        //trace("advanceTo " + currentTime + " | " + advanceFrames);
    }

    override function clone(?recursive:Bool) : Video
    {
		final r : IdeVideo = (cast this)._cloneProps(new IdeVideo(cast symbol, { currentTime:currentTime }));
        return r;
    }

    // override function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool):Bool
    // {
    //     trace("video " + currentTime);
    //     return super.draw(ctx, ignoreCache);
    // }
}
package nanofl.ide.displayobjects;

import js.lib.Promise;
import stdlib.Std;
import nanofl.Video.VideoParams;
import nanofl.ide.libraryitems.VideoItem;
import nanofl.engine.AdvancableDisplayObject;

class IdeVideo extends nanofl.Video
    implements AdvancableDisplayObject
{
    var currentFrame : Int;
    public var currentTime : Float;

    inline function getFramerate() return (cast stage : nanofl.Stage).framerate;
    
    public function new(symbol:VideoItem, params:VideoParams)
    {
        super(symbol, { currentTime:0 });
        
        this.currentFrame = 0;
        this.currentTime = params?.currentTime ?? 0;
        
        video.autoplay = false;
    }

    public function waitLoading() : Promise<{}>
    {
        return VideoCache.getImageAsync(video.src, currentTime).then(canvas ->
        {
            removeAllChildren();
            addChild(new easeljs.display.Bitmap(canvas));
            return null;
        });
    }

	public function advanceToNextFrame() : Void
    {
        final totalFrames = Std.int(duration * getFramerate());

        if (currentFrame == 0 && currentTime > 0)
        {
            currentFrame = Math.floor(currentTime * getFramerate());
        }

        if (!symbol.loop && currentFrame >= totalFrames - 1) return;

        currentFrame++;
        if (currentFrame >= totalFrames) currentFrame -= totalFrames;

        currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / getFramerate() + 0.0001);
    }

    public function advanceTo(advanceFrames:Int, framerate:Float)
    {
        if (!symbol.autoPlay) return;

        advanceFrames += Math.round(currentTime * framerate);

        final totalFrames = Std.int(duration * framerate);

        currentFrame = symbol.loop ? advanceFrames % totalFrames : Std.min(totalFrames - 1, advanceFrames);

        currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / framerate + 0.0001);
    }
}
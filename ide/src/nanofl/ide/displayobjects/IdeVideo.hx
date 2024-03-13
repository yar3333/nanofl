package nanofl.ide.displayobjects;

import stdlib.Std;
import nanofl.Video.VideoParams;
import nanofl.ide.libraryitems.VideoItem;
import nanofl.engine.AdvancableDisplayObject;

class IdeVideo extends nanofl.Video
    implements AdvancableDisplayObject
{
    var currentFrame : Int;

    inline function getFramerate() return (cast stage : nanofl.Stage).framerate;
    
    public function new(symbol:VideoItem, params:VideoParams)
    {
        super(symbol, { currentTime: params?.currentTime ?? 0.0 });
        
        video.autoplay = false;
        
        this.currentFrame = 0;
    }

	public function advanceToNextFrame() : Void
    {
        final totalFrames = Std.int(duration * getFramerate());
        if (!video.loop && currentFrame >= totalFrames - 1) return;

        currentFrame++;
        if (currentFrame >= totalFrames) currentFrame -= totalFrames;

        video.currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / getFramerate() + 0.0001);
    }

    public function advanceTo(advanceFrames:Int, framerate:Float)
    {
        if (!symbol.autoPlay) return;

        final totalFrames = Std.int(duration * framerate);

        currentFrame = symbol.loop ? advanceFrames % totalFrames : Std.min(totalFrames - 1, advanceFrames);

        video.currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / framerate + 0.0001);
    }
}
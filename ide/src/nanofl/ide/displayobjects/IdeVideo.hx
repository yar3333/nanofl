package nanofl.ide.displayobjects;

import js.html.MediaElement;
import nanofl.ide.libraryitems.VideoItem;
import nanofl.engine.AdvancableDisplayObject;

class IdeVideo extends nanofl.Video
    implements AdvancableDisplayObject
{
    var currentFrame : Int;
    
    public function new(symbol:VideoItem)
    {
        super(symbol);

        video.autoplay = false;
        
        currentFrame = 0;
        video.currentTime = 0.0001;

        if (video.readyState < MediaElement.HAVE_CURRENT_DATA)
        {
            removeAllChildren();
            addChild(new easeljs.display.Bitmap(symbol.poster));

            video.addEventListener
            (
                "canplay",
                () -> {
                    removeAllChildren();
                    addChild(new easeljs.display.Bitmap(new easeljs.utils.VideoBuffer(video)));
                },
                { once:true }
            );
        }
    }

	public function advanceToNextFrame(framerate:Float) : Void
    {
        final totalFrames = Std.int(video.duration * framerate);
        if (!video.loop && currentFrame >= totalFrames - 1) return;

        currentFrame++;
        if (currentFrame >= totalFrames) currentFrame -= totalFrames;

        video.currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / framerate + 0.0001);
    }

    public function advanceTo(advanceFrames:Int)
    {
        // TODO: is this method need?
    }
}
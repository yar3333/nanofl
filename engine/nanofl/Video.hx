package nanofl;

import js.lib.Promise;
import js.html.MediaElement;
import js.html.VideoElement;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.libraryitems.VideoItem;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

@:expose
class Video extends SolidContainer
    implements AdvancableDisplayObject
    #if !ide implements IEventHandlers #end
{
	public var symbol(default, null) : VideoItem;
    public var video : VideoElement;

    public var currentFrame(default, null) : Int;
	
	public function new(symbol:VideoItem)
	{
		super();
		
        Debug.assert(Std.isOfType(symbol, VideoItem));

        this.symbol = symbol;
		symbol.updateDisplayObject(this, null);

        currentFrame = 0;

        if (video.readyState >= MediaElement.HAVE_CURRENT_DATA)
        {
            addChild(new easeljs.display.Bitmap(new easeljs.utils.VideoBuffer(video)));
        }
        else
        {
            addChild(new easeljs.display.Bitmap(video.poster));

            video.addEventListener("loadeddata", () ->
            {
                removeAllChildren();
                addChild(new easeljs.display.Bitmap(new easeljs.utils.VideoBuffer(video)));
            },
            { once:true });
            
            video.currentTime = 0.0001;
        }
	}

	override public function clone(?recursive:Bool) : MovieClip 
	{
		return (cast this)._cloneProps
		(
			new Video(symbol)
		);
	}
	
	override public function toString() : String 
	{
		return symbol.toString();
	}

	#if !ide
	//{ IEventHandlers
	public function onEnterFrame() : Void {}
	public function onMouseDown(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseMove(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseUp(e:easeljs.events.MouseEvent) : Void {}
	//}
	#end

    public function advance() : Promise<{}>
    {
        Debug.assert(stage != null);
        final framerate = (cast stage : Stage).framerate;

        Debug.assert(framerate != null);
        Debug.assert(framerate > 0);
        
        final totalFrames = Std.int(video.duration * framerate);
        if (!video.loop && currentFrame >= totalFrames - 1) return Promise.resolve(null);

        currentFrame++;
        if (currentFrame >= totalFrames) currentFrame -= totalFrames;

        #if ide
        return new Promise<{}>((resolve, reject) ->
        {
            video.addEventListener("canplay", () -> resolve(null), { once:true });

            function updateVideoCurrentTime()
            {
                video.currentTime = Math.min(Math.max(0, video.duration - 0.0001), currentFrame / framerate + 0.0001);
            }

            if (Math.isFinite(video.duration)) updateVideoCurrentTime();
            else video.addEventListener("loadeddata", () -> updateVideoCurrentTime(), { once:true });
        });
        #else
        return Promise.resolve(null);
        #end
    }
}

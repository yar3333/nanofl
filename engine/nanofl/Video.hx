package nanofl;

import js.Browser;
import js.html.MediaElement;
import js.html.VideoElement;
import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.AdvancableDisplayObject;
import nanofl.engine.libraryitems.VideoItem;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

@:expose
class Video extends SolidContainer
    implements InstanceDisplayObject
    implements AdvancableDisplayObject
    #if !ide implements IEventHandlers #end
{
	public var symbol(default, null) : VideoItem;
    
    public var video(default, null) : VideoElement;

    public var currentFrame(default, null) : Int;
    public var duration(default, null) : Float;
	
	public function new(symbol:VideoItem)
	{
		super();
		
        Debug.assert(Std.isOfType(symbol, VideoItem));

        this.symbol = symbol;
        
		video = Browser.document.createVideoElement();
        video.src = symbol.library.realUrl(symbol.namePath + "." + symbol.ext);
        video.loop = symbol.loop;
        #if !ide video.autoplay = symbol.autoPlay; #end

        duration = symbol.duration;
		setBounds(0, 0, symbol.width, symbol.height);

        currentFrame = 0; // TODO: FIX

        if (video.readyState >= MediaElement.HAVE_CURRENT_DATA)
        {
            addChild(new easeljs.display.Bitmap(new easeljs.utils.VideoBuffer(video)));
        }
        else
        {
            addChild(new easeljs.display.Bitmap(symbol.poster));

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

    public function advance(?time:Float) : Void
    {
        Debug.assert(stage != null);
        final framerate = (cast stage : Stage).framerate;

        Debug.assert(framerate != null);
        Debug.assert(framerate > 0);
        
        final totalFrames = Std.int(video.duration * framerate);
        if (!video.loop && currentFrame >= totalFrames - 1) return;

        currentFrame++;
        if (currentFrame >= totalFrames) currentFrame -= totalFrames;

        #if ide
        video.currentTime = Math.min(Math.max(0, duration - 0.0001), currentFrame / framerate + 0.0001);
        #end
    }

    #if ide
    public function advanceTo(advanceFrames:Int)
    {
        // TODO: is this method need?
    }
    #end
}

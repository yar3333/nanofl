package nanofl;

import stdlib.Debug;
import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.libraryitems.VideoItem;
using stdlib.StringTools;
using stdlib.Lambda;

typedef VideoParams =
{
    @:optional var currentTime : Float;
}

@:expose
class Video extends SolidContainer
    implements InstanceDisplayObject
    #if !ide implements IEventHandlers #end
{
	public var symbol(default, null) : VideoItem;
    
    #if !ide
    public var video(default, null) : js.html.VideoElement;
    #end

    public final duration : Float;
	
	public function new(symbol:VideoItem, params:VideoParams)
	{
		super();
		
        Debug.assert(Std.isOfType(symbol, VideoItem));

        this.symbol = symbol;
        
        duration = symbol.duration;
		setBounds(0, 0, symbol.width, symbol.height);
		
        #if !ide
        video = js.Browser.document.createVideoElement();
        video.src = symbol.library.realUrl(symbol.namePath + "." + symbol.ext);
        video.loop = symbol.loop;
        video.autoplay = symbol.autoPlay;
        video.currentTime = params?.currentTime ?? 0.0001;
        addChild(new easeljs.display.Bitmap(new easeljs.utils.VideoBuffer(video)));
        #end
	}

	override public function clone(?recursive:Bool) : Video 
	{
		final r : Video = (cast this)._cloneProps(new Video(symbol, null));

        #if !ide
        r.video.currentTime = video.currentTime;
        #end
        
        return r;
	}
	
	override public function toString() : String 
	{
		return symbol.toString();
	}

	#if !ide
	// IEventHandlers
	public function onEnterFrame() : Void {}
	public function onMouseDown(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseMove(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseUp(e:easeljs.events.MouseEvent) : Void {}
	#end
}

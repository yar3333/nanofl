package nanofl;

import js.Browser;
import js.html.VideoElement;
import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.libraryitems.VideoItem;
import stdlib.Debug;
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
    
    public var video(default, null) : VideoElement;

    public var duration(default, null) : Float;
	
	public function new(symbol:VideoItem, params:VideoParams)
	{
		super();
		
        Debug.assert(Std.isOfType(symbol, VideoItem));

        this.symbol = symbol;
        
		video = Browser.document.createVideoElement();
        video.src = symbol.library.realUrl(symbol.namePath + "." + symbol.ext);
        video.loop = symbol.loop;
        video.autoplay = symbol.autoPlay;

        duration = symbol.duration;
		setBounds(0, 0, symbol.width, symbol.height);

        video.currentTime = params?.currentTime ?? 0.0;

        addChild(new easeljs.display.Bitmap(new easeljs.utils.VideoBuffer(video)));
	}

	override public function clone(?recursive:Bool) : Video 
	{
		final r : Video = (cast this)._cloneProps(new Video(symbol, null));
        r.video.currentTime = video.currentTime;
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

package nanofl;

import js.Browser;
import js.html.VideoElement;
import nanofl.engine.InstanceDisplayObject;
import nanofl.engine.libraryitems.VideoItem;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

@:expose
class Video extends SolidContainer
    implements InstanceDisplayObject
    #if !ide implements IEventHandlers #end
{
	public var symbol(default, null) : VideoItem;
    
    public var video(default, null) : VideoElement;

    public var duration(default, null) : Float;
	
	public function new(symbol:VideoItem)
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

        addChild(new easeljs.display.Bitmap(new easeljs.utils.VideoBuffer(video)));
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
	// IEventHandlers
	public function onEnterFrame() : Void {}
	public function onMouseDown(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseMove(e:easeljs.events.MouseEvent) : Void {}
	public function onMouseUp(e:easeljs.events.MouseEvent) : Void {}
	#end
}

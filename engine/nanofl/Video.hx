package nanofl;

import js.html.VideoElement;
import easeljs.utils.VideoBuffer;
import nanofl.engine.libraryitems.VideoItem;
import stdlib.Debug;
using stdlib.StringTools;
using stdlib.Lambda;

@:expose
class Video extends SolidContainer
    #if !ide implements IEventHandlers #end
{
	public var symbol(default, null) : VideoItem;

    var bitmap : easeljs.display.Bitmap;
    
    public var video : VideoElement;
	
	public function new(symbol:VideoItem)
	{
		super();
		
        Debug.assert(Std.isOfType(symbol, VideoItem));

		this.symbol = symbol;
		symbol.updateDisplayObject(this, null);

        #if ide
        bitmap = new easeljs.display.Bitmap(symbol.poster);
        #else
        bitmap = new easeljs.display.Bitmap(new VideoBuffer(video));
        #end

        addChild(bitmap);
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
}

package nanofl;

import easeljs.events.MouseEvent;
import nanofl.engine.libraryitems.MovieClipItem;

@:expose
class Button extends MovieClip
{
	public function new(symbol:MovieClipItem)
	{
		super(symbol, 0, null);
		
		stop();
		
		if (getTotalFrames() >= 4)
		{
			var hitSymbol = cast(symbol.duplicate("__nanofl_temp"), MovieClipItem);
			hitSymbol.likeButton = false;
			hitSymbol.linkedClass = "";
			hitArea = hitSymbol.createDisplayObject(3, null);
			hitSymbol.remove();
		}
		
		cursor = "pointer";
	}
	
	override function onMouseDown(e:MouseEvent)
	{
		if (getTotalFrames() >= 3 && currentFrame != 2)
		{
			if ((hitArea != null ? hitArea : this).hitTest(e.localX, e.localY)) gotoAndStop(2);
		}
	}
	
	override function onMouseMove(e:MouseEvent)
	{
		if (getTotalFrames() >= 2 && currentFrame != 2)
		{
			gotoAndStop((hitArea != null ? hitArea:this).hitTest(e.localX, e.localY) ? 1 : 0);
		}
	}
	
	override function onMouseUp(e:MouseEvent)
	{
		if (getTotalFrames() > 0 && currentFrame != 0)
		{
			gotoAndStop(0);
		}
	}
}
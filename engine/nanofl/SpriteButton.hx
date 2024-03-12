package nanofl;

import easeljs.events.MouseEvent;
import nanofl.engine.libraryitems.MovieClipItem;

@:expose
class SpriteButton extends Sprite
{
	public function new(symbol:MovieClipItem)
	{
		super(symbol, null);
		
		stop();
		
		if (symbol.spriteSheet.getNumFrames() >= 4)
		{
			hitArea = spriteSheet.getFrame(3);
		}
		
		cursor = "pointer";
	}
	
	function onMouseDown(e:MouseEvent)
	{
		if (spriteSheet.getNumFrames() >= 3 && currentFrame != 2)
		{
			if ((hitArea != null ? hitArea : this).hitTest(e.localX, e.localY)) gotoAndStop(2);
		}
	}
	
	function onMouseMove(e:MouseEvent)
	{
		if (spriteSheet.getNumFrames() >= 2 && currentFrame != 2)
		{
			gotoAndStop((hitArea != null ? hitArea:this).hitTest(e.localX, e.localY) ? 1 : 0);
		}
	}
	
	function onMouseUp(e:MouseEvent)
	{
		if (spriteSheet.getNumFrames() > 0 && currentFrame != 0)
		{
			gotoAndStop(0);
		}
	}
}
package nanofl;

import nanofl.engine.libraryitems.MovieClipItem;

@:expose
class Button extends MovieClip
{
	public function new(symbol:MovieClipItem)
	{
		super(symbol, null);
		
		stop();
		
		if (getTotalFrames() >= 4)
		{
			hitArea = new MovieClip(symbol, { currentFrame:3 });
		}
		
		cursor = "pointer";
	}
	
	#if !ide
    override function onMouseDown(e:easeljs.events.MouseEvent)
	{
		if (getTotalFrames() >= 3 && currentFrame != 2)
		{
			if ((hitArea != null ? hitArea : this).hitTest(e.localX, e.localY)) gotoAndStop(2);
		}
	}
	
	override function onMouseMove(e:easeljs.events.MouseEvent)
	{
		if (getTotalFrames() >= 2 && currentFrame != 2)
		{
			gotoAndStop((hitArea != null ? hitArea:this).hitTest(e.localX, e.localY) ? 1 : 0);
		}
	}
	
	override function onMouseUp(e:easeljs.events.MouseEvent)
	{
		if (getTotalFrames() > 0 && currentFrame != 0)
		{
			gotoAndStop(0);
		}
	}
    #end
}
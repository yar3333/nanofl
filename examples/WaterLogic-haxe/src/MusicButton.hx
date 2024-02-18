import createjs.MouseEvent;
import nanofl.SeamlessSoundLoop;

class MusicButton extends base.MusicButton
{
	var soundLoop : SeamlessSoundLoop;
	
	function new()
	{
		super();
		cursor = "pointer";
		musicOn();
	}
	
	override function onMouseUp(e:MouseEvent)
	{
		if (getBounds().contains(e.localX, e.localY))
		{
			if (currentFrame == 1) musicOn();
			else                   musicOff();
		}
	}
	
	function musicOn()
	{
		gotoAndStop(0);
		soundLoop = new SeamlessSoundLoop(Sounds.music());
		addRemovedEventListener(function(_) soundLoop.stop());
	}
	
	function musicOff()
	{
		gotoAndStop(1);
		soundLoop.stop();
	}
}

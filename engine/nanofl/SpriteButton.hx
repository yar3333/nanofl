package nanofl;

import easeljs.events.MouseEvent;
import easeljs.display.SpriteSheet;

@:expose
class SpriteButton extends Sprite
{
	public function new(spriteSheet:SpriteSheet)
	{
		super(spriteSheet);
		
		stop();
		
		if (spriteSheet.getNumFrames() >= 4)
		{
			hitArea = spriteSheet.getFrame(3);
		}
		
		cursor = "pointer";
		
		//Player.stage.addStagemousedownEventListener(stageMouseEventProxy.bind(onMouseDown));
		//Player.stage.addStagemousemoveEventListener(stageMouseEventProxy.bind(onMouseMove));
		//Player.stage.addStagemouseupEventListener(stageMouseEventProxy.bind(onMouseUp));
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
	
	function stageMouseEventProxy(f:MouseEvent->Void, e:MouseEvent)
	{
		var t = e.currentTarget;
		e.currentTarget = this;
		f(e);
		e.currentTarget = t;
	}
}
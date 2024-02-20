import { base, Sounds } from './autogen';

export class MusicButton extends base.MusicButton
{
	soundLoop : nanofl.SeamlessSoundLoop;
	
	constructor()
	{
		super();
		this.cursor = "pointer";
		this.musicOn();
	}
	
	onMouseUp(e:createjs.MouseEvent)
	{
		if (this.getBounds().contains(e.localX, e.localY))
		{
			if (this.currentFrame == 1) this.musicOn();
			else                        this.musicOff();
		}
	}
	
	musicOn()
	{
		this.gotoAndStop(0);
		this.soundLoop = new nanofl.SeamlessSoundLoop(Sounds.music());
		this.addEventListener("removed", () => this.soundLoop.stop());
	}
	
	musicOff()
	{
		this.gotoAndStop(1);
		this.soundLoop.stop();
	}
}

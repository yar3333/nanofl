import { base, Sounds } from './autogenerated';

export class MusicButton extends base.MusicButton
{
	soundLoop : nanofl.SeamlessSoundLoop;

    init()
    {
		this.cursor = "pointer";
		this.musicOn();
    }
	
	onMouseUp(e:nanofl.MouseEvent)
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
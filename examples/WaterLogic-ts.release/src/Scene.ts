import { base } from './autogen';

export class Scene extends base.Scene
{
	initFrame : number = null;

    level = 1;
	
	onEnterFrame()
	{
		if (this.currentFrame != this.initFrame)
		{
			this.initFrame = this.currentFrame;
            this.btGotoGame?.addEventListener("click", () => this.gotoAndStop("Game"));
            this.btRules?.addEventListener("click", () => this.gotoAndStop("Rules"));
            this.btGotoOrigin?.addEventListener("click", () => this.gotoAndStop("Origin"));
		}
	}
}
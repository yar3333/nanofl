import { base } from './autogen';

export class Scene extends base.Scene
{
	lastInitFrame : number = null;
	
	onEnterFrame()
	{
		if (this.currentFrame != this.lastInitFrame)
		{
			this.lastInitFrame = this.currentFrame;
			this.addButtonHandler("btGotoGame", () => this.gotoAndStop("Game"));
			this.addButtonHandler("btRules", () => this.gotoAndStop("Rules"));
			this.addButtonHandler("btScores", () => this.gotoAndStop("Scores"));
			this.addButtonHandler("btGotoOrigin", () => this.gotoAndStop("Origin"));
		}
	}
	
	addButtonHandler(name:string, f:(p:void)=>void)
	{
		var bt = this.getChildByName(name);
		if (bt != null) bt.addEventListener("click", () => f());
	}
}
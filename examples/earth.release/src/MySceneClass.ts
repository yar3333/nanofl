import { base } from '../nanofl-code';

export class MySceneClass extends base.MySceneClass
{
	init()
	{
		createjs.Ticker.timingMode = createjs.Ticker.RAF_SYNCHED;
		
		//this.txtRenderer.text = this.myEarth.renderer instanceof js.three.WebGLRenderer) ? "WebGL" : "Canvas";
		//this.txtRenderer.textRuns[0].family = "Times";
	}
	
	onEnterFrame()
	{
		this.myEarth.rotationY += 0.5;
		this.txtFPS.text = Math.round(createjs.Ticker.getMeasuredFPS()) + "";
	}
}
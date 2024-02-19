import { base } from './autogen';
import { REVISION } from 'three';

export class MySceneClass extends base.MySceneClass
{
	init()
	{
		createjs.Ticker.timingMode = createjs.Ticker.RAF_SYNCHED;
		
		this.txtRenderer.text = "three v" + REVISION;
		this.txtRenderer.textRuns[0].family = "Times";
	}
	
	onEnterFrame()
	{
		this.myEarth.rotationY += 0.5;
		this.txtFPS.text = Math.round(createjs.Ticker.getMeasuredFPS()) + "";
	}

    onMouseDown(e: createjs.MouseEvent): void
    {
        console.log("onMouseDown");
    }
}
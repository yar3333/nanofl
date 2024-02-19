import { base } from './nanofl-code';

export class MyButton extends base.MyButton
{
	init()
	{
		console.log("MyButton: init");
	}

    onMouseDown(e: createjs.MouseEvent)
    {
        super.onMouseDown(e);

        if (this.hitTest(e.localX, e.localY))
        {
            console.log("MyButton: onMouseDown inside hit area");
        }
    }
}

export class MyButton extends nanofl.Button
{
	init()
	{
		console.log("init in MyButton");
	}

    onMouseDown(e: createjs.MouseEvent)
    {
        super.onMouseDown(e);

        if (this.hitTest(e.localX, e.localY))
        {
            console.log("onMouseDown in MyButton");
        }
    }
}

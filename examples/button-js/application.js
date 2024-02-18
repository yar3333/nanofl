class MyButton extends nanofl.Button
{
	init()
	{
		console.log("init in MyButton");
	} 
}

// expose class to be visible for NanoFL player
window.MyButton = MyButton;

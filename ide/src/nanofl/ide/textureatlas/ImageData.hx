package nanofl.ide.textureatlas;

typedef ImageData =
{
	var canvas : js.html.CanvasElement;
	var refs : Array<{ namePath:String, frameIndex:Int, regX:Float, regY:Float }>;
}

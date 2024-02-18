package nanofl.engine.strokes;

@:noapi
enum TypedStroke
{
	solid(stroke:SolidStroke);
	linear(stroke:LinearStroke);
	radial(stroke:RadialStroke);
	bitmap(stroke:BitmapStroke);
}
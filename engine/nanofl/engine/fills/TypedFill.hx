package nanofl.engine.fills;

@:noapi
enum TypedFill
{
	solid(fill:SolidFill);
	linear(fill:LinearFill);
	radial(fill:RadialFill);
	bitmap(fill:BitmapFill);
}
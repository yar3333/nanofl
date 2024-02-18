package svgimport.segments;

class Segment
{
	public var x : Float;
	public var y : Float;

	public function new(inX:Float, inY:Float)
	{
		x = inX;
		y = inY;
	}
	
	public function getType() : SegmentType return null;

	public function prevX() return x;
	public function prevY() return y;
	public function prevCX() return x;
	public function prevCY() return y;

	public function export(exporter:SvgPathToShapeConvertor) throw "Segment.export() must be overriden.";
	
	public function toString() return "Segment(" + prevX() + "," + prevY() + ", " + x + "," + y + ")";
}

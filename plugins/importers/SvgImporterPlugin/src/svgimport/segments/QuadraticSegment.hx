package svgimport.segments;

class QuadraticSegment extends Segment
{
	public var cx : Float;
	public var cy : Float;

	public function new(inCX:Float, inCY:Float, inX:Float, inY:Float)
	{
		super(inX, inY);
		cx = inCX;
		cy = inCY;
	}

	override public function prevCX() return cx;
	override public function prevCY() return cy;

	override public function export(exporter:SvgPathToShapeConvertor)
	{
		exporter.curveTo(cx, cy, x, y);
	}

	override public function getType() return SegmentType.CURVE(this);
}

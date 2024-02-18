package flashimport;

import nanofl.engine.geom.Point;

class StraightEdge implements IEdge
{
	public var from(get, null) : Point; function get_from() return from;
	public var to(get, null) : Point; function get_to() return to;
	public var lineStyleIdx(get, null) : Int; function get_lineStyleIdx() return lineStyleIdx;
	public var fillStyleIdx(get, null) : Int; function get_fillStyleIdx() return fillStyleIdx;
	
	public function new(from:Point, to:Point, lineStyleIdx=0, fillStyleIdx=0)
	{
		this.from = from;
		this.to = to;
		this.lineStyleIdx = lineStyleIdx;
		this.fillStyleIdx = fillStyleIdx;
	}
	
	public function reverseWithNewFillStyle(newFillStyleIdx:Int) : IEdge
	{
		return new StraightEdge(to, from, lineStyleIdx, newFillStyleIdx);
	}	
}

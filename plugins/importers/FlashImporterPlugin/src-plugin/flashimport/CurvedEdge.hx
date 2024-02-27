package flashimport;

import nanofl.engine.geom.Point;

class CurvedEdge extends StraightEdge implements IEdge
{
	public var control(default, null) : Point;
	
	public function new(from:Point, control:Point, to:Point, lineStyleIdx=0, fillStyleIdx=0)
	{
		super(from, to, lineStyleIdx, fillStyleIdx);
		this.control = control;
	}
	
	override public function reverseWithNewFillStyle(newFillStyleIdx:Int) : IEdge
	{
		return new CurvedEdge(to, control, from, lineStyleIdx, newFillStyleIdx);
	}
}

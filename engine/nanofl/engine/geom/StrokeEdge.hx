package nanofl.engine.geom;

import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Matrix;
import nanofl.engine.strokes.IStroke;
using nanofl.engine.geom.PointTools;

class StrokeEdge extends Edge implements nanofl.engine.ISelectable
{
	public var stroke : IStroke;
	
	@:isVar public var selected(get, set) : Bool;
	function get_selected() return selected;
	function set_selected(v:Bool) return selected = v;
	
	public function new(x1:Float, y1:Float, x2:Float, y2:Float, ?x3:Float, ?y3:Float, ?stroke:IStroke, selected=false)
	{
		super(x1, y1, x2, y2, x3, y3);
		this.stroke = stroke;
		this.selected = selected;
	}
	
	public static function fromEdge(edge:Edge, ?stroke:IStroke, selected=false) : StrokeEdge
	{
		return new StrokeEdge(edge.x1, edge.y1, edge.x2, edge.y2, edge.x3, edge.y3, stroke, selected);
	}
	
	public function getNearestPointUseStrokeSize(x:Float, y:Float) : { point:Point, t:Float }
	{
		var pointAndT = getNearestPoint(x, y);
		pointAndT.point.moveInDirection(x, y, stroke != null ? stroke.thickness / 2 : 0);
		return pointAndT;
	}
	
	public function addTo(edges:Array<StrokeEdge>)
	{
		var n = indexIn(edges);
		if (n >= 0) edges[n].stroke = stroke;
		else		edges.push(this);
	}
	
	override public function transform(m:Matrix, applyToStrokeThickness=true) 
	{
		super.transform(m);
		if (stroke != null) stroke = stroke.getTransformed(m, applyToStrokeThickness);
	}
	
	override public function translate(dx:Float, dy:Float) 
	{
		super.translate(dx, dy);
		if (stroke != null) stroke = stroke.getTransformed(new Matrix(1, 0, 0, 1, dx, dy), false);
	}
	
	override public function clone() : StrokeEdge
	{
		return new StrokeEdge(x1, y1, x2, y2, x3, y3, stroke.clone(), selected);
	}
	
	override function duplicate(e:Edge) : StrokeEdge
	{
		return new StrokeEdge(e.x1, e.y1, e.x2, e.y2, e.x3, e.y3, stroke, selected);
	}
	
	override public function split(tt:Array<Float>) : Array<Edge> 
	{
		return cast super.split(tt).map(fromEdge.bind(_, stroke, selected));
	}
	
	override public function toString()
	{
		return isStraight()
			? 'new StrokeEdge($x1,$y1, $x3,$y3, $stroke, $selected)'
			: 'new StrokeEdge($x1,$y1, $x2,$y2, $x3,$y3, $stroke, $selected)';
	}
}
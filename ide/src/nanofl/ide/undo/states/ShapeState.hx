package nanofl.ide.undo.states;

import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import datatools.ArrayTools;
import nanofl.engine.geom.Polygons;
import nanofl.engine.geom.StrokeEdges;
using stdlib.Lambda;

class ShapeState extends ElementState
{
	public var edges(default, null) : Array<StrokeEdge>;
	public var polygons(default, null) : Array<Polygon>;
	
	public function new(edges:Array<StrokeEdge>, polygons:Array<Polygon>)
	{
		this.edges = edges;
		this.polygons = polygons;
	}
	
	override public function equ(_state:ElementState) : Bool
	{
		var state = cast(_state, ShapeState);
		return StrokeEdges.equ(edges, state.edges) && Polygons.equ(polygons, state.polygons);
	}
	
	override public function toString() : String
	{
		return "new ShapeElement("
			+ (edges.length > 0 ? "[\n" + edges.join(",\n") + "\n]"  : "[]")
			+ ", "
			+ (polygons.length > 0 ? "[\n" + polygons.join(",\n") + "\n]"  : "[]")
			+ ")";
	}
}

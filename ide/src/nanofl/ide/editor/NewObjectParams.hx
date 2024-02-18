package nanofl.ide.editor;

import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.BitmapFill;
import nanofl.engine.fills.FillParams;
import nanofl.engine.fills.IFill;
import nanofl.engine.fills.LinearFill;
import nanofl.engine.fills.RadialFill;
import nanofl.engine.fills.SolidFill;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.strokes.BitmapStroke;
import nanofl.engine.strokes.IStroke;
import nanofl.engine.strokes.LinearStroke;
import nanofl.engine.strokes.RadialStroke;
import nanofl.engine.strokes.SolidStroke;
import nanofl.engine.strokes.StrokeParams;
import nanofl.TextRun;
import nanofl.ide.InjectContainer;

@:rtti
class NewObjectParams extends InjectContainer
{
	inline static var STROKE_COLOR = "#000000";
	inline static var FILL_COLOR = "#f9b233";
	
	@inject var app : Application;
	
	var shape : ShapeElement;
	
	public var strokeType = "solid";
	public var fillType = "solid";
	
	public var stroke(get, never) : IStroke;
	function get_stroke() return getStrokeByType(strokeType);
	
	public var fill(get, never) : IFill;
	function get_fill() return getFillByType(fillType);
	
	public var roundRadius = 0.0;
	
	public var textFormat(default, null) : TextRun = new TextRun();
	
	public function new()
	{
		super();
		
		var edges = [];
		edges.push(StrokeEdge.fromEdge(new StrokeEdge(0, 0, 1, 0), new SolidStroke(STROKE_COLOR),                                         true));
		edges.push(StrokeEdge.fromEdge(new StrokeEdge(0, 1, 1, 1), new LinearStroke([FILL_COLOR, STROKE_COLOR], [0, 1], 0, 0, 100, 0),    true));
		edges.push(StrokeEdge.fromEdge(new StrokeEdge(0, 2, 1, 2), new RadialStroke([FILL_COLOR, STROKE_COLOR], [0, 1], 0, 0, 100, 0, 0), true));
		edges.push(StrokeEdge.fromEdge(new StrokeEdge(0, 3, 1, 3), new BitmapStroke(null, "repeat"),                                      true));
		
		var contours =
		[
			new Contour
			([ 
				new StrokeEdge(0, 0, 0, 1),
				new StrokeEdge(0, 1, 1, 1),
				new StrokeEdge(1, 1, 0, 0)
			])
		];
		
		var polygons = [];
		polygons.push(new Polygon(new SolidFill(FILL_COLOR),                                           contours, true));
		polygons.push(new Polygon(new LinearFill([FILL_COLOR, STROKE_COLOR], [0, 1], 0, 0, 100, 0),    contours, true));
		polygons.push(new Polygon(new RadialFill([FILL_COLOR, STROKE_COLOR], [0, 1], 0, 0, 100, 0, 0), contours, true));
		polygons.push(new Polygon(new BitmapFill(null, "repeat", new Matrix()),                        contours, true));
		
		shape = new ShapeElement(edges, polygons, false);
	}
	
	public function setStroke(stroke:IStroke)
	{
		for (edge in shape.edges)
		{
			if (Type.getClass(edge.stroke) == Type.getClass(stroke))
			{
				edge.stroke = stroke;
			}
		}
	}
	
	public function setFill(fill:IFill)
	{
		for (polygon in shape.polygons)
		{
			if (Type.getClass(polygon.fill) == Type.getClass(fill))
			{
				polygon.fill = fill;
			}
		}
	}
	
	public function setStrokeParams(p:StrokeParams)
	{
		shape.setSelectedEdgesStrokeParams(p);
	}
	
	public function getStrokeParams() : {>StrokeParams, type:String }
	{
		var r = shape.getSelectedEdgesStrokeParams();
		r.type = strokeType;
		return r;
	}
	
	public function setFillParams(p:FillParams)
	{
		shape.setSelectedPolygonsFillParams(p);
	}
	
	public function getFillParams() : {>FillParams, type:String }
	{
		var r = shape.getSelectedPolygonsFillParams();
		r.type = fillType;
		return r;
	}
	
	public function getStrokeByType(type:String) : IStroke
	{
		var r = switch (type)
		{
			case "none":	null;
			case "solid":	shape.edges[0].stroke;
			case "linear":	shape.edges[1].stroke;
			case "radial":	shape.edges[2].stroke;
			case "bitmap":	shape.edges[3].stroke;
			case _:			throw "Unknow stroke type '" + type + "'.";
		}
		if (r != null) r.setLibrary(cast app.document.library.getRawLibrary());
		return r;
	}
	
	public function getFillByType(type:String) : IFill
	{
		var r = switch (type)
		{
			case "none":	null;
			case "solid":	shape.polygons[0].fill;
			case "linear":	shape.polygons[1].fill;
			case "radial":	shape.polygons[2].fill;
			case "bitmap":	shape.polygons[3].fill;
			case _:			throw "Unknow fill type '" + type + "'.";
		};
		if (r != null) r.setLibrary(cast app.document.library.getRawLibrary());
		return r;
	}
}
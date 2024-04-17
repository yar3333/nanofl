package nanofl.engine.elements;

import js.lib.Set;
import stdlib.Debug;
import datatools.ArrayTools;
import nanofl.engine.geom.Bounds;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Contours;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.Polygons;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.geom.StrokeEdges;
import nanofl.engine.Log.console;
import nanofl.engine.Library;
import nanofl.engine.fills.*;
import nanofl.engine.strokes.*;
using nanofl.engine.geom.PointTools;
using nanofl.engine.geom.BoundsTools;
using stdlib.Lambda;
using StringTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

#if profiler @:build(Profiler.buildMarked()) #end
class ShapeElement extends Element
{
	function get_type() return ElementType.shape;

	public var edges(default, null) : Array<StrokeEdge>;
	public var polygons(default, null) : Array<Polygon>;
	
	public function new(?edges:Array<StrokeEdge>, ?polygons:Array<Polygon>, isNormalize=true)
	{
		super();
		
		this.edges = edges != null ? edges:[];
		this.polygons = polygons != null ? polygons : [];
		if (isNormalize) normalize();
	}
	
    #if ide
	override function loadProperties(base:HtmlNodeElement, version:String) : Bool
	{
		if (!super.loadProperties(base, version)) return false;
		
		var fills = new Array<IFill>();
		var strokes = new Array<IStroke>();
		
		for (node in base.children)
		{
			if (node.name == "fills")
			{
				for (node in node.children)
				{
					if (node.name == "fill")
					{
                        fills.push(BaseFill.load(node, version));
					}
				}
			}
			else
			if (node.name == "strokes")
			{
				for (node in node.children)
				{
					if (node.name == "stroke")
					{
						strokes.push(BaseStroke.load(node, version));
					}
				}
			}
			else
			if (node.name == "figure")
			{
				edges = StrokeEdges.load(node.children.filter(x -> x.name == "edge"), strokes, version);
                polygons = node.children.filter(x -> x.name == "polygon").map(x -> Polygon.load(x, fills, version));
			}
		}
		
		ensureNoTransform();
		
		return true;
	}
    #end

	override function loadPropertiesJson(obj:Dynamic, version:String) : Bool
    {
		if (!super.loadPropertiesJson(obj, version)) return false;
		
		var fills = new Array<IFill>();
		var strokes = new Array<IStroke>();
		
        for (fillObj in (cast obj.fills : Array<Dynamic>) ?? [])
        {
            switch (fillObj.type ?? "solid")
            {
                case "solid": fills.push(SolidFill.loadJson(fillObj, version));
                case "linear": fills.push(LinearFill.loadJson(fillObj, version));
                case "bitmap": fills.push(BitmapFill.loadJson(fillObj, version));
                case "radial": fills.push(RadialFill.loadJson(fillObj, version));
                case _: log(() -> "Unknow fill type '" + fillObj.type + "'.");
            }
        }

        for (strokeObj in (cast obj.strokes : Array<Dynamic>) ?? [])
        {
            strokes.push(BaseStroke.loadJson(strokeObj, version));
        }

        if (obj.figure != null)
        {
            edges = StrokeEdges.loadJson(obj.figure.edges, strokes, version);
            polygons = (cast obj.figure.polygons : Array<Dynamic>).map(x -> Polygon.loadJson(x, fills, version));
        }
		
		ensureNoTransform();
		
		return true;
    }
	
	function getFills() : Array<IFill>
	{
		var fills = new Array<IFill>();
		for (p in polygons)
		{
			if (fills.findIndex(fill -> fill.equ(p.fill)) < 0)
			{
				fills.push(p.fill);
			}
		}
		return fills;
	}
	
	function getStrokes() : Array<IStroke>
	{
		var strokes = new Array<IStroke>();
		for (e in edges)
		{
			if (strokes.findIndex(stroke -> stroke.equ(e.stroke)) < 0)
			{
				strokes.push(e.stroke);
			}
		}
		return strokes;
	}
	
    #if ide
	override public function saveProperties(out:XmlBuilder)
	{
		if (isEmpty()) return;
		
		super.saveProperties(out);
		
		var fills = getFills();
		if (fills.length > 0)
		{
			out.begin("fills");
			for (fill in fills) fill.save(out);
			out.end();
		}
		
		var strokes = getStrokes();
		if (strokes.length > 0)
		{
			out.begin("strokes");
			for (stroke in strokes) stroke.save(out);
			out.end();
		}
		
		out.begin("figure");
		
		for (p in polygons)
		{
			p.save(fills, out);
		}
		
		StrokeEdges.save(edges, strokes, out);
		
		out.end();
	}

    override function savePropertiesJson(obj:Dynamic) : Void
    {
		if (isEmpty()) return;

        super.savePropertiesJson(obj);

		var fills = getFills();
		if (fills.length > 0)
		{
			obj.fills = fills.map(x -> x.saveJson());
		}
		
		var strokes = getStrokes();
		if (strokes.length > 0)
		{
			obj.strokes = strokes.map(x -> x.saveJson());
		}
		
		obj.figure =
        {
            edges: StrokeEdges.saveJson(edges, strokes),
            polygons: polygons.map(p -> p.saveJson(fills)),
        };
    }
    #end
	
	public function ensureNoTransform() : Void
	{
		transform(matrix);
		
		matrix.tx = 0;
		matrix.ty = 0;
		matrix.a = 1;
		matrix.b = 0;
		matrix.c = 0;
		matrix.d = 1;
	}
	
	public function draw(g:ShapeRender, scaleSelection:Float)
	{
		for (p in polygons) p.draw(g, scaleSelection);
		StrokeEdges.drawSorted(edges, g, scaleSelection);
	}
	
	function createDisplayObject() : easeljs.display.Shape
	{
        final shape = new easeljs.display.Shape();
		
		elementUpdateDisplayObjectBaseProperties(shape);
		
		shape.graphics.clear();
		var m = shape.getConcatenatedMatrix().invert();
		draw(shape.graphics, (m.a + m.d) / 2);
		
		if (!isEmpty())
		{
			var b = getBounds();
			shape.setBounds(b.minX, b.minY, b.maxX - b.minX, b.maxY - b.minY);
		}
		
		return shape;
	}
	
	public function clone() : ShapeElement
	{
		var obj = new ShapeElement(ArrayTools.clone(edges), ArrayTools.clone(polygons));
		copyBaseProperties(obj);
		return obj;
	}
	
	override public function translate(dx:Float, dy:Float)
	{
		if (dx == 0 && dy == 0) return;
		for (e in edges) e.translate(dx, dy);
		for (p in polygons) p.translate(dx, dy);
	}
	
	public function isEmpty() : Bool
	{
		return edges.length == 0 && polygons.length == 0;
	}
	
	public function hasSelected()
	{
		return hasSelectedEdges() || hasSelectedPolygons();
	}
	
	public function isAllSelected()
	{
		return edges.foreach(e -> e.selected) && polygons.foreach(e -> e.selected);
	}
	
	public function hasSelectedEdges()
	{
		return edges.exists(e -> e.selected);
	}
	
	public function hasSelectedPolygons()
	{
		return polygons.exists(e -> e.selected);
	}
	
	public function select(obj:{ selected:Bool })
	{
		deselectAll();
		if (obj != null) obj.selected = true;
	}
	
	public function selectAll()
	{
		for (edge in edges) edge.selected = true;
		for (polygon in polygons) polygon.selected = true;
	}
	
	public function deselectAll()
	{
		for (edge in edges) edge.selected = false;
		for (polygon in polygons) polygon.selected = false;
	}
	
	public function translateSelected(dx:Float, dy:Float)
	{
		for (edge in edges)
		{
			if (edge.selected)
			{
				edge.translate(dx, dy);
			}
		}
		
		for (polygon in polygons)
		{
			if (polygon.selected)
			{
				polygon.translate(dx, dy);
			}
		}
	}
	
	public function translateVertex(point:Point, dx:Float, dy:Float)
	{
		for (edge in edges)
		{
			edge.translateVertex(point, dx, dy);
		}
		
		for (polygon in polygons)
		{
			polygon.translateVertex(point, dx, dy);
		}
	}
	
	public function removeSelected()
	{
		var edgeWasRemoved = edges.exists(e -> e.selected);
		
		var i = 0; while (i < edges.length)
		{
			if (edges[i].selected) edges.splice(i, 1);
			else				   i++;
		}
		var i = 0; while (i < polygons.length)
		{
			if (polygons[i].selected) polygons.splice(i, 1);
			else					  i++;
		}
		
		if (edgeWasRemoved)
		{
			Polygons.mergeByCommonEdges(polygons, edges);
		}
	}
	
	public function getPolygonAtPos(pt:Point) : Polygon
	{
		for (polygon in polygons)
		{
			if (polygon.isPointInside(pt.x, pt.y))
			{
				return polygon;
			}
		}
		return null;
	}
	
	public function getSameEdges(edge:Edge) : Array<Edge>
	{
		var r = new Array<Edge>();
		
		if (edge == null) return r;
		
		for (e in edges) if (e.equ(edge)) r.push(e);
		
		for (p in polygons)
		for (c in p.contours)
		for (e in c.edges)
		{
			if (e.equ(edge)) r.push(e);
		}
		
		return r;
	}
	
	public function getNearestStrokeEdge(pt:Point) : { edge:StrokeEdge, dist:Float, point:Point, t:Float }
	{
		var r = { edge:null, dist:1e100, point:null, t:0.0 };
		
		for (edge in edges)
		{
			var pointAndT = new Edge(edge.x1, edge.y1, edge.x2, edge.y2, edge.x3, edge.y3).getNearestPoint(pt.x, pt.y);
			var dist = pt.getDistP(pointAndT.point);
			if (dist < r.dist)
			{
				r.edge = edge;
				r.dist = dist;
				r.point = pointAndT.point;
				r.t = pointAndT.t;
			}
		}
		
		return r.edge != null ? r : null;
	}
	
	public function getNearestPolygonEdge(pt:Point) : { edge:Edge, dist:Float, point:Point, t:Float }
	{
		var edges = []; for (polygon in polygons) polygon.getEdges(edges);
		
		var bestEdge : Edge = null;
		var bestDist2 = 1.0e100;
		var bestPoint : Point = null;
		var bestT : Float = null;
		
		for (edge in edges)
		{
			var posAndT = edge.getNearestPoint(pt.x, pt.y);
			var dist2 = pt.getSqrDistP(posAndT.point);
			if (dist2 < bestDist2)
			{
				bestEdge = edge;
				bestDist2 = dist2;
				bestPoint = posAndT.point;
				bestT = posAndT.t;
			}
		}
		
		return bestEdge != null ? { edge:bestEdge, dist:Math.sqrt(bestDist2), point:bestPoint, t:bestT } : null;
	}
	
	public function getNearestVertex(pt:Point, excludeSelf=false) : { point:Point, dist:Float, distMinusEdgeThickness:Float }
	{
		var bestPoint : Point = null;
		var bestDist = 1.0e100;
		var bestDistMinusEdgeThickness = 1.0e100;
		
		for (edge in edges)
		{
			var M1 = { x:edge.x1, y:edge.y1 };
			if (!excludeSelf || M1.x != pt.x || M1.y != pt.y)
			{
				var dist = pt.getDistP(M1);
				if (dist < bestDist) { bestPoint = M1; bestDist = dist; bestDistMinusEdgeThickness = Math.max(0, dist - edge.stroke.thickness / 2); }
			}
			
			var M2 = { x:edge.x3, y:edge.y3 };
			if (!excludeSelf || M2.x != pt.x || M2.y != pt.y)
			{
				var dist = pt.getSqrDistP(M2);
				if (dist < bestDist) { bestPoint = M2; bestDist = dist; bestDistMinusEdgeThickness = Math.max(0, dist - edge.stroke.thickness / 2); }
			}
		}
		
		for (polygon in polygons)
		{
			for (edge in polygon.getEdges())
			{
				var M1 = { x:edge.x1, y:edge.y1 };
				if (!excludeSelf || M1.x != pt.x || M1.y != pt.y)
				{
					var dist = pt.getDistP(M1);
					if (dist < bestDist) { bestPoint = M1; bestDist = dist; bestDistMinusEdgeThickness = dist; }
				}
				
				var M2 = { x:edge.x3, y:edge.y3 };
				if (!excludeSelf || M2.x != pt.x || M2.y != pt.y)
				{
					var dist = pt.getDistP(M2);
					if (dist < bestDist) { bestPoint = M2; bestDist = dist; bestDistMinusEdgeThickness = dist; }
				}
			}
		}
		
		return bestPoint != null ? { point:bestPoint, dist:bestDist, distMinusEdgeThickness:bestDistMinusEdgeThickness } : null;
	}
	
	public function setSelectedEdgesStroke(stroke:IStroke)
	{
		for (edge in edges)
		{
			if (edge.selected)
			{
				edge.stroke = stroke;
			}
		}
	}
	
	public function setSelectedEdgesStrokeParams(params:StrokeParams)
	{
		for (edge in edges)
		{
			if (edge.selected)
			{
				var stroke = edge.stroke.clone();
				
				if (params.thickness != null) stroke.thickness = params.thickness;
				if (params.ignoreScale != null) stroke.ignoreScale = params.ignoreScale;
				if (params.caps != null) stroke.caps = params.caps;
				if (params.joints != null) stroke.joints = params.joints;
				if (params.miterLimit != null) stroke.miterLimit = params.miterLimit;
				
				switch (stroke.getTyped())
				{
					case TypedStroke.solid(stroke):
						if (params.color != null) stroke.color = params.color;
						
					case TypedStroke.linear(stroke):
						if (params.colors != null) stroke.colors = params.colors;
						if (params.ratios != null) stroke.ratios = params.ratios;
						if (params.x0 != null) stroke.x0 = params.x0;
						if (params.y0 != null) stroke.y0 = params.y0;
						if (params.x1 != null) stroke.x1 = params.x1;
						if (params.y1 != null) stroke.y1 = params.y1;
						
					case TypedStroke.radial(stroke):
						if (params.colors != null) stroke.colors = params.colors;
						if (params.ratios != null) stroke.ratios = params.ratios;
						if (params.x0 != null) stroke.fx = params.x0;
						if (params.y0 != null) stroke.fy = params.y0;
						if (params.x1 != null) stroke.cx = params.x1;
						if (params.y1 != null) stroke.cy = params.y1;
						if (params.r != null) stroke.r = params.r;
						
					case TypedStroke.bitmap(stroke):
						if (params.bitmapPath != null) stroke.bitmapPath = params.bitmapPath;
				}
				
				edge.stroke = stroke;
			}
		}
	}
	
	public function getSelectedEdgesStrokeParams() : {>StrokeParams, type:String }
	{
		var r =
		{
			type: null,
			thickness: null,
			ignoreScale: null,
			color: null,
			colors: null,
			ratios: null,
			x0: null,
			y0: null,
			x1: null,
			y1: null,
			r: null,
			bitmapPath: null,
			caps: null,
			joints: null,
			miterLimit: null
		};
		
		for (edge in edges)
		{
			if (edge.selected)
			{
				r.thickness = r.thickness == null || r.thickness == edge.stroke.thickness ? edge.stroke.thickness : -1;
				r.ignoreScale = r.ignoreScale == null || r.ignoreScale == edge.stroke.ignoreScale ? edge.stroke.ignoreScale : false;
				r.caps = r.caps == null || r.caps == edge.stroke.caps ? edge.stroke.caps : "mixed";
				r.joints = r.joints == null || r.joints == edge.stroke.joints ? edge.stroke.joints : "mixed";
				r.miterLimit = r.miterLimit == null || r.miterLimit == edge.stroke.miterLimit ? edge.stroke.miterLimit : -1;
				
				switch (edge.stroke.getTyped())
				{
					case TypedStroke.solid(stroke):
						r.type = r.type == null || r.type == "solid" ? "solid" : "mixed";
						r.color = stroke.color;
						
					case TypedStroke.linear(stroke):
						r.type = r.type == null || r.type == "linear" ? "linear" : "mixed";
						r.colors = stroke.colors;
						r.ratios = stroke.ratios;
						r.x0 = stroke.x0;
						r.y0 = stroke.y0;
						r.x1 = stroke.x1;
						r.y1 = stroke.y1;
						
					case TypedStroke.radial(stroke):
						r.type = r.type == null || r.type == "radial" ? "radial" : "mixed";
						r.colors = stroke.colors;
						r.ratios = stroke.ratios;
						r.x0 = stroke.fx;
						r.y0 = stroke.fy;
						r.x1 = stroke.cx;
						r.y1 = stroke.cy;
						r.r = stroke.r;
						
					case TypedStroke.bitmap(stroke):
						r.type = r.type == null || r.type == "bitmap" ? "bitmap" : "mixed";
						r.bitmapPath = stroke.bitmapPath;
				}
			}
		}
		return r;
	}
	
	public function setSelectedPolygonsFill(fill:IFill, ?x1:Float, ?y1:Float, ?x2:Float, ?y2:Float)
	{
		for (polygon in polygons)
		{
			if (polygon.selected)
			{
				polygon.applyFill(fill, x1, y1, x2, y2);
			}
		}
	}
	
	public function setSelectedPolygonsFillParams(params:FillParams)
	{
		for (polygon in polygons)
		{
			if (polygon.selected)
			{
				var fill = polygon.fill.clone();
				
				switch (fill.getTyped())
				{
					case TypedFill.solid(fill):
						if (params.color != null) fill.color = params.color;
						
					case TypedFill.linear(fill):
						if (params.colors != null) fill.colors = params.colors;
						if (params.ratios != null) fill.ratios = params.ratios;
						if (params.x0 != null) fill.x0 = params.x0;
						if (params.y0 != null) fill.y0 = params.y0;
						if (params.x1 != null) fill.x1 = params.x1;
						if (params.y1 != null) fill.y1 = params.y1;
						
					case TypedFill.radial(fill):
						if (params.colors != null) fill.colors = params.colors;
						if (params.ratios != null) fill.ratios = params.ratios;
						if (params.x0 != null) fill.fx = params.x0;
						if (params.y0 != null) fill.fy = params.y0;
						if (params.x1 != null) fill.cx = params.x1;
						if (params.y1 != null) fill.cy = params.y1;
						if (params.r != null) fill.r = params.r;
						
					case TypedFill.bitmap(fill):
						if (params.bitmapPath != null) fill.bitmapPath = params.bitmapPath;
						if (params.matrix != null) fill.matrix = params.matrix;
						if (params.repeat != null) fill.repeat = params.repeat;
				}
				
				polygon.fill = fill;
			}
		}
	}
	
	public function getSelectedPolygonsFillParams() : {>FillParams, type:String }
	{
		var r =
		{
			type: null,
			color: null,
			colors: null,
			ratios: null,
			x0: null,
			y0: null,
			x1: null,
			y1: null,
			r: null,
			bitmapPath: null,
			matrix: null,
			repeat: null
		};
		
		for (polygon in polygons)
		{
			if (polygon.selected)
			{
				switch (polygon.fill.getTyped())
				{
					case TypedFill.solid(fill):
						r.type = r.type == null || r.type == "solid" ? "solid" : "mixed";
						r.color = fill.color;
						
					case TypedFill.linear(fill):
						r.type = r.type == null || r.type == "linear" ? "linear" : "mixed";
						r.colors = fill.colors;
						r.ratios = fill.ratios;
						r.x0 = fill.x0;
						r.y0 = fill.y0;
						r.x1 = fill.x1;
						r.y1 = fill.y1;
						
					case TypedFill.radial(fill):
						r.type = r.type == null || r.type == "radial" ? "radial" : "mixed";
						r.colors = fill.colors;
						r.ratios = fill.ratios;
						r.x0 = fill.fx;
						r.y0 = fill.fy;
						r.x1 = fill.cx;
						r.y1 = fill.cy;
						r.r = fill.r;
						
					case TypedFill.bitmap(fill):
						r.type = r.type == null || r.type == "bitmap" ? "bitmap" : "mixed";
						r.bitmapPath = fill.bitmapPath;
						r.matrix = fill.matrix;
						r.repeat = fill.repeat;
				}
			}
		}
		
		if (r.type == "mixed") r.type = null;
		
		return r;
	}
	
	public function floodFill(fill:IFill, x1:Float, y1:Float, x2:Float, y2:Float)
	{
		var polygon = findOrCreatePolygonByPoint((x1 + x2) / 2, (y1 + y2) / 2);
		if (polygon != null)
		{
			polygon.applyFill(fill, x1, y1, x2, y2);
		}
	}
	
	public function getBounds(?bounds:Bounds, useStrokeThickness=true) : Bounds
	{
		if (edges.length > 0 || polygons.length > 0)
		{
			if (bounds == null) bounds = { minX:1e100, minY:1e100, maxX:-1e100, maxY:-1e100 };
			
			if (useStrokeThickness) StrokeEdges.getBounds(edges, bounds);
			else                    Edges.getBounds(edges, bounds);
			
			for (polygon in polygons) polygon.getBounds(bounds);
		}
		
		return bounds;
	}
	
	public function getSelectedBounds(?bounds:Bounds, useStrokeThickness=true) : Bounds
	{
		var selectedEdges = []; for (e in edges) if (e.selected) selectedEdges.push(e);
		var selectedPolygons = []; for (p in polygons) if (p.selected) selectedPolygons.push(p);
		
		if (selectedEdges.length > 0 || selectedPolygons.length > 0)
		{
			if (bounds == null) bounds = { minX:1e100, minY:1e100, maxX: -1e100, maxY: -1e100 };
			
			if (useStrokeThickness) StrokeEdges.getBounds(selectedEdges, bounds);
			else                    Edges.getBounds(selectedEdges, bounds);
			
			for (polygon in selectedPolygons) polygon.getBounds(bounds);
		}
		
		return bounds;
	}
	
	function findOrCreatePolygonByPoint(x:Float, y:Float, ?fill:IFill) : Polygon
	{
		var polygon = Polygons.findByPoint(polygons, x, y);
		if (polygon != null) return polygon;
		
		var allEdges = getEdges();
		Debug.assert(!Edges.hasDuplicates(allEdges), allEdges.toString());
		
		var contours = Contours.fromEdges(allEdges);
		//log(() -> "contours = " + contours.length);
		
		var outers = [];
		var inners = [];
		for (contour in contours)
		{
			if (contour.isPointInside(x, y)) outers.push(contour);
			else							 inners.push(contour);
		}
		//log(() -> "outers(1) = " + outers.length);
		//log(() -> "inners(1) = " + inners.length);
		
		var i = 0; while (i < outers.length)
		{
			var j = 0; while (j < outers.length)
			{
				if (i != j && outers[i].isNestedTo(outers[j]))
				{
					outers.splice(j, 1);
					if (i > j) i--;
					j--;
				}
				j++;
			}
			i++;
		}
		//log(() -> "outers(2) = " + outers.length);
		
		if (outers.length == 0) return null;
		
		var outer = outers[0];
		
		inners = inners.filter(contour -> contour.isNestedTo(outer));
		//log(() -> "inners(2) = " + inners.length);
		
		var i = 0; while (i < inners.length)
		{
			var j = 0; while (j < inners.length)
			{
				if (i != j && inners[j].isNestedTo(inners[i]))
				{
					inners.splice(j, 1);
					if (i > j) i--;
					j--;
				}
				j++;
			}
			i++;
		}
		//log(() -> "inners(3) = " + inners.length);
		
		Debug.assert(outer.isClockwise());
		
		polygon = new Polygon(fill);
		polygon.contours.push(outer);
		for (inner in inners)
		{
			inner.reverse();
			Debug.assert(inner.isCounterClockwise());
			polygon.contours.push(inner);
		}
		
		polygons.push(polygon);
		
		return polygon;
	}
	
	override public function transform(m:Matrix, applyToStrokeAndFill=true)
	{
		if (m.isIdentity()) return;
		
		for (edge in edges)
		{
			edge.transform(m, applyToStrokeAndFill);
		}
		
		for (polygon in polygons)
		{
			polygon.transform(m, applyToStrokeAndFill);
		}
		
		normalize();
	}
	
	public function transformSelected(m:Matrix, applyToStrokeThickness=true)
	{
		for (edge in edges) if (edge.selected) edge.transform(m, applyToStrokeThickness);
		for (polygon in polygons) if (polygon.selected) polygon.transform(m);
		
		normalize();
	}
	
	#if ide
	@:profile
	public function combine(shape:ShapeElement)
	{
		normalize();
		shape.normalize();
		
		if (shape.isEmpty()) return;
		
		if (isEmpty())
		{
			edges = ArrayTools.clone(shape.edges);
			polygons = ArrayTools.clone(shape.polygons);
		}
		else
		{
			shape = cast shape.clone();
			
			final thisState = getState();
			final shapeState = shape.getState();
			
			log(() -> "combine\nthisState=\n" + thisState + "\nshapeState=\n" + shapeState);
			
			try combineInner(this, shape)
			catch (e:Dynamic)
			{
				nanofl.engine.Log.logShapeCombineError(thisState, shapeState);
				setState(thisState);
				
				#if test
				Exception.rethrow(e);
				#end
			}
		}
		
		Polygons.removeErased(polygons);
	}
	
	static function combineInner(shapeA:ShapeElement, shapeB:ShapeElement)
	{
		log(() -> "XXXXXXXXXXXXXXXX combineInner");
		log(() -> "shapeA = " + shapeA.getState());
		log(() -> "shapeB = " + shapeB.getState());
		
		shapeA.assertCorrect();
		shapeB.assertCorrect();
		
		var boundsA = shapeA.getBounds(false);
		var boundsB = shapeB.getBounds(false);
		if (!BoundsTools.isIntersect(boundsA, boundsB))
		{
			log(() -> "bounds not intersect:\n\tboundsA = " + boundsA.toString() + "\n\tboundsB = " + boundsB.toString());
			shapeA.edges = Edges.concatUnique(shapeB.edges, shapeA.edges);
			shapeA.polygons = shapeA.polygons.concat(shapeB.polygons);
			return;
		}
		
		var edgesA = shapeA.getEdges();
		var edgesB = shapeB.getEdges();
		
		Debug.assert(!Edges.hasDuplicates(edgesA));
		Debug.assert(!Edges.hasDuplicates(edgesB));
		
		log(() -> "\nBEFORE INTERSECT\nedgesA = " + edgesA + "\nedgesB = " + edgesB);
		
		#if profiler Profiler.begin("ShapeElement.combine/intersect " + edgesA.length + " + " + edgesB.length); #end
		Edges.intersect(edgesA, edgesB, (search, replacement) ->
		{
			StrokeEdges.replace(shapeA.edges, search, replacement);
			shapeB.replaceEdge(search, replacement);
		});
		#if profiler Profiler.end(); #end
		
		log(() -> "\nAFTER INTERSECT\nedgesA = " + edgesA + "\nedgesB = " + edgesB);
		
		shapeA.edges = shapeA.edges.filter(e -> !Polygons.isEdgeInside(shapeB.polygons, e));
		shapeA.edges = Edges.concatUnique(shapeB.edges, shapeA.edges);
		
		log(() -> "shapeA.polygons = " + shapeA.polygons.length);
		shapeA.polygons = Polygons.fromEdges(Edges.concatUnique(edgesA, edgesB), shapeA.edges, shapeA.polygons.concat(shapeB.polygons));
		log(() -> "RECONSTRUCT shapeA.polygons = " + shapeA.polygons.length + "; " + shapeA.polygons);
		
		shapeA.assertCorrect();
	}
	
	public function combineSelf() : Bool
	{
		normalize();
		
		var thisState = getState();
		
		try
		{
			log(() -> "\nShapeElement.intersectSelf BEGIN ===================");
			log(() -> "thisState = " + thisState.toString());
			
			var allEdges = getEdges();
			
			var changed = false;
			Edges.intersectSelf(allEdges, (search, replacement) ->
			{
				StrokeEdges.replace(edges, search, replacement);
				changed = true;
			});
			
			log("changed = " + changed);
			if (!changed) return false;
			
			log(() -> "AFTER INTERSECT");
			log(() -> "getEdges =\n" + getEdges().join("; "));
			
			polygons = Polygons.fromEdges(allEdges, edges, polygons);
			
			log(() -> "AFTER RECONSTRUCT");
			log(() -> "getEdges =\n" + getEdges().join("; "));
			
			assertCorrect();
		}
		catch (e:Dynamic)
		{
			nanofl.engine.Log.logShapeCombineError(thisState, thisState);
			setState(thisState);
			
			#if test
			Exception.rethrow(e);
			#end
		}
		
		return true;
	}
	
	public function combineSelected()
	{
		var selected = extractSelected();
		removeSelected();
		combine(selected);
	}
	
	#end
	
	public function extractSelected() : ShapeElement
	{
		return new ShapeElement
		(
			ArrayTools.clone(edges.filter(e -> e.selected)),
			ArrayTools.clone(polygons.filter(p -> p.selected))
		);
	}
	
	#if ide
	@:allow(nanofl.ide.editor.Figure)
	override function getState() : nanofl.ide.undo.states.ShapeState
	{
		return new nanofl.ide.undo.states.ShapeState(ArrayTools.clone(edges), ArrayTools.clone(polygons));
	}
	
	@:allow(nanofl.ide.editor.Figure)
	override function setState(_state:nanofl.ide.undo.states.ElementState)
	{
		final state = cast(_state, nanofl.ide.undo.states.ShapeState);
		edges = ArrayTools.clone(state.edges);
		polygons = ArrayTools.clone(state.polygons);
	}
	#end
	
	@:profile
	function assertCorrect()
	{
		#if long_asserts
		
		for (edge in edges)
		{
			Debug.assert(edge.stroke != null);
		}
		
		for (polygon in polygons)
		{
			Debug.assert(polygon.fill != null);
		}
		
		Debug.assert(!Edges.hasDegenerated(edges), "Stroke edges must not have degenerated to point.");
		Debug.assert(!Edges.hasDuplicates(edges), "Stroke edges must not have duplicates.");
		
		Edges.assertHasNoIntersections(edges);
		
		Debug.assert(!Edges.hasDegenerated(Polygons.getEdges(polygons)), "Polygon edges must not have degenerated to point.");
		
		Polygons.assertCorrect(polygons, true);
		
		#end
	}
	
	function getEdges() : Array<Edge>
	{
		var r : Array<Edge> = cast edges.copy();
		for (p in polygons) p.getEdges(r);
		Debug.assert(!Edges.hasDuplicates(r));
		return r;
	}
	
	public function replaceEdge(search:Edge, replacement:Array<Edge>)
	{
		StrokeEdges.replace(edges, search, replacement);
		Debug.assert(search.indexIn(edges) < 0, "\nsearch = " + search + "\nreplacement = " + replacement);
		
		for (p in polygons)
		{
			p.replaceEdge(search, replacement);
			Debug.assert(search.indexIn(p.getEdges()) < 0, "\nsearch = " + search + "\nreplacement = " + replacement);
		}
		
		Debug.assert(search.indexIn(getEdges()) < 0, "\nsearch = " + search + "\nreplacement = " + replacement);
	}
	
	function normalize()
	{
		Edges.normalize(edges);
		Polygons.normalize(polygons);
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String)
	{
		for (edge in edges)
		{
			edge.stroke.swapInstance(oldNamePath, newNamePath);
		}
		
		for (polygon in polygons)
		{
			polygon.fill.swapInstance(oldNamePath, newNamePath);
		}
	}
	
	public function applyStrokeAlpha(alpha:Float) : Void
	{
		if (alpha == 1) return;
		
		var processed = new Map<IStroke, Bool>();
		for (edge in edges)
		{
			if (!processed.exists(edge.stroke))
			{
				edge.stroke.applyAlpha(alpha);
				processed.set(edge.stroke, true);
			}
		}
	}
	
	public function applyFillAlpha(alpha:Float) : Void
	{
		if (alpha == 1) return;
		
		var processed = new Map<IFill, Bool>();
		for (polygon in polygons)
		{
			if (!processed.exists(polygon.fill))
			{
				polygon.fill.applyAlpha(alpha);
				processed.set(polygon.fill, true);
			}
		}
	}
	
	public function getEdgeCount() : Int
	{
		var r = edges.length;
		for (p in polygons) r += p.getEdges().length;
		return r;
	}
	
	override function setLibrary(library:Library) 
	{
		for (edge in edges) edge.stroke.setLibrary(library);
		for (polygon in polygons) polygon.fill.setLibrary(library);
	}
	
	override public function equ(element:Element) : Bool 
	{
		if (!super.equ(element)) return false;
		if (!ArrayTools.equ((cast element:ShapeElement).edges, edges)) return false;
		if (!ArrayTools.equ((cast element:ShapeElement).polygons, polygons)) return false;
		return true;
	}
	
	override function getNearestPointsLocal(pos:Point) : Array<Point>
	{
		for (polygon in polygons)
		{
			if (polygon.isPointInside(pos.x, pos.y)) return [ pos ];
		}
		
		var points = [];
		for (polygon in polygons)
		{
			points = points.concat(polygon.getEdges().map(edge -> edge.getNearestPoint(pos.x, pos.y).point));
		}
		points = points.concat(edges.map(edge -> edge.getNearestPointUseStrokeSize(pos.x, pos.y).point));
		
		return points;
	}
	
	#if (ide || test)
	override public function fixErrors() : Bool
	{
		normalize();
		
		var r = combineSelf();
		
		var newPolygons = [];
		for (polygon in polygons)
		{
			var pp = polygon.fixErrors();
			if (pp.length != 1) r = true;
			newPolygons = newPolygons.concat(pp);
		}
		polygons = newPolygons;
		
		assertCorrect();
		return r;
	}
	#end
	
	#if ide
	override public function getUsedSymbolNamePaths() : Set<String>
	{
		var r = new Set<String>();
		
		for (edge in edges)
		{
			if (Std.isOfType(edge.stroke, BitmapStroke))
			{
				r.add((cast edge.stroke:BitmapStroke).bitmapPath);
			}
		}
        
		for (polygon in polygons)
		{
			if (Std.isOfType(polygon.fill, BitmapFill))
			{
                r.add((cast polygon.fill:BitmapFill).bitmapPath);
			}
		}
		
		return r;
	}
	#end
	
	public static function createRectangle(x:Float, y:Float, width:Float, height:Float, rTopLeft:Float, rTopRight:Float, rBottomRight:Float, rBottomLeft:Float, stroke:IStroke, fill:IFill) : ShapeElement
	{
		var x1 = x;
		var y1 = y;
		var x2 = x + width;
		var y2 = y + height;
		
		var rTL = Math.abs(rTopLeft);
		var rTR = Math.abs(rTopRight);
		var rBR = Math.abs(rBottomRight);
		var rBL = Math.abs(rBottomLeft);
		
		var edges = [];
		
		var k = 0.87;
		
		if (rTopLeft > 0.0) edges.push(new Edge(x1 + rTL, y1, x1, y1, x1, y1 + rTL));
		else
		if (rTopLeft < 0.0) edges.push(new Edge(x1 + rTL, y1, x1 + rTL*k, y1 + rTL*k, x1, y1 + rTL));
		
		edges.push(new Edge(x1, y1 + rTL, x1, y2 - rBL));
		
		if (rBottomLeft > 0.0) edges.push(new Edge(x1, y2 - rBL, x1, y2, x1 + rBL, y2));
		else
		if (rBottomLeft < 0.0) edges.push(new Edge(x1, y2 - rBL, x1 + rBL*k, y2 - rBL*k, x1 + rBL, y2));
		
		edges.push(new Edge(x1 + rBL, y2, x2 - rBR, y2));
		
		if (rBottomRight > 0.0) edges.push(new Edge(x2 - rBR, y2, x2, y2, x2, y2 - rBR));
		else
		if (rBottomRight < 0.0) edges.push(new Edge(x2 - rBR, y2, x2 - rBR*k, y2 - rBR*k, x2, y2 - rBR));
		
		edges.push(new Edge(x2, y2 - rBR, x2, y1 + rTR));
		
		if (rTopRight > 0.0) edges.push(new Edge(x2, y1 + rTR, x2, y1, x2 - rTR, y1));
		else
		if (rTopRight < 0.0) edges.push(new Edge(x2, y1 + rTR, x2 - rTR*k, y1 + rTR*k, x2 - rTR, y1));
		
		edges.push(new Edge(x2 - rTR, y1, x1 + rTL, y1));
		
		return new ShapeElement
		(
			stroke != null ? edges.map(e -> StrokeEdge.fromEdge(e, stroke)) : [],
			fill != null ? [ new Polygon(fill, [ new Contour(edges) ]) ] : []
		);
	}
	
	public static function createOval(cx:Float, cy:Float, rx:Float, ry:Float, startAngle:Float, endAngle:Float, innerRadius:Float, closePath:Bool, stroke:IStroke, fill:IFill) : ShapeElement
	{
		if (endAngle == startAngle) endAngle = startAngle + 360.0;
		
		if (startAngle != 0.0 || endAngle != 360.0 || innerRadius != 0.0 || !closePath)
		{
			console.warn("Oval: processing startAngle, endAngle, innerRadius and closePath arguments are not implemented yet.");
		}
		
		var k = 1.075;
		
		var edges = [];
		
		var da = -Math.PI / 8;
		var i = 1; while (i <= 16)
		{
			edges.push(new Edge(
				cx + rx * Math.cos(da * (i + 0)),     cy + ry * Math.sin(da * (i + 0)),
				cx + rx * Math.cos(da * (i + 1)) * k, cy + ry * Math.sin(da * (i + 1)) * k,
				cx + rx * Math.cos(da * (i + 2)),     cy + ry * Math.sin(da * (i + 2))
			));
			i += 2;
		}
		
		return new ShapeElement
		(
			stroke != null ? edges.map(e -> StrokeEdge.fromEdge(e, stroke)) : [],
			fill != null ? [ new Polygon(fill, [ new Contour(edges) ]) ] : []
		);
	}
	
	override public function toString() return (parent != null ? parent.toString() + " / " : "") + "Shape";

	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}
package nanofl.engine.geom;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import datatools.ArrayTools;
import nanofl.engine.fills.IFill;
import nanofl.engine.fills.LinearFill;
import nanofl.engine.fills.RadialFill;
import nanofl.engine.fills.SelectionFill;
import nanofl.engine.fills.TypedFill;
import stdlib.Debug;
using stdlib.Lambda;
using nanofl.engine.geom.PointTools;
using htmlparser.HtmlParserTools;

@:allow(nanofl.engine.geom.Polygons)
class Polygon implements nanofl.engine.ISelectable
{
	public static var showSelection = true;
	
	public var contours(default, null) : Array<Contour>;
	public var fill : IFill;
	
	@:isVar public var selected(get, set) : Bool;
	function get_selected() return selected;
	function set_selected(v:Bool) return selected = v;
	
	public function new(?fill:IFill, ?contours:Array<Contour>, selected=false)
	{
		this.fill = fill;
		this.contours = contours != null ? contours : [];
		this.selected = selected;
	}
	
	public static function load(node:HtmlNodeElement, fills:Array<IFill>, version:String) : Polygon
	{
		Debug.assert(node.name == "polygon");
		
		var fillIndex = Std.int(node.getAttr("fillIndex", -1));
		Debug.assert(fillIndex != null);
		Debug.assert(fillIndex >= 0);
		Debug.assert(fillIndex < fills.length);
		
		var contours = [];
		for (node in node.children)
		{
			if (node.name == "contour")
			{
				contours.push(new Contour(Edges.load(node.getAttr("edges"))));
			}
		}
		
		return new Polygon(fills[fillIndex], contours);
	}

	public static function loadJson(obj:Dynamic, fills:Array<IFill>, version:String) : Polygon
	{
		var fillIndex = Std.int(obj.fillIndex ?? -1);
		Debug.assert(fillIndex != null);
		Debug.assert(fillIndex >= 0);
		Debug.assert(fillIndex < fills.length);
		
		var contours = [];
        var i = 0; while (i < obj.contours.length)
        {
            contours.push(new Contour(Edges.load(obj.contours[i++].edges)));
		}
		
		return new Polygon(fills[fillIndex], contours);
	}
	
	public function save(fills:Array<IFill>, out:XmlBuilder)
	{
		out.begin("polygon").attr("fillIndex", getFillIndex(fills));
		for (c in contours) c.save(out);
		out.end();
	}
	
	public function saveJson(fills:Array<IFill>) : Dynamic
	{
        return 
        {
            fillIndex: getFillIndex(fills),
            contours: contours.map(c -> c.saveJson()),
        };
	}
	
	public function draw(g:ShapeRender, scaleSelection:Float)
	{
		fill.begin(g);
		for (contour in contours) contour.draw(g);
		g.endFill();
		
		if (showSelection && selected)
		{
			new SelectionFill(scaleSelection).begin(g);
			for (contour in contours) contour.draw(g);
			g.endFill();
		}
	}
	
	public function translate(dx:Float, dy:Float) : Void
	{
		if (fill != null) fill = fill.getTransformed(new Matrix(1, 0, 0, 1, dx, dy));
		for (c in contours) c.translate(dx, dy);
	}
	
	public function isPointInside(px:Float, py:Float) : Bool
	{
		return contours[0].isPointInside(px, py) && contours.slice(1).foreach(x -> !x.isPointInside(px, py));
	}
	
	function getFillIndex(fills:Array<IFill>) : Int
	{
		var r = fills.findIndex(function(f) return f.equ(fill));
		if (r < 0)
		{
			r = fills.length;
			fills.push(fill);
		}
		return r;
	}
	
	public function hasPoint(px:Float, py:Float) : Bool
	{
		for (contour in contours) if (contour.hasPoint(px, py)) return true;
		return false;
	}
	
	public function hasEdge(edge:Edge) : Bool
	{
		for (c in contours) if (c.hasEdge(edge)) return true;
		return false;
	}
	
	public function isEdgeInside(edge:Edge) : Bool
	{
		Debug.assert(contours.length > 0);
		return contours[0].isEdgeInside(edge) && contours.slice(1).foreach(function(c) return !c.isEdgeInside(edge));
	}
	
	public function isEdgeAtLeastPartiallyInside(edge:Edge) : Bool
	{
		var m = edge.getMiddlePoint();
		return !hasPoint(m.x, m.y) && isPointInside(m.x, m.y)
		    || !hasPoint(edge.x1, edge.y1) && isPointInside(edge.x1, edge.y1)
		    || !hasPoint(edge.x3, edge.y3) && isPointInside(edge.x3, edge.y3);
	}
	
	public function isPolygonInside(p:Polygon) : Bool
	{
		Debug.assert(contours.length > 0);
		Debug.assert(p.contours.length > 0);
		
		for (edge in p.contours[0].edges)
		{
			if (!isEdgeInside(edge)) return false;
		}
		
		for (i in 1...contours.length)
		{
			for (edge in contours[i].edges)
			{
				if (p.isEdgeInside(edge)) return false;
			}
		}
		
		return true;
	}
	
	public function translateVertex(point:Point, dx:Float, dy:Float)
	{
		for (contour in contours)
		for (edge in contour.edges)
		{
			edge.translateVertex(point, dx, dy);
		}
	}
	
	public function getBounds(?bounds:Bounds) : Bounds
	{
		if (contours.length > 0)
		{
			if (bounds == null) bounds = { minX:1e10, minY:1e10, maxX: -1e10, maxY: -1e10 };
			for (contour in contours)
			{
				Edges.getBounds(contour.edges, bounds);
			}
			return bounds;
		}
		return bounds != null ? bounds : { minX:0.0, minY:0.0, maxX:0.0, maxY:0.0 };
	}
	
	public function applyFill(fill:IFill, ?x1:Float, ?y1:Float, ?x2:Float, ?y2:Float)
	{
		switch (fill.getTyped())
		{
			case TypedFill.solid(fill):
				this.fill = fill.clone();
				
			case TypedFill.linear(fill):
				fill = fill.clone();
				
				if (this.fill == null || Type.enumIndex(this.fill.getTyped()) != Type.enumIndex(fill.getTyped()) || x1 != null)
				{
					var len : Float;
					
					if (x1 == null || x1 == x2 && y1 == y2)
					{
						var bounds = getBounds();
						len = bounds.maxX - bounds.minX;
						x1 = bounds.minX;
						x2 = bounds.maxX;
						y1 = y2 = bounds.minY;
					}
					else
					{
						len = PointTools.getDist(x1, y1, x2, y2);
					}
					
					fill.x0 = x1;
					fill.y0 = y1;
					fill.x1 = x2;
					fill.y1 = y2;
				}
				else
				{
					var t = cast(this.fill, LinearFill);
					fill.x0 = t.x0;
					fill.y0 = t.y0;
					fill.x1 = t.x1;
					fill.y1 = t.y1;
				}
				
				this.fill = fill;
				
			case TypedFill.radial(fill):
				fill = fill.clone();
				
				if (this.fill == null || Type.enumIndex(this.fill.getTyped()) != Type.enumIndex(fill.getTyped()) || x1 != null)
				{
					var len : Float;
					
					if (x1 == null || x1 == x2 && y1 == y2)
					{
						var bounds = getBounds();
						len = Math.max(bounds.maxX - bounds.minX, bounds.maxY - bounds.minY) / 2;
						x1 = (bounds.minX + bounds.maxX) / 2;
						y1 = (bounds.minY + bounds.maxY) / 2;
					}
					else
					{
						len = PointTools.getDist(x1, y1, x2, y2);
					}
					
					fill.cx = x1;
					fill.cy = y1;
					fill.r = len;
					fill.fx = x1;
					fill.fy = y1;
				}
				else
				{
					var t = cast(this.fill, RadialFill);
					fill.cx = t.cx;
					fill.cy = t.cy;
					fill.r = t.r;
					fill.fx = t.fx;
					fill.fy = t.fy;
				}
				
				this.fill = fill;
				
			case TypedFill.bitmap(fill):
				fill = fill.clone();
				
				var len : Float;
				
				fill.repeat = x1 != null ? "repeat" : "no-repeat";
				
				var bitmapWidth = fill.getBitmapWidth();
				
				if (x1 == null || x1 == x2 && y1 == y2)
				{
					var bounds = getBounds();
					len = bounds.maxX - bounds.minX;
					x1 = bounds.minX;
					x2 = bounds.minX + bitmapWidth;
					y1 = y2 = bounds.minY;
				}
				else
				{
					len = PointTools.getDist(x1, y1, x2, y2);
				}
				
				fill.matrix = new Matrix();
				fill.matrix.scale(len / bitmapWidth, len / bitmapWidth);
				if (x1 != x2 || y1 != y2) fill.matrix.rotate(Math.atan2(y2 - y1, x2 - x1));
				fill.matrix.translate(x1, y1);
				
				this.fill = fill;
		}
	}
	
	public function transform(m:Matrix, applyToFill=true)
	{
		for (contour in contours)
		{
			for (edge in contour.edges)
			{
				edge.transform(m);
			}
		}
		if (applyToFill && fill != null) fill = fill.getTransformed(m);
	}
	
	public function getEdges(?edges:Array<Edge>) : Array<Edge>
	{
		if (edges == null) edges = [];
		for (contour in contours)
		{
			Edges.appendUnique(edges, contour.edges);
		}
		return edges;
	}
	
	public function getPointInside() : Point
	{
		var bounds = getBounds();
		
		// find pointY - best y coordinate for ray
		var yy = [ bounds.minY, bounds.maxY ];
		for (edge in getEdges()) yy.push(edge.y1);
		yy.sort(Reflect.compare);
		var maxDY = 0.0;
		var rY = yy[0];
		for (i in 1...yy.length)
		{
			if (yy[i] - yy[i - 1] > maxDY)
			{
				maxDY = yy[i] - yy[i - 1];
				rY = (yy[i] + yy[i - 1]) / 2;
			}
		}
		
		// find xx - edges intersections with a ray from (-1.0e100,pointY) to right infinity
		var xx = [];
		for (contour in contours)
		{
			for (edge in contour.edges)
			{
				for (x in edge.getIntersectionPointsX_rightRay(-1.0e100, rY))
				{
					xx.push(x);
				}
			}
			Debug.assert(xx.length % 2 == 0, "Polygon.getPointInside() error\nxx = " + xx + "\nrY = " + rY + "\nedges = " + contour.edges);
		}
		xx.sort(Reflect.compare);
		
		// find rX - best x coordinate for result point
		var maxDX = 0.0;
		var rX = xx[0];
		var i = 1; while (i < xx.length)
		{
			if (xx[i] - xx[i - 1] > maxDX)
			{
				maxDX = xx[i] - xx[i - 1];
				rX = (xx[i] + xx[i - 1]) / 2;
			}
			i += 2;
		}
		
		return { x:rX, y:rY };
	}
	
	public function clone() : Polygon
	{
		return new Polygon(fill.clone(), ArrayTools.clone(contours), selected);
	}
	
	public function replaceEdge(search:Edge, replacement:Array<Edge>) : Void
	{
		for (contour in contours)
		{
			Edges.replaceAll(contour.edges, search, replacement);
		}
	}
	
	public function export(out:XmlBuilder, fills:Array<IFill>)
	{
		var fillIndex = -1; for (i in 0...fills.length) if (fills[i].equ(fill)) { fillIndex = i; break; }
		if (fillIndex == -1) { fillIndex = fills.length; fills.push(fill); }
		
		out.begin("polygon").attr("fillIndex", fillIndex);
		for (c in contours)
		{
			out.begin("contour");
			Edges.export(c.edges, out);
			out.end();
		}
		out.end();
	}
	
	public function split() : Array<Polygon>
	{
		var outers = [];
		for (contour in contours)
		{
			if (contours.foreach(function(c) return c == contour || !contour.isNestedTo(c)))
			{
				outers.push(contour);
			}
		}
		
		if (outers.length == 1) return [ this ];
		
		var r = [];
		for (outer in outers)
		{
			var inners = contours.filter(function(c) return c != outer && c.isNestedTo(outer));
			inners.unshift(outer);
			r.push(new Polygon(fill, inners));
		}
		return r;
	}
	
	public function equ(p:Polygon) : Bool
	{
		if (p.contours.length != contours.length) return false;
		return contours.foreach(function(a) return p.contours.exists(function(b) return a.equ(b)));
	}
	
	public function normalize()
	{
		var i = 0; while (i < contours.length)
		{
			contours[i].normalize();
			if (contours[i].edges.length <= 1) contours.splice(i, 1);
			else i++;
		}
	}
	
	public function isInRectangle(x:Float, y:Float, width:Float, height:Float) : Bool
	{
		for (edge in contours[0].edges)
		{
			if (!edge.isInRectangle(x, y, width, height)) return false;
		}
		return true;
	}
	
	@:profile
	public function assertCorrect()
	{
		#if long_asserts
		
		Debug.assert(contours.length > 0, "Polygon must have at least one contour.");
		
		for (c in contours)
		{
			c.assertCorrect();
			if (c == contours[0])
			{
				Debug.assert(c.isClockwise(), "First contour must be clockwise.");
			}
			else
			{
				Debug.assert(c.isCounterClockwise(), "Second and next contours must not be clockwise (" + c.edges + ").");
			}
		}
		
		for (i in 0...contours.length)
		{
			for (j in 0...contours.length)
			{
				Debug.assert(i == j || Edges.getCommon(contours[i].edges, contours[j].edges).length == 0, "Polygon contours must not have common edges (" + i + ") and (" + j + ")\n" + contours[i] + "\n" + contours[j]);
			}
		}
		
		for (i in 1...contours.length)
		{
			for (j in 1...contours.length)
			{
				Debug.assert(i == j || !contours[i].isNestedTo(contours[j]), "Inner contours must not be nested\n" + contours[i] + "\n" + contours[j]);
			}
		}
		
		for (i in 1...contours.length)
		{
			if (!contours[i].isNestedTo(contours[0]))
			{
				Debug.assert(false, "First contour must be outer.");
			}
		}
		
		#end
	}
	
	public function isContourOutside(c:Contour) : Bool
	{
		var allEdges = getEdges();
		
		for (e in c.edges)
		{
			if (!hasPoint(e.x3, e.y3)
			 && !allEdges.exists(function(ee) return ee.y3 == e.y3)
			 && isPointInside(e.x3, e.y3))
			{
				//trace("point inside: point(" + e.x3 + ", " + e.y3 + ") in contour " + contours[0]);
				return false;
			}
		}
		return true;
	}
	
	public function fixErrors() : Array<Polygon>
	{
		var r = [];
		
		var tree = Contours.getTree(contours);
		collectPolygonsByContourTree(tree, r);
		for (p in r) p.fixContoursDirection();
		
		return r;
	}
	
	function collectPolygonsByContourTree(tree:Array<Tree<Contour>>, dest:Array<Polygon>)
	{
		for (p in tree)
		{
			dest.push(new Polygon(fill, [ p.parent ].concat(p.children.map(x -> x.parent))));
			for (c in p.children)
			{
				collectPolygonsByContourTree(c.children, dest);
			}
		}
	}
	
	function fixContoursDirection()
	{
		if (contours[0].getClockwiseProduct() < 0) contours[0].reverse();
		for (contour in contours.slice(1))
		{
			if (contour.getClockwiseProduct() > 0) contour.reverse();
		}
	}
	
	public function toString() : String
	{
		return "new Polygon(" + fill + ", " + contours + ")";
	}
}

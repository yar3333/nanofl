package nanofl.engine.geom;

import datatools.ArrayTools;
import stdlib.Debug;
using Lambda;

class Contour
{
	static var EPS = 1e-7;
	
	public var edges(default, null) : Array<Edge>;
	
	public function new(edges:Array<Edge>)
	{
		this.edges = edges;
	}
	
	public static function fromRectangle(rect:{ x:Float, y:Float, width:Float, height:Float }) : Contour
	{
		return new Contour
		([
			new Edge(rect.x, rect.y, rect.x + rect.width, rect.y),
			new Edge(rect.x + rect.width, rect.y, rect.x + rect.width, rect.y + rect.height),
			new Edge(rect.x + rect.width, rect.y + rect.height, rect.x, rect.y + rect.height),
			new Edge(rect.x, rect.y + rect.height, rect.x, rect.y)
		]);
	}
	
    #if ide
	public function save(out:htmlparser.XmlBuilder)
	{
		out.begin("contour");
		out.attr("edges", Edges.save(edges));
		out.end();
	}

	public function saveJson() : Dynamic
	{
		return
		{
            edges: Edges.save(edges)
        };
	}
    #end
	
	public function draw(g:ShapeRender)
	{
		Edges.draw(edges, g, false);
	}
	
	public function translate(dx:Float, dy:Float) : Void
	{
		for (e in edges) e.translate(dx, dy);
	}
	
	public function transform(m:Matrix) : Void
	{
		for (e in edges) e.transform(m);
	}
	
	public function isPointInside(px:Float, py:Float) : Bool
	{
		for (e in edges)
		{
			if (Math.abs(e.y3 - py) < EPS) return isPointInside(px, py + EPS * 2);
		}
		
		var counter = 0;
		
		for (edge in edges)
		{
			var c = edge.getIntersectionCount_rightRay(px, py);
			//if (c != 0) trace(edge.toString() + " // " + c);
			counter += c;
		}
		
		return counter % 2 != 0;
	}
	
	public function isPointInsideP(p:Point) return isPointInside(p.x, p.y);
	
	public function hasPoint(px:Float, py:Float) : Bool
	{
		for (edge in edges)
		{
			if (edge.x1 == px && edge.y1 == py || edge.x3 == px && edge.y3 == py) return true;
		}
		return false;
	}
	
	public function hasEdge(edge:Edge) : Bool return edge.indexIn(edges) >= 0;
	
	public function isEdgeInside(edge:Edge) : Bool
	{
		if (!hasPoint(edge.x1, edge.y1) && !isPointInside(edge.x1, edge.y1)) return false;
		if (!hasPoint(edge.x3, edge.y3) && !isPointInside(edge.x3, edge.y3)) return false;
		return isPointInsideP(edge.getMiddlePoint());
	}
	
	@:profile
	public function isNestedTo(outer:Contour) : Bool
	{
		Debug.assert(outer != this);
		Debug.assert(edges[0].x1 == edges[edges.length - 1].x3);
		Debug.assert(edges[0].y1 == edges[edges.length - 1].y3);
		
		for (edge in edges)
		{
			if (!outer.hasPoint(edge.x3, edge.y3) && !outer.isPointInside(edge.x3, edge.y3))
			{
				//trace("POINT NOT INSIDE (1) point(" + edge.x3 + "," + edge.y3 + ")\n" + outer);
				return false;
			}
		}
		
		for (edge in edges)
		{
			if (edge.indexIn(outer.edges) >= 0) return false;
			var pt = edge.getMiddlePoint();
			if (!outer.isPointInside(pt.x, pt.y))
			{
				//trace("POINT NOT INSIDE (2) point(" + pt.x + "," + pt.y + ")\n" + outer);
				return false;
			}
		}
		
		return true;
	}
	
	public function clone() : Contour
	{
		return new Contour(ArrayTools.clone(edges));
	}
	
	public function isClockwise()
	{
		return getClockwiseProduct() >= -EPS;
	}
	
	public function isCounterClockwise()
	{
		return getClockwiseProduct() <= EPS;
	}
	
	public function getClockwiseProduct() : Float
	{
		var sum = 0.0;
		
		for (edge in edges)
		{
			sum += (edge.x2 - edge.x1) * (edge.y2 + edge.y1);
			sum += (edge.x3 - edge.x2) * (edge.y3 + edge.y2);
		}
		
		return sum;
	}
	
	public function normalize()
	{
		Edges.roundPoints(edges);
		Edges.removeDegenerated(edges, true);
		
		var i = 0; while (i < edges.length)
		{
			var a = edges[i];
			var b = edges[(i + 1) % edges.length];
			
			if (a.x1 == b.x3 && a.y1 == b.y3 && (a.isStraight() && b.isStraight() || a.x2 == b.x2 && a.y2 == b.y2))
			{
				if (i + 1 < edges.length)
				{
					edges.splice(i, 2);
				}
				else
				{
					edges.splice(i, 1);
					edges.splice(0, 1);
					i--;
				}
			}
			else
			{
				i++;
			}
		}
	}
	
	public function reverse() : Contour
	{
		edges.reverse();
		for (i in 0...edges.length) edges[i] = edges[i].clone().reverse();
		return this;
	}
	
	public function indexIn(contours:Array<Contour>)
	{
		for (i in 0...contours.length)
		{
			if (contours[i].edges.length == edges.length)
			{
				if (contours[i].edges.foreach(e -> e.indexIn(edges) >= 0)) return i;
			}
		}
		return -1;
	}
	
	public function equ(c:Contour) : Bool
	{
		return Edges.equIgnoreOrder(edges, c.edges);
	}
	
	public function toString() : String
	{
		return "new Contour(" + edges + ")";
	}
	
	public function assertCorrect()
	{
		#if long_asserts
		
		Debug.assert(edges.length >= 2, "Contour must have at least two edges (" + edges + ").");
		Debug.assert(edges[0].x1 == edges[edges.length - 1].x3 && edges[0].y1 == edges[edges.length - 1].y3, "Fist contour point must be equal to last contour point (" + [ edges[0], edges[edges.length - 1] ] + ").");
		
		#end
	}
}

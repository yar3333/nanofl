import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Edge;
import nanofl.engine.ArrayTools;
import nanofl.engine.geom.PointTools;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.BezierCurve;
using Lambda;

class BaseTest extends haxe.unit.TestCase
{
	override public function setup()
	{
		#if sys
		haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos) Sys.println(v);
		#end
	}
	
	function points2contour(points:Array<Float>) : Contour
	{
		var edges = [];
		var count = Std.int(points.length / 2);
		for (i in 0...count)
		{
			edges.push(new Edge(points[i * 2], points[i * 2 + 1], points[(i + 1) % count * 2], points[(i + 1) % count * 2 + 1]));
		}
		return new Contour(edges);
	}
	
	function curve(x1, y1, x2, y2, x3, y3) return new Edge(x1, y1, x2, y2, x3, y3);
	function line(x1, y1, x2, y2) return new Edge(x1, y1, x2, y2);
	
	function isEdgesEqu(a:Array<Edge>, b:Array<Edge>)
	{
		if (a.length != b.length) return false;
		
		for (e in a)
		{
			if (!b.exists(function(ee) return 
				PointTools.getSqrDist(ee.x1, ee.y1, e.x1, e.y1) < 1
			 && PointTools.getSqrDist(ee.x2, ee.y2, e.x2, e.y2) < 1
			 && PointTools.getSqrDist(ee.x3, ee.y3, e.x3, e.y3) < 1
			)) return false;
		}
		
		return true;
	}
	
	function minimazeElements<T>(elements:Array<T>, callb:Array<T>->Bool)
	{
		trace("\n\nminimazeElements SOURCE(" + elements.length + ") = " + elements);
		
		while (true)
		{
			var changed = false;
			var i = 0; while (i < elements.length)
			{
				if (callb(elements.slice(0, i).concat(elements.slice(i + 1))))
				{
					elements.splice(i, 1);
					trace("exclude " + i + " (" + elements.length + ")");
					changed = true;
				}
				else
				{
					trace("skip " + i);
					i++;
				}
			}
			if (!changed) break;
		}
		
		trace("\n\nminimazeElements RESULT(" + elements.length + ") = " + elements);
	}
	
	function minimazeContour(contour:Contour, callb:Contour->Bool)
	{
		if (!callb(contour))
		{
			trace("ERROR: minimazeContour fail at original contour");
			return;
		}
		
		var edges = contour.edges;
		
		trace("\n\nminimazeContour SOURCE(" + contour.edges.length + ")");
		
		trace("Phase A");
		while (true)
		{
			var changed = false;
			var n = 0;
			var i = 0; while (edges.length > 3 && i < edges.length)
			{
				var j = (i + 1) % edges.length;
				var k = (i + 2) % edges.length;
			
				var prev = edges[i].clone();
				var curr = edges[j];
				var next = edges[k].clone();
				
				var pt = curr.getMiddlePoint();
				
				prev.x3 = pt.x;
				prev.y3 = pt.y;
				
				next.x1 = pt.x;
				next.y1 = pt.y;
				
				var c = contour.clone();
				c.edges[i] = prev;
				c.edges[k] = next;
				c.edges.splice(j, 1);
				
				if (callb(c))
				{
					edges[i] = prev;
					edges[k] = next;
					edges.splice(j, 1);
					trace("exclude " + n + " (" + edges.length + ")");
					changed = true;
				}
				else
				{
					trace("keep " + n);
					i++;
				}
				
				n++;
			}
			if (!changed) break;
		}
		
		trace("Phase B");
		while (true)
		{
			var changed = false;
			var n = 0;
			var i = 0; while (edges.length > 3 && i < edges.length)
			{
				var edge = edges[i];
				edges.splice(i, 1);
				
				var j = i % edges.length;
				var edge2 = edges[j];
				edges[j] = edge2.clone();
				edges[j].x1 = edge.x1;
				edges[j].y1 = edge.y1;
				
				if (callb(new Contour(edges)))
				{
					trace("exclude " + n + " (" + edges.length + ")");
					changed = true;
				}
				else
				{
					trace("keep " + n);
					edges[j] = edge2;
					edges.insert(i, edge);
					i++;
				}
				
				n++;
			}
			if (!changed) break;
		}
		
		trace("\n\nminimazeContour RESULT(" + edges.length + ") =\n" + contour);
	}
}
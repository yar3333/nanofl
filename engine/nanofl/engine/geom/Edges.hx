package nanofl.engine.geom;

import stdlib.Debug;
import nanofl.engine.strokes.IStroke;
using nanofl.engine.geom.PointTools;
using stdlib.Lambda;

#if profiler @:build(Profiler.buildMarked()) #end
class Edges
{
	static var GAP = 0.01;
	
	static var reFloat2 = ~/([-+0-9.]+),([-+0-9.]+)/;
	static var reFloat4 = ~/([-+0-9.]+),([-+0-9.]+),([-+0-9.]+),([-+0-9.]+)/;
	
	public static var showSelection = true;
	
	public static function hasDuplicates<T:Edge>(edges:Array<T>) : Bool
	{
		for (i in 0...edges.length)
		{
			for (j in i + 1...edges.length)
			{
				if (edges[i].equ(edges[j])) return true;
			}
		}
		return false;
	}
	
	public static function removeDublicates<T:Edge>(edges:Array<T>) : Void
	{
		var i = 0; while (i < edges.length)
		{
			var j = i + 1; while (j < edges.length)
			{
				if (edges[i].equ(edges[j])) edges.splice(j, 1);
				else j++;
			}
			i++;
		}
	}
	
	public static function concatUnique<T:Edge, Z:T>(edgesA:Array<T>, edgesB:Array<Z>) : Array<T>
	{
		var r = edgesA.copy();
		for (e in edgesB) if (e.indexIn(edgesA) < 0) r.push(e);
		return r;
	}
	
	public static function appendUnique<T:Edge, Z:T>(edgesA:Array<T>, edgesB:Array<Z>) : Array<T>
	{
		for (e in edgesB) if (e.indexIn(edgesA) < 0) edgesA.push(e);
		return edgesA;
	}
	
	public static function exclude(edges:Array<Edge>, exclude:Array<Edge>) : Array<Edge>
	{
		for (e in exclude)
		{
			var n = e.indexIn(edges);
			if (n >= 0)
			{
				edges.splice(n, 1);
				Debug.assert(e.indexIn(edges) < 0);
			}
		}
		return edges;
	}
	
	public static function draw<T:Edge>(edges:Array<T>, g:ShapeRender, fixLineJoinsInClosedContours:Bool)
	{
		var x = 1e100;
		var y = 1e100;
		
		var startEdge : Edge = null;
		
		for (e in edges)
		{
			if (e.x1 != x || e.y1 != y)
			{
				if (fixLineJoinsInClosedContours && startEdge != null)
				{
					if (startEdge.x1 == x && startEdge.y1 == y)
					{
						startEdge.drawTo(g);
					}
				}
				startEdge = e;
				g.moveTo(e.x1, e.y1);
			}
			
			e.drawTo(g);
			
			x = e.x3;
			y = e.y3;
		}
		
		if (fixLineJoinsInClosedContours && startEdge != null)
		{
			if (startEdge.x1 == x && startEdge.y1 == y)
			{
				startEdge.drawTo(g);
			}
		}
	}
	
	public static function getBounds<T:Edge>(edges:Array<T>, ?bounds:Bounds) : Bounds
	{
		if (edges.length > 0)
		{
			if (bounds == null) bounds = { minX:1e100, minY:1e100, maxX:-1e100, maxY:-1e100 };
			for (e in edges) e.getBounds(bounds);
			return bounds;
		}
		return bounds;
	}
	
    #if ide
	public static function export<T:Edge>(edges:Array<T>, out:htmlparser.XmlBuilder) : Void
	{
		if (edges.length == 0) return;
		
		var x : Float = null;
		var y : Float = null;
		for (e in edges)
		{
			if (e.x1 != x || e.y1 != y) out.begin("move").attr("x", e.x1).attr("y", e.y1).end();
			
			if (e.isStraight())
			{
				out.begin("line").attr("x", e.x3).attr("y", e.y3).end();
			}
			else
			{
				out.begin("curve").attr("x1", e.x2).attr("y1", e.y2).attr("x2", e.x3).attr("y2", e.y3).end();
			}
			
			x = e.x3;
			y = e.y3;
		}
	}
	
	public static function exportStroked(edges:Array<StrokeEdge>, out:htmlparser.XmlBuilder) : Void
	{
		if (edges.length == 0) return;
		
		var strokes = new Array<IStroke>();
		var edgesByFill = new Array<Array<StrokeEdge>>();
		for (e in edges)
		{
			var strokeIndex = -1; for (i in 0...strokes.length) if (strokes[i].equ(e.stroke)) { strokeIndex = i; break; }
			if (strokeIndex == -1) { strokeIndex = strokes.length; strokes.push(e.stroke); edgesByFill.push([]); }
			edgesByFill[strokeIndex].push(e);
		}
		
		for (i in 0...edgesByFill.length)
		{
			out.begin("edges").attr("strokeIndex", i);
			export(edgesByFill[i], out);
			out.end();
		}
	}
    #end
	
	public static function load(s:String) : Array<Edge>
	{
		var r = [];
		
		var x = 0.0;
		var y = 0.0;
		
		var i = 0; while (i < s.length)
		{
			var c = s.charAt(i);
			i++;
			if (c == "M")
			{
				if (!reFloat2.matchSub(s, i)) throw "Cannot parse " + s.substr(i, 20) + "'.";
				x = Std.parseFloat(reFloat2.matched(1));
				y = Std.parseFloat(reFloat2.matched(2));
				i += reFloat2.matchedPos().len;
				
			}
			else
			if (c == "L")
			{
				if (!reFloat2.matchSub(s, i)) throw "Cannot parse " + s.substr(i, 20) + "'.";
				var newX = Std.parseFloat(reFloat2.matched(1));
				var newY = Std.parseFloat(reFloat2.matched(2));
				r.push(new Edge(x, y, newX, newY));
				x = newX;
				y = newY;
				i += reFloat2.matchedPos().len;
			}
			else
			if (c == "C")
			{
				if (!reFloat4.matchSub(s, i)) throw "Cannot parse " + s.substr(i, 20) + "'.";
				var newX = Std.parseFloat(reFloat4.matched(3));
				var newY = Std.parseFloat(reFloat4.matched(4));
				r.push(new Edge(x, y, Std.parseFloat(reFloat4.matched(1)), Std.parseFloat(reFloat4.matched(2)), newX, newY));
				x = newX;
				y = newY;
				i += reFloat4.matchedPos().len;
			}
			else
			{
				throw "Unexpected command '" + c + "'.";
			}
		}
		
		return r;
	}
	
	public static function save(edges:Array<Edge>) : String
	{
		var r = new StringBuf();
		
		var x : Float = null;
		var y : Float = null;
		
		for (e in edges)
		{
			if (e.x1 != x || e.y1 != y)
			{
				r.add("M" + e.x1 + "," + e.y1);
			}
			
			if (e.isStraight())
			{
				r.add("L" + e.x3 + "," + e.y3);
			}
			else
			{
				r.add("C" + e.x2 + "," + e.y2 + "," + e.x3 + "," + e.y3);
				
			}
			
			x = e.x3;
			y = e.y3;
		}
		
		return r.toString();
	}
	
	public static function replace<T:Edge>(edges:Array<T>, search:Edge, replacement:Array<Edge>) : Int
	{
		Debug.assert(!Edges.hasDuplicates(edges), "Edges must be unique.");
		Debug.assert(edges.indexOf(null) < 0);
		Debug.assert(replacement.indexOf(null) < 0);
		
		if (replacement.length == 1 && replacement[0].equ(search)) return -1;
		
		Debug.assert(search.indexIn(replacement) < 0);
		
		var i = search.indexIn(edges);
		if (i >= 0)
		{
			for (e in replacement) Debug.assert(e.indexIn(edges) < 0, e.toString());
			
			var edge = edges[i];
			replaceAt(edges, i, replacement, edge.x1 == search.x3 && edge.y1 == search.y3);
		}
		
		Debug.assert(!Edges.hasDuplicates(edges), "Edges must be unique.");
		
		return i;
	}
	
	public static function replaceAll<T:Edge>(edges:Array<T>, search:Edge, replacement:Array<Edge>) : Void
	{
		Debug.assert(edges.indexOf(null) < 0);
		Debug.assert(replacement.indexOf(null) < 0);
		Debug.assert(search.indexIn(replacement) < 0);
		
		var i = 0; while (i < edges.length)
		{
			var edge = edges[i];
			if (edge.equ(search))
			{
				replaceAt(edges, i, replacement, search.x1 == edge.x3 && search.y1 == edge.y3);
				i += replacement.length;
			}
			else
			{
				i++;
			}
		}
		
		Debug.assert(edges.indexOf(null) < 0);
	}
	
	public static function replaceAt<T:Edge>(edges:Array<T>, n:Int, replacement:Array<Edge>, reverse:Bool) : Void
	{
		Debug.assert(n >= 0 && n < edges.length, "n = " + n + "; edges.length = " + edges.length);
		Debug.assert(edges.indexOf(null) < 0);
		Debug.assert(replacement.indexOf(null) < 0);
		
		var edge = edges[n];
		edges.splice(n, 1);
		
		replacement = replacement.map(function(e)
		{
			var r = edge.clone();
			r.x1 = e.x1;
			r.y1 = e.y1;
			r.x2 = e.x2;
			r.y2 = e.y2;
			r.x3 = e.x3;
			r.y3 = e.y3;
			return r;
		});
		
		if (reverse)
		{
			replacement.reverse();
			for (edge in replacement) edge.reverse();
		}
		
		edges.insertRange(n, cast replacement);
	}
	
	@:profile
	public static function intersect<T:Edge>(edgesA:Array<T>, edgesB:Array<T>, ?onReplace:Edge->Array<Edge>->Void)
	{
		normalize(edgesA);
		normalize(edgesB);
		
		Debug.assert(edgesA != edgesB, "Must not be the same edges array.");
		Debug.assert(edgesA.indexOf(null) < 0);
		Debug.assert(edgesB.indexOf(null) < 0);
		Debug.assert(!Edges.hasDuplicates(edgesA), "Must not have duplicated in edgesA.");
		Debug.assert(!Edges.hasDuplicates(edgesB), "Must not have duplicated in edgesB.");
		Debug.assert(!Edges.hasDegenerated(edgesA), "Must not have degenerated in edgesA.");
		Debug.assert(!Edges.hasDegenerated(edgesB), "Must not have degenerated in edgesB.");
		
		//log("intersect vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
		//log("edgesA = " + edges2str(edgesA));
		//log("edgesA = " + edgesA);
		//log("edgesB = " + edges2str(edgesB));
		//log("edgesB = " + edgesB);
		
		intersectByClosePoints(edgesA, edgesB, onReplace);
		
		Debug.assert(!Edges.hasDuplicates(edgesA), "Must not have duplicated in edgesA.");
		Debug.assert(!Edges.hasDuplicates(edgesB), "Must not have duplicated in edgesB.");
		
		#if profiler Profiler.begin("nanofl.engine.geom.Edges.intersect.LOOP " + edgesA.length + " + " + edgesB.length); #end
		
		var i = 0; while (i < edgesA.length)
		{
			var j = 0; while (j < edgesB.length)
			{
				Debug.assert(i < edgesA.length, function() return "i = " + i + "; edgesA.length = " + edgesA.length);
				Debug.assert(j < edgesB.length, function() return "j = " + j + "; edgesB.length = " + edgesB.length);
				
				var edgeA = edgesA[i];
				var edgeB = edgesB[j];
				
				var I = Edge.getIntersection(edgeA, edgeB);
				
				if (I != null)
				{
					var decI = false;
					
					if (I.a.length != 1 || !I.a[0].equ(edgeA))
					{
						if (onReplace != null) onReplace(edgeA, I.a);
						
						edgesA.splice(i, 1);
						for (e in I.a) if (e.indexIn(edgesA) < 0) edgesA.push(cast edgeA.duplicate(e));
						i--; decI = true;
						
						var n = edgeA.indexIn(edgesB);
						if (n >= 0)
						{
							edgesB.splice(n, 1);
							for (e in I.a) if (e.indexIn(edgesB) < 0) edgesB.push(cast edgeB.duplicate(e));
							if (j > n) j--;
						}
					}
					
					if (I.b.length != 1 || !I.b[0].equ(edgeB))
					{
						if (onReplace != null) onReplace(edgeB, I.b);
						
						edgesB.splice(j, 1);
						for (e in I.b) if (e.indexIn(edgesB) < 0) edgesB.push(cast edgeB.duplicate(e));
						j--;
						
						var n = edgeB.indexIn(edgesA);
						if (n >= 0)
						{
							edgesA.splice(n, 1);
							for (e in I.b) if (e.indexIn(edgesA) < 0) edgesA.push(cast edgeA.duplicate(e));
							if (i > n) { i--; decI = true; }
						}
					}
					
					if (decI) break;
				}
				else
				{
					j++;
				}
			}
			i++;
		}
		
		#if profiler Profiler.end(); #end
		
		//log("edgesA = " + edgesA.join("; "));
		//log("edgesB = " + edgesB.join("; "));
		//log("intersect ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		
		Debug.assert(edgesA != edgesB, "Must not be the same edges array.");
		Debug.assert(edgesA.indexOf(null) < 0);
		Debug.assert(edgesB.indexOf(null) < 0);
		Debug.assert(!Edges.hasDuplicates(edgesA), "Must not have duplicated in edgesA.");
		Debug.assert(!Edges.hasDuplicates(edgesB), "Must not have duplicated in edgesB.");
		Debug.assert(!Edges.hasIntersections(edgesA, edgesB), "After intersection must not be intersections (" + getFirstIntersectionString(edgesA, edgesB) + ").");
		Debug.assert(!Edges.hasDegenerated(edgesA), "Must not have degenerated in edgesA.");
		Debug.assert(!Edges.hasDegenerated(edgesB), "Must not have degenerated in edgesB.");
	}
	
	@:profile
	static function intersectByClosePoints<T:Edge>(edgesA:Array<T>, edgesB:Array<T>, ?onReplace:Edge->Array<Edge>->Void) : Void
	{
		intersectByClosePointsInner(edgesA, edgesB, onReplace);
		intersectByClosePointsInner(edgesB, edgesA, onReplace);
	}
	
	static function intersectByClosePointsInner<T:Edge>(edgesA:Array<T>, edgesB:Array<T>, ?onReplace:Edge->Array<Edge>->Void) : Void
	{
		Debug.assert(edgesA != edgesB, "Must not be the same edges array.");
		Debug.assert(edgesA.indexOf(null) < 0);
		Debug.assert(edgesB.indexOf(null) < 0);
		Debug.assert(!Edges.hasDuplicates(edgesA), "Must not have duplicated in edgesA.");
		Debug.assert(!Edges.hasDuplicates(edgesB), "Must not have duplicated in edgesB.");
		Debug.assert(!Edges.hasDegenerated(edgesA), "Must not have degenerated in edgesA.");
		Debug.assert(!Edges.hasDegenerated(edgesB), "Must not have degenerated in edgesB.");
		
		for (edgeA in edgesA)
		{
			var i = 0; while (i < edgesB.length)
			{
				var edgeB = edgesB[i];
				
				if (BoundsTools.isIntersect(edgeA.getBoundsRO(), edgeB.getBoundsRO(), GAP) && !edgeA.equ(edgeB))
				{
					var            r = edgeB.splitByClosePoint(edgeA.x1, edgeA.y1);
					if (r == null) r = edgeB.splitByClosePoint(edgeA.x3, edgeA.y3);
					
					if (r != null)
					{
						//log("split " + edgeB + " by point(" + edgeA.x1 +"," + edgeA.y1 + ") or point(" + edgeA.x3 +"," + edgeA.y3 + ")");
						if (onReplace != null) onReplace(edgeB, r);
						edgesB.splice(i, 1);
						for (e in r) if (e.indexIn(edgesB) < 0) edgesB.push(cast edgeB.duplicate(e));
						i--;
					}
				}
				
				i++;
			}
		}
		
		Debug.assert(edgesA != edgesB, "Must not be the same edges array.");
		Debug.assert(edgesA.indexOf(null) < 0);
		Debug.assert(edgesB.indexOf(null) < 0);
		Debug.assert(!Edges.hasDuplicates(edgesA), "Must not have duplicated in edgesA.");
		Debug.assert(!Edges.hasDuplicates(edgesB), "Must not have duplicated in edgesB.");
		Debug.assert(!Edges.hasDegenerated(edgesA), "Must not have degenerated in edgesA.");
		Debug.assert(!Edges.hasDegenerated(edgesB), "Must not have degenerated in edgesB.");
	}
	
	@:profile
	public static function intersectSelf<T:Edge>(edges:Array<T>, ?onReplace:Edge->Array<Edge>->Void)
	{
		intersect(edges, edges.copy(), onReplace);
	}
	
	#if debug
	
	static var edgeStrChar = "a";
	static var edgeStr = new Map<String, String>();
	
	static function edge2str<T:Edge>(edge:T) : String
	{
		var s : String;
		var s2 : String;
		
		if (edge.isStraight())
		{
			s = edge.asStraightLine().toString();
			s2 = edge.clone().reverse().asStraightLine().toString();
		}
		else
		{
			s = edge.asBezierCurve().toString();
			s2 = edge.clone().reverse().asBezierCurve().toString();
		}
		
		if (!edgeStr.exists(s) && !edgeStr.exists(s2))
		{
			edgeStr.set(s, edgeStrChar);
			
			log(edgeStrChar + " = " + s + ";");
			
			var code = edgeStrChar.charCodeAt(0);
			code++;
			edgeStrChar = String.fromCharCode(code);
		}
		return edgeStr.exists(s) ? edgeStr.get(s) : edgeStr.get(s2);
	}
	
	static function edges2str<T:Edge>(edges:Array<T>) : String
	{
		var r = "";
		for (edge in edges) r += edge2str(edge);
		return r;
	}
	
	#end

	public static function normalize<T:Edge>(edges:Array<T>) : Array<T>
	{
		roundPoints(edges);
		removeDegenerated(edges);
		removeDublicates(edges);
		return edges;
	}
	
	public static function roundPoints<T:Edge>(edges:Array<T>) : Array<T>
	{
		for (edge in edges) edge.roundPoints();
		return edges;
	}
	
	public static function removeDegenerated<T:Edge>(edges:Array<T>, removeAlsoCurvesWithStartAndEndEquals=false) : Array<T>
	{
		if (removeAlsoCurvesWithStartAndEndEquals)
		{
			var i = 0; while (i < edges.length)
			{
				var edge = edges[i];
				if (edge.x1 == edge.x3 && edge.y1 == edge.y3) edges.splice(i, 1);
				else i++;
			}
		}
		else
		{
			var i = 0; while (i < edges.length)
			{
				if (edges[i].isDegenerated()) edges.splice(i, 1);
				else i++;
			}
		}
		return edges;
	}
	
	public static function isPointInside(edges:Array<Edge>, x:Float, y:Float, fillEvenOdd:Bool) : Bool
	{
		if (fillEvenOdd)
		{
			var count = 0;
			for (edge in edges)
			{
				count += edge.getIntersectionCount_rightRay(x, y);
			}
			return count % 2 == 1;
		}
		
		var count = 0;
		for (edge in edges)
		{
			count += edge.getIntersectionDirectedCount_rightRay(x, y);
		}
		return count != 0;
	}
	
	static function hasIntersections<T:Edge>(edgesA:Array<T>, edgesB:Array<T>) : Bool
	{
		for (a in edgesA)
		{
			for (b in edgesB)
			{
				var I = Edge.getIntersection(a, b);
				if (I != null) return true;
			}
		}
		return false;
	}
	
	static function getFirstIntersectionString<T:Edge>(edgesA:Array<T>, edgesB:Array<T>) : String
	{
		for (a in edgesA)
		{
			for (b in edgesB)
			{
				var I = Edge.getIntersection(a, b);
				if (I != null) return a.toString() + ", " + b.toString();
			}
		}
		return "";
	}
	
	public static function isSequence<T:Edge>(edges:Array<T>) : Bool
	{
		for (i in 1...edges.length)
		{
			if (edges[i - 1].x3 != edges[i].x1) return false;
			if (edges[i - 1].y3 != edges[i].y1) return false;
		}
		return true;
	}
	
	public static function hasDegenerated<T:Edge>(edges:Array<T>) : Bool
	{
		for (e in edges) if (e.isDegenerated()) return true;
		return false;
	}
	
	public static function getPointUseCount<T:Edge>(edges:Array<T>, x:Float, y:Float) : Int
	{
		var r = 0;
		for (e in edges)
		{
			if (e.x1 == x && e.y1 == y) r++;
			if (e.x3 == x && e.y3 == y) r++;
		}
		return r;
	}
	
	public static function equIgnoreOrder(edgesA:Array<Edge>, edgesB:Array<Edge>) : Bool
	{
		if (edgesA.length != edgesB.length) return false;
		for (edgeA in edgesA)
		{
			if (edgeA.indexIn(edgesB) < 0) return false;
		}
		return true;
	}
	
	public static function getCommon(edgesA:Array<Edge>, edgesB:Array<Edge>) : Array<Edge>
	{
		var r = [];
		for (edge in edgesA)
		{
			if (edge.indexIn(edgesB) >= 0) r.push(edge);
		}
		return r;
	}
	
	public static function getDifferent(edgesA:Array<Edge>, edgesB:Array<Edge>) : Array<Edge>
	{
		var r = [];
		for (edge in edgesA)
		{
			if (edge.indexIn(edgesB) < 0) r.push(edge);
		}
		for (edge in edgesB)
		{
			if (edge.indexIn(edgesA) < 0) r.push(edge);
		}
		return r;
	}
	
	public static function getNearestVertex(edges:Array<Edge>, x:Float, y:Float) : Point
	{
		var r = { x:-1e10, y:-1e10 };
		
		for (e in edges)
		{
			if (PointTools.getSqrDist(r.x, r.y, x, y) > PointTools.getSqrDist(e.x1, e.y1, x, y))
			{
				r.x = e.x1;
				r.y = e.y1;
			}
			if (PointTools.getSqrDist(r.x, r.y, x, y) > PointTools.getSqrDist(e.x3, e.y3, x, y))
			{
				r.x = e.x3;
				r.y = e.y3;
			}
		}
		
		return r;
	}
	
	public static function getTailPoints(edges:Array<Edge>) : Array<Point>
	{
		var r = new Array<Point>();
		for (e in edges)
		{
			if (Edges.getPointUseCount(edges, e.x1, e.y1) == 1 && !r.exists(function(p) return p.x == e.x1 && p.y == e.y1))
			{
				r.push({ x:e.x1, y:e.y1 });
			}
			
			if (Edges.getPointUseCount(edges, e.x3, e.y3) == 1 && !r.exists(function(p) return p.x == e.x3 && p.y == e.y3))
			{
				r.push({ x:e.x3, y:e.y3 });
			}
		}
		return r;
	}
	
	@:profile
	public static function smoothStraightLineSequence<T:Edge>(edges:Array<T>, power:Float)
	{
		var i = 0; while (i < edges.length)
		{
			var a : T = edges[i];
			var b : T  = edges[(i + 1) % edges.length];
			
			if (a.x3 == b.x1 && a.y3 == b.y1)
			{
				var cc : Array<T> = cast a.split([ 1 - power / 2 ]);
				var dd : Array<T> = cast b.split([ 0 + power / 2 ]);
				edges[i] = cc[0];
				edges[i+1] = dd[1];
				
				cc[1].x2 = a.x3;
				cc[1].y2 = a.y3;
				cc[1].x3 = dd[0].x3;
				cc[1].y3 = dd[0].y3;
				edges.insert(i + 1, cc[1]);
				
				i++;
			}
			
			i++;
		}
	}
	
	public static function assertHasNoIntersections<T:Edge>(edges:Array<T>)
	{
		for (i in 0...edges.length)
		{
			for (j in i + 1...edges.length)
			{
				var hasCV = edges[i].hasCommonVertices(edges[j]);
				var I = Edge.getIntersection(edges[i], edges[j]);
				
				Debug.assert
				(
					hasCV || I == null || I.a.length == 1 || I.b.length == 1,
					"hasCV = " + hasCV + "\n"
					+ "I = " + (I != null) + "\n"
					+ "edges[" + i + "] = " + edges[i] + "\n"
					+ "edges[" + j + "] = " + edges[j]
				);
			}
		}
	}
	
	public static function simplificate<T:Edge>(sequence:Array<T>, eps:Float) : Array<T>
	{
		if (sequence.length < 2) return sequence.copy();
		
		var eps2 = eps * eps;
		
		var r = new Array<T>();
		r.push(sequence[0]);
		for (i in 1...sequence.length)
		{
			var edgeA = r[r.length - 1];
			var edgeB = sequence[i];
			
			var equal = true;
			var edgeC = getAppoximated(edgeA, edgeB);
			for (i in 0...7)
			{
				var pt0 = edgeC.getPoint(i / 6);
				var d1 = pt0.getSqrDistP(edgeA.getNearestPoint(pt0.x, pt0.y).point);
				var d2 = pt0.getSqrDistP(edgeB.getNearestPoint(pt0.x, pt0.y).point);
				if (d1 > eps2 && d2 > eps2)
				{
					equal = false;
					break;
				}
			}
			
			if (equal)
			{
				r[r.length - 1] = edgeC;
			}
			else
			{
				r.push(edgeB);
			}
		}
		return r;
	}
	
	static function getAppoximated<T:Edge>(edgeA:T, edgeB:T) : T
	{
		Debug.assert(edgeA.x3 == edgeB.x1 && edgeA.y3 == edgeB.y1);
		
		var lineA = new StraightLine(edgeA.x1, edgeA.y1, edgeA.x2, edgeA.y2);
		var lineB = new StraightLine(edgeB.x3, edgeB.y3, edgeB.x2, edgeB.y2);
		
		var I = lineA.getIntersection_infinityLine(lineB);
		
		var r : T = cast edgeA.clone();
		r.x3 = edgeB.x3;
		r.y3 = edgeB.y3;
		r.x2 = I == null ? (r.x1 + r.x3) / 2 : I.x;
		r.y2 = I == null ? (r.y1 + r.y3) / 2 : I.y;
		return r;
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(v, infos);
	}
}
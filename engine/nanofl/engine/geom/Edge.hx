package nanofl.engine.geom;

import stdlib.Debug;
using nanofl.engine.geom.PointTools;
using nanofl.engine.geom.BoundsTools;

typedef EdgesItersection =
{
	var a : Array<Edge>;
	var b : Array<Edge>;
}

#if profiler @:build(Profiler.buildMarked()) #end
class Edge
{
	static var GAP = 0.01;
	
	public var x1 : Float;
	public var y1 : Float;
	public var x2 : Float;
	public var y2 : Float;
	public var x3 : Float;
	public var y3 : Float;
	
	var cachedBounds : Bounds;
	var cachedBoundsEdge : Edge;
	
	public function new(x1:Float, y1:Float, x2:Float, y2:Float, ?x3:Float, ?y3:Float)
	{
		Debug.assert(!Math.isNaN(x1));
		Debug.assert(!Math.isNaN(y1));
		Debug.assert(!Math.isNaN(x2));
		Debug.assert(!Math.isNaN(y2));
		
		this.x1 = x1;
		this.y1 = y1;
		
		if (x3 == null)
		{
			this.x2 = (x1 + x2) / 2;
			this.y2 = (y1 + y2) / 2;
			this.x3 = x2;
			this.y3 = y2;
		}
		else
		{
			this.x2 = x2;
			this.y2 = y2;
			this.x3 = x3;
			this.y3 = y3;
		}
	}
	
	public static function fromStraightLine(line:StraightLine) : Edge
	{
		return new Edge(line.x1, line.y1, line.x2, line.y2);
	}
	
	public static function fromBezierCurve(curve:BezierCurve) : Edge
	{
		return new Edge(curve.p1.x, curve.p1.y, curve.p2.x, curve.p2.y, curve.p3.x, curve.p3.y);
	}
	
	public function isStraight()
	{
		var pt = asStraightLine().getOrthogonalRayIntersection(x2, y2).point;
		return PointTools.getSqrDist(pt.x, pt.y, x2, y2) < GAP * GAP;
	}
	
	public function getIntersectionCount_rightRay(x:Float, y:Float) : Int
	{
		return isStraight()
			? (asStraightLine().isIntersect_rightRay(x, y) ? 1 : 0)
			: asBezierCurve().getIntersectionCount_rightRay(x, y);
	}
	
	public function getIntersectionDirectedCount_rightRay(x:Float, y:Float) : Int
	{
		if (isStraight())
		{
			if (y1 == y3 || asStraightLine().getIntersectionPointX_rightRay(x, y) == null) return 0;
			return y1 < y3 ? 1 : -1;
		}
		else
		{
			var count = asBezierCurve().getIntersectionCount_rightRay(x, y);
			if (count == 0 || count == 2) return 0;
			if (y1 < y && y3 > y) return  1;
			if (y1 > y && y3 < y) return -1;
			return y1 < y && y3 < y ? -1 : 1;
		}
	}
	
	public function getIntersectionPointsX_rightRay(x:Float, y:Float) : Array<Float>
	{
		if (isStraight())
		{
			var rX = asStraightLine().getIntersectionPointX_rightRay(x, y);
			return rX != null ? [rX] : [];
		}
		else
		{
			return asBezierCurve().getIntersectionPointsX_rightRay(x, y);
		}
	}
	
	public function drawTo(g:ShapeRender)
	{
		if (isStraight()) g.lineTo(x3, y3);
		else              g.curveTo(x2, y2, x3, y3);
	}
	
	public function equ(e:Edge) : Bool
	{
		return e.x2 == x2 && e.y2 == y2 && (
			e.x1 == x1 && e.y1 == y1 && e.x3 == x3 && e.y3 == y3 ||
			e.x1 == x3 && e.y1 == y3 && e.x3 == x1 && e.y3 == y1
		);
	}
	
	public function equDirected(e:Edge) : Bool
	{
		return e.x2 == x2 && e.y2 == y2
		    && e.x1 == x1 && e.y1 == y1
			&& e.x3 == x3 && e.y3 == y3;
	}
	
	public function getNearestPoint(x:Float, y:Float) : { point:Point, t:Float }
	{
		var r = isStraight()
			? asStraightLine().getNearestPoint(x, y)
			: asBezierCurve().getNearestPoint(x, y);
		
		Debug.assert(r.point != null, toString() + "; x = " + x + ", y = " + y);
		Debug.assert(!Math.isNaN(r.point.x), toString() + "; x = " + x + ", y = " + y);
		Debug.assert(!Math.isNaN(r.point.y), toString() + "; x = " + x + ", y = " + y);
		Debug.assert(!Math.isNaN(r.t), toString() + "; x = " + x + ", y = " + y);
		
		return r;
	}
	
	public function translate(dx:Float, dy:Float)
	{
		x1 += dx;
		y1 += dy;
		x2 += dx;
		y2 += dy;
		x3 += dx;
		y3 += dy;
	}
	
	public function translateVertex(point:Point, dx:Float, dy:Float)
	{
		if (x1 == point.x && y1 == point.y)
		{
			translateStart(dx, dy);
		}
		else
		if (x3 == point.x && y3 == point.y)
		{
			translateEnd(dx, dy);
		}
	}
	
	public function translateStart(dx:Float, dy:Float)
	{
		if (isStraight())
		{
			x1 += dx;
			y1 += dy;
			x2 = (x1 + x3) / 2;
			y2 = (y1 + y3) / 2;
		}
		else
		{
			var a1 = Math.atan2(y1 - y3, x1 - x3);
			var l1 = asStraightLine().getLength();
			x1 += dx;
			y1 += dy;
			var a2 = Math.atan2(y1 - y3, x1 - x3);
			var l2 = asStraightLine().getLength();
			
			var p2 = PointTools.rotate(x2 - x3, y2 - y3, a2 - a1);
			x2 = p2.x + x3;
			y2 = p2.y + y3;
		}
	}
	
	public function translateEnd(dx:Float, dy:Float)
	{
		if (isStraight())
		{
			x3 += dx;
			y3 += dy;
			x2 = (x1 + x3) / 2;
			y2 = (y1 + y3) / 2;
		}
		else
		{
			var a1 = Math.atan2(y3 - y1, x3 - x1);
			var l1 = asStraightLine().getLength();
			x3 += dx;
			y3 += dy;
			var a2 = Math.atan2(y3 - y1, x3 - x1);
			var l2 = asStraightLine().getLength();
			
			var p2 = PointTools.rotate(x2 - x1, y2 - y1, a2 - a1);
			x2 = p2.x + x1;
			y2 = p2.y + y1;
		}
	}
	
	public function reverse() : Edge
	{
		var z = x1;
		x1 = x3;
		x3 = z;
		z = y1;
		y1 = y3;
		y3 = z;
		return this;
	}
	
	public function getBounds(?bounds:Bounds) : Bounds
	{
		return bounds == null
			? getBoundsRO().clone()
			: bounds.extend(getBoundsRO());
	}
	
	public function getBoundsRO() : Bounds
	{
		if (cachedBounds == null || !cachedBoundsEdge.equ(this))
		{
			cachedBounds = isStraight()
				? asStraightLine().getBounds()
				: asBezierCurve().getBounds();
			cachedBoundsEdge = clone();
		}
		return cachedBounds;
	}
	
	public function toString()
	{
		//return 'new Edge($x1,$y1, $x2,$y2, $x3,$y3)';
		return isStraight() ? 'new Edge($x1,$y1, $x3,$y3)' : 'new Edge($x1,$y1, $x2,$y2, $x3,$y3)';
	}
	
	public function getMiddlePoint() : Point
	{
		return isStraight() ? { x:x2, y:y2 } : asBezierCurve().getPoint(0.5);
	}
	
	public function hasCommonVertices(edge:Edge) : Bool
	{
		return x1 == edge.x1 && y1 == edge.y1 || x1 == edge.x3 && y1 == edge.y3
			|| x3 == edge.x1 && y3 == edge.y1 || x3 == edge.x3 && y3 == edge.y3;
	}
	
	public function transform(m:Matrix, applyToStroke=true)
	{
		var straight = isStraight();
		
		var p1 = m.transformPoint(x1, y1);
		x1 = PointTools.roundGap(p1.x);
		y1 = PointTools.roundGap(p1.y);
		
		var p3 = m.transformPoint(x3, y3);
		x3 = PointTools.roundGap(p3.x);
		y3 = PointTools.roundGap(p3.y);
		
		if (straight)
		{
			x2 = (x1 + x3) / 2;
			y2 = (y1 + y3) / 2;
		}
		else
		{
			var p2 = m.transformPoint(x2, y2);
			x2 = PointTools.roundGap(p2.x);
			y2 = PointTools.roundGap(p2.y);
		}
	}
	
	public static function getIntersection(edgeA:Edge, edgeB:Edge) : EdgesItersection
	{
		if (!BoundsTools.isIntersect(edgeA.getBoundsRO(), edgeB.getBoundsRO(), GAP)) return null;
		if (edgeA.equ(edgeB)) return null;
		
		var I = getIntersectionInner(edgeA, edgeB);
		
		if (I != null)
		{
			Edges.normalize(I.a);
			Edges.normalize(I.b);
			if (I.a.length == 1 && I.b.length == 1 && I.a[0].equ(edgeA) && I.b[0].equ(edgeB)) I = null;
			//log("Intersect:\n" + edgeA + ";\n" + edgeB + ";");
		}
		
		return I;
	}
	
	static function getIntersectionInner(edgeA:Edge, edgeB:Edge) : EdgesItersection
	{
		log("Edge.getIntersection " + edgeA + " AND " + edgeB);
		
		var straightA = edgeA.isStraight();
		var straightB = edgeB.isStraight();
		
		if (straightA && straightB)
		{
			log("straightA && straightB");
			var p = edgeA.asStraightLine().getIntersection_straightSection(edgeB.asStraightLine());
			if (p == null) return null;
			return
			{
				a: [ new Edge(edgeA.x1, edgeA.y1, p.x, p.y), new Edge(p.x, p.y, edgeA.x3, edgeA.y3) ],
				b: [ new Edge(edgeB.x1, edgeB.y1, p.x, p.y), new Edge(p.x, p.y, edgeB.x3, edgeB.y3) ]
			};
		}
		else
		if (straightA && !straightB)
		{
			log("straightA && !straightB");
			var p = edgeB.asBezierCurve().getIntersection_straightSection(edgeA.asStraightLine());
			log("p = " + (p != null));
			if (p == null) return null;
			return
			{
				a: p.lines.map(fromStraightLine),
				b: p.curves.map(fromBezierCurve)
			};
		}
		else
		if (!straightA && straightB)
		{
			log("!straightA && straightB");
			var p = edgeA.asBezierCurve().getIntersection_straightSection(edgeB.asStraightLine());
			log("p = " + (p != null));
			if (p == null) return null;
			return
			{
				a: p.curves.map(fromBezierCurve),
				b: p.lines.map(fromStraightLine)
			};
		}
		else
		{
			log("!straightA && !straightB");
			var p = edgeA.asBezierCurve().getIntersection_bezierCurve(edgeB.asBezierCurve());
			if (p == null) return null;
			return
			{
				a: p.a.map(fromBezierCurve),
				b: p.b.map(fromBezierCurve)
			};
		}
		
		return null;
	}
	
	public function splitByClosePoint(x:Float, y:Float) : Array<Edge>
	{
		if (x1 == x && y1 == y) return null;
		if (x3 == x && y3 == y) return null;
		
		if (!getBoundsRO().isPointInside(x, y, GAP)) return null;
		
		var np = getNearestPoint(x, y);
		var pt = PointTools.roundGapP(np.point);
		if (pt.x == x && pt.y == y && (pt.x != x1 || pt.y != y1) && (pt.x != x3 || pt.y != y3))
		{
			Debug.assert(np.t > 0 && np.t < 1, () ->
				"edge = " + toString()
				+"\n\t(x,y) = (" + x + "," + y + ")"
				+ "\n\tnp = " + np.point.toString()
				+ "\n\tpt = " + pt.toString()
				+ "\n\tt = " + np.t
			);
			
			var r = split([np.t]);
			r[0].x3 = r[1].x1 = x;
			r[0].y3 = r[1].y1 = y;
			
			Edges.normalize(r);
			Debug.assert(r.length > 1, () ->
				"edge = " + toString()
				+"\n\t(x,y) = (" + x + "," + y + ")"
				+ "\n\tnp = " + np.point.toString()
				+ "\n\tpt = " + pt.toString()
				+ "\n\tt = " + np.t
				+ "\n\tr = " + r
			);
			return r;
		}
		
		return null;
	}
	
	public function asStraightLine() : StraightLine return new StraightLine(x1, y1, x3, y3);
	
	public function asBezierCurve() : BezierCurve return new BezierCurve(x1, y1, x2, y2, x3, y3);
	
	public function clone() return new Edge(x1, y1, x2, y2, x3, y3);
	
	public function duplicate(e:Edge) return new Edge(e.x1, e.y1, e.x2, e.y2, e.x3, e.y3);
	
	public function indexIn<T:Edge>(edges:Array<T>) : Int
	{
		for (i in 0...edges.length)
		{
			if (equ(edges[i])) return i;
		}
		return -1;
	}
	
	public function isDegenerated()
	{
		return x1 == x2 && x2 == x3 && y1 == y2 && y2 == y3;
	}
	
	public function roundPoints()
	{
		var straight = isStraight();
		
		x1 = PointTools.roundGap(x1);
		y1 = PointTools.roundGap(y1);
		x3 = PointTools.roundGap(x3);
		y3 = PointTools.roundGap(y3);
		
		if (straight)
		{
			x2 = (x1 + x3) / 2;
			y2 = (y1 + y3) / 2;
		}
		else
		{
			x2 = PointTools.roundGap(x2);
			y2 = PointTools.roundGap(y2);
			
			if (isStraight())
			{
				x2 = (x1 + x3) / 2;
				y2 = (y1 + y3) / 2;
			}
		}
	}
	
	public function getLength() : Float
	{
		return isStraight()
			? asStraightLine().getLength()
			: asBezierCurve().getLength();
	}
	
	public function getPart(t:Float) : Edge
	{
		return isStraight()
			? fromStraightLine(asStraightLine().getFirstPart(t))
			: fromBezierCurve(asBezierCurve().getFirstPart(t));
	}
	
	public function getPoint(t:Float) : Point
	{
		return isStraight()
			? asStraightLine().getPoint(t)
			: asBezierCurve().getPoint(t);
	}
	
	public function getTangent(t:Float) : Float
	{
		return isStraight()
			? asStraightLine().getTangent(t)
			: asBezierCurve().getTangent(t);
	}
	
	public function split(tt:Array<Float>) : Array<Edge>
	{
		return isStraight()
			? asStraightLine().split(tt).map(fromStraightLine)
			: asBezierCurve().split(tt).map(fromBezierCurve);
	}
	
	public function isInRectangle(x:Float, y:Float, width:Float, height:Float)
	{
		if (x1 >= x && y1 >= y && x1 <= x + width && y1 <= y + height
		 && x3 >= x && y3 >= y && x3 <= x + width && y3 <= y + height)
		{
			if (isStraight()) return true;
			if (x2 >= x && y2 >= y && x2 <= x + width && y2 <= y + height) return true;
			var curve = asBezierCurve();
			if (curve.getIntersection_straightSection(new StraightLine(x, y, x + width, y)) != null) return false;
			if (curve.getIntersection_straightSection(new StraightLine(x, y, x, y + height)) != null) return false;
			if (curve.getIntersection_straightSection(new StraightLine(x, y + height, x + width, y + height)) != null) return false;
			if (curve.getIntersection_straightSection(new StraightLine(x + width, y, x + width, y + height)) != null) return false;
			return true;
		}
		return false;
	}
	
	public function getMonotoneT(k:Float) : Float
	{
		return isStraight()
			? k
			: asBezierCurve().getMonotoneT(k);
	}

    public static function loadFromJson(obj:Dynamic) : Edge
    {
        return new Edge(obj.x1, obj.y1, obj.x2, obj.y2, obj.x3, obj.y3);
    }
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}

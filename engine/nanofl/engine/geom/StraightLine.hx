package nanofl.engine.geom;

using nanofl.engine.geom.PointTools;

class StraightLine
{
	static inline var EPS = 1e-10;
	
	public var x1 : Float;
	public var y1 : Float;
	public var x2 : Float;
	public var y2 : Float;
	
	public function new(x1:Float, y1:Float, x2:Float, y2:Float)
	{
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
	}
	
	public function clone() : StraightLine return new StraightLine(x1, y1, x2, y2);
	
	public function getBounds() : Bounds
	{
		return
		{
			minX: Math.min(x1, x2),
			maxX: Math.max(x1, x2),
			minY: Math.min(y1, y2),
			maxY: Math.max(y1, y2)
		};
	}
	
	public function getNearestPoint(x:Float, y:Float) : { t:Float, point:Point }
	{
		var dx = x2 - x1;
		var dy = y2 - y1;
		if (dx == 0 && dy == 0) return { t:0, point: { x:x1, y:y1 }};
		var t = Math.min(1, Math.max(0, ((x - x1) * dx + (y - y1) * dy) / (dx * dx + dy * dy)));
		if (t == 1) return { t:1, point:{ x:x2, y:y2 } };
		return { t:t, point:{ x:x1 + t * dx, y:y1 + t * dy } };
	}
	
	public function getOrthogonalRayIntersection(x:Float, y:Float) : { t:Float, point:Point }
	{
		var dx = x2 - x1;
		var dy = y2 - y1;
		if (dx == 0 && dy == 0) return { t:0, point: { x:x1, y:y1 }};
		var t = ((x - x1) * dx + (y - y1) * dy) / (dx * dx + dy * dy);
		if (t == 1) return { t:1, point:{ x:x2, y:y2 } };
		return { t:t, point:{ x:x1 + t * dx, y:y1 + t * dy } };
	}
	
	public function getOrthogonalVector() : Point
	{
		return { x:y1 - y2, y:x2 - x1 };
	}
	
	public function getLength() return PointTools.getDist(x1, y1, x2, y2);
	
	public function getIntersectionPointX_rightRay(mx:Float, my:Float) : Float
	{
		if (Math.max(y1, y2) >= my && Math.min(y1, y2) <= my)
		{
			var t = (my - y1) / (y2 - y1);
			if (y1 <= y2 && t >= 0 && t < 1 || y1 > y2 && t > 0 && t <= 1)
			{
				var x = x1 + (x2 - x1) * t;
				if (x > mx)
				{
					return x;
				}
			}
		}
		
		return null;
	}
	
	public function isIntersect_rightRay(mx:Float, my:Float) : Bool
	{
		return getIntersectionPointX_rightRay(mx, my) != null;
	}
	
	public function getIntersection_straightSection(line:StraightLine) : Point
	{
		if (x1 == line.x1 && y1 == line.y1 || x1 == line.x2 && y1 == line.y2) return null;
		if (x2 == line.x1 && y2 == line.y1 || x2 == line.x2 && y2 == line.y2) return null;
		
		var dax = x1 - x2;
		var dbx = line.x1 - line.x2;
		var day = y1 - y2;
		var dby = line.y1 - line.y2;
		
		var den = dax * dby - day * dbx;
		if (Math.abs(den) < EPS) return null;
		
		var A = x1 * y2 - y1 * x2;
		var B = line.x1 * line.y2 - line.y1 * line.x2;
		
		var I =
		{
			x: (A * dbx - dax * B) / den,
			y: (A * dby - day * B) / den
		};
		
		if (inRect(I) && line.inRect(I)) return I;
		
		return null;
	}
	
	public function getIntersection_infinityLine(line:StraightLine) : Point
	{
		var dax = x1 - x2;
		var dbx = line.x1 - line.x2;
		var day = y1 - y2;
		var dby = line.y1 - line.y2;
		
		var den = dax * dby - day * dbx;
		if (Math.abs(den) < EPS) return null;
		
		var A = x1 * y2 - y1 * x2;
		var B = line.x1 * line.y2 - line.y1 * line.x2;
		
		return
		{
			x: (A * dbx - dax * B) / den,
			y: (A * dby - day * B) / den
		};
	}
	
	function inRect(p:Point) : Bool
	{
		if (x1 == x2) return p.y >= Math.min(y1, y2) && p.y <= Math.max(y1, y2);
		if (y1 == y2) return p.x >= Math.min(x1, x2) && p.x <= Math.max(x1, x2);
		return p.x >= Math.min(x1, x2) && p.x <= Math.max(x1, x2)
			&& p.y >= Math.min(y1, y2) && p.y <= Math.max(y1, y2);
	}
	
	public function isDegenerated() : Bool
	{
		return x1 == x2 && y1 == y2;
	}
	
	public function getFirstPart(t:Float) : StraightLine
	{
		return new StraightLine(x1, y1, x1 + (x2 - x1) * t, y1 + (y2 - y1) * t);
	}
	
	public function getSecondPart(t:Float) : StraightLine
	{
		return new StraightLine(x1 + (x2 - x1) * t, y1 + (y2 - y1) * t, x2, y2);
	}
	
	public function split(tt:Array<Float>) : Array<StraightLine>
	{
		for (t in tt) stdlib.Debug.assert(!Math.isNaN(t), "t = " + t);
		
		if (tt.length == 0) return [ clone() ];
		
		if (tt.length == 1)
		{
			var m = getPoint(tt[0]);
			return [ new StraightLine(x1, y1, m.x, m.y), new StraightLine(m.x, m.y, x2, y2) ];
		}
		
		var r = [];
		var p = { x:x1, y:y1 };
		for (t in tt)
		{
			var m = getPoint(t);
			r.push(new StraightLine(p.x, p.y, m.x, m.y));
			p = m;
		}
		r.push(new StraightLine(p.x, p.y, x2, y2));
		return r;
	}
	
	public function getPoint(t:Float) : Point
	{
		return { x:x1 + (x2 - x1) * t, y:y1 + (y2 - y1) * t };
	}
	
	public function getTangent(t:Float) : Float
	{
		return Math.atan2(y2 - y1, x2 - x1);
	}
	
	public function toString() return 'line($x1, $y1, $x2, $y2)';
}

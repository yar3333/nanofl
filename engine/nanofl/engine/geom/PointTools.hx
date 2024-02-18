package nanofl.engine.geom;

class PointTools
{
	public static function half(pt:Point) : Point
	{
		var ix = Std.int(pt.x);
		pt.x = ix + (ix > pt.x ? -0.5 : 0.5);
		var iy = Std.int(pt.y);
		pt.y = iy + (iy > pt.y ? -0.5 : 0.5);
		return pt;
	}
	
	public static function round(pt:Point) : Point
	{
		pt.x = Math.round(pt.x);
		pt.y = Math.round(pt.y);
		return pt;
	}
	
	public static function normalize(pt:Point) : Point
	{
		var len = getLength(pt);
		if (len != 0)
		{
			pt.x /= len;
			pt.y /= len;
		}
		return pt;
	}
	
	public static function getLength(pt:Point) : Float
	{
		return Math.sqrt(pt.x * pt.x + pt.y * pt.y);
	}
	
	@:noUsing
	public static function getDist(x1:Float, y1:Float, x2:Float, y2:Float) : Float
	{
		var dx = x2 - x1;
		var dy = y2 - y1;
		return Math.sqrt(dx * dx + dy * dy);
	}
	
	@:noUsing
	public static function getSqrDist(x1:Float, y1:Float, x2:Float, y2:Float) : Float
	{
		var dx = x2 - x1;
		var dy = y2 - y1;
		return dx * dx + dy * dy;
	}
	
	public static inline function getDistP(a:Point, b:Point) return getDist(a.x, a.y, b.x, b.y);
	
	public static inline function getSqrDistP(a:Point, b:Point) return getSqrDist(a.x, a.y, b.x, b.y);
	
	@:noUsing
	public static function rotate(x:Float, y:Float, da:Float) : Point
	{
		return
		{
			x:x * Math.cos(da) - y * Math.sin(da),
			y:y * Math.cos(da) + x * Math.sin(da)
		};
	}
	
	public static function getRotated(pt:Point, da:Float) : Point return rotate(pt.x, pt.y, da);
	
	public static function moveInDirection(start:Point, endX:Float, endY:Float, len:Float) : Point
	{
		var v = { x:endX - start.x, y:endY - start.y };
		var l = getLength(v);
		normalize(v);
		
		var k = Math.min(len, l);
		start.x = v.x * k + start.x;
		start.y = v.y * k + start.y;
		
		return start;
	}
	
	public static function equ(pt1:Point, pt2:Point) : Bool
	{
		return pt1.x == pt2.x && pt1.y == pt2.y;
	}
	
	public static function clone(pt:Point) : Point
	{
		return { x:pt.x, y:pt.y };
	}
	
	@:noUsing
	public static function roundGap(n:Float) : Float
	{
		return Math.round(n * 100) / 100;
	}
	
	public static function roundGapP(pt:Point) : Point
	{
		pt.x = roundGap(pt.x);
		pt.y = roundGap(pt.y);
		return pt;
	}
	
	public static function getNearest(pt:Point, points:Array<Point>) : Point
	{
		if (points == null || points.length == 0) return null;
		var bestP = points[0];
		var bestD = getSqrDistP(pt, bestP);
		for (point in points)
		{
			var dist = getSqrDistP(pt, point);
			if (dist < bestD)
			{
				bestP = point;
				bestD = dist;
			}
		}
		return bestP;
	}
	
	public static function toString(pt:Point) : String
	{
		return pt != null ? pt.x + "," + pt.y : "null";
	}
}
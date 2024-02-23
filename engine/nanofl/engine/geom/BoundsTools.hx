package nanofl.engine.geom;

class BoundsTools
{
	public static function extendR(bounds:Bounds, rect:{ x:Float, y:Float, width:Float, height:Float }) : Bounds
	{
		bounds.minX = Math.min(bounds.minX, rect.x);
		bounds.minY = Math.min(bounds.minY, rect.y);
		bounds.maxX = Math.max(bounds.maxX, rect.x + rect.width);
		bounds.maxY = Math.max(bounds.maxY, rect.y + rect.height);
		return bounds;
	}
	
	public static function extend(bounds:Bounds, b:Bounds) : Bounds
	{
		bounds.minX = Math.min(bounds.minX, b.minX);
		bounds.minY = Math.min(bounds.minY, b.minY);
		bounds.maxX = Math.max(bounds.maxX, b.maxX);
		bounds.maxY = Math.max(bounds.maxY, b.maxY);
		return bounds;
	}
	
	public static function isIntersect(a:Bounds, b:Bounds, gap=0.0) : Bool
	{
		return a != null
			&& b != null
			&& a.maxX > b.minX - gap
			&& a.maxY > b.minY - gap
			&& b.maxX > a.minX - gap
			&& b.maxY > a.minY - gap;
	}
	
	public static function isPointInside(bounds:Bounds, x:Float, y:Float, gap=0.0) : Bool
	{
		return x > bounds.minX - gap
		    && y > bounds.minY - gap
			&& x < bounds.maxX + gap
			&& y < bounds.maxY + gap;
	}
	
	public static function isPointInsideP(bounds:Bounds, pt:Point, gap=0.0) : Bool
	{
		return isPointInside(bounds, pt.x, pt.y, gap);
	}
	
	public static function getNearestPoint(bounds:Bounds, pos:Point) : Point
	{
		if (isPointInsideP(bounds, pos)) return PointTools.clone(pos);
		
		var points =
		[
			new StraightLine(bounds.minX, bounds.minY, bounds.maxX, bounds.minY).getNearestPoint(pos.x, pos.y).point,
			new StraightLine(bounds.maxX, bounds.minY, bounds.maxX, bounds.maxY).getNearestPoint(pos.x, pos.y).point,
			new StraightLine(bounds.maxX, bounds.maxY, bounds.minX, bounds.maxY).getNearestPoint(pos.x, pos.y).point,
			new StraightLine(bounds.minX, bounds.maxY, bounds.minX, bounds.minY).getNearestPoint(pos.x, pos.y).point
		];
		
		points.sort((a, b) ->
		{
			return Reflect.compare(PointTools.getDistP(pos, a), PointTools.getDistP(pos, b));
		});
		
		return points[0];
	}
	
	public static function clone(bounds:Bounds) : Bounds
	{
		if (bounds == null) return null;
		return
		{
			minX: bounds.minX,
			minY: bounds.minY,
			maxX: bounds.maxX,
			maxY: bounds.maxY
		};
	}
	
	public static function toBounds(rect:{ x:Float, y:Float, width:Float, height:Float }) : Bounds
	{
		return
		{
			minX: rect.x,
			minY: rect.y,
			maxX: rect.x + rect.width,
			maxY: rect.y + rect.height
		};
	}
	
	public static function toString(bounds:Bounds) : String
	{
		if (bounds == null) return "null";
		return bounds.minX + "," + bounds.minY + ", " + bounds.maxX + ", " + bounds.maxY;
	}
	
	public static function toRectangle(bounds:Bounds) : easeljs.geom.Rectangle
	{
		if (bounds == null) return null;
		return new easeljs.geom.Rectangle(bounds.minX, bounds.minY, bounds.maxX - bounds.minX, bounds.maxY - bounds.minY);
	}
	
	public static function transform<R:{ x:Float, y:Float, width:Float, height:Float }>(bounds:R, matrix:{ a:Float, b:Float, c:Float, d:Float, tx:Float, ty:Float }) : R
	{
		if (bounds == null) return null;
		
		var x_a = bounds.width * matrix.a;
		var x_b = bounds.width * matrix.b;
		var y_c = bounds.height * matrix.c;
		var y_d = bounds.height * matrix.d;
		var tx = matrix.tx + (bounds.x * matrix.a + bounds.y * matrix.c);
		var ty = matrix.ty + (bounds.x * matrix.b + bounds.y * matrix.d);
		
		var minX = tx;
		var minY = ty;
		var maxX = tx;
		var maxY = ty;
		
		var x, y;
		
		x = x_a + tx;
		if (x < minX) minX = x; else if (x > maxX) maxX = x;
		
		x = x_a + y_c + tx;
		if (x < minX) minX = x; else if (x > maxX) maxX = x;
		
		x = y_c + tx;
		if (x < minX) minX = x; else if (x > maxX) maxX = x;
		
		y = x_b + ty;
		if (y < minY) minY = y; else if (y > maxY) maxY = y;
		
		y = x_b + y_d + ty;
		if (y < minY) minY = y; else if (y > maxY) maxY = y;
		
		y = y_d + ty;
		if (y < minY) minY = y; else if (y > maxY) maxY = y;
		
		bounds.x = minX;
		bounds.y = minY;
		bounds.width  = maxX - minX;
		bounds.height = maxY - minY;
		
		return bounds;
	}
}
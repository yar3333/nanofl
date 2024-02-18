package svgimport.segments;
import nanofl.engine.geom.Point;


class ArcSegment extends Segment
{
	var x0 : Float;
	var y0 : Float;
	var rx : Float;
	var ry : Float;
	var rotation : Float;
	var isLargeArc : Bool;
	var isSweep : Bool;
	
	public function new(x0:Float, y0:Float, rx:Float, ry:Float, rotation:Float, isLargeArc:Bool, isSweep:Bool, x:Float, y:Float)
	{
		this.x0 = x0;
		this.y0 = y0;
		super(x, y);
		this.rx = rx;
		this.ry = ry;
		this.rotation = rotation;
		this.isLargeArc = isLargeArc;
		this.isSweep = isSweep;
	}
	
	override public function export(exporter:SvgPathToShapeConvertor)
	{
		if (x0 == x && y0 == y) return;
		if (rx == 0 || ry == 0) { exporter.lineTo(x, y); return; }
		
		var points = arcToCubicCurves(x0, y0, Math.abs(rx), Math.abs(ry), rotation, isLargeArc, isSweep, x, y, null);
		
		var i = 0; while (i < points.length)
		{
			var curve = new CubicSegment(points[i].x, points[i].y, points[i + 1].x, points[i + 1].y, points[i + 2].x, points[i + 2].y);
			curve.export(exporter);
			i += 3;
		}
	}
	
	static var RAD_120 = Math.PI * 2 / 3;
	
	/**
	 * See http://www.w3.org/TR/SVG11/implnote.html#ArcImplementationNotes for details.
	 */
	static function arcToCubicCurves(x1:Float, y1:Float, rx:Float, ry:Float, angle:Float, isLargeArc:Bool, isSweep:Bool, x2:Float, y2:Float, ?recursive:{ f1:Float, f2:Float, cx:Float, cy:Float })
	{
		var rad = Math.PI / 180 * angle;
		var res = new Array<Point>();
		
		var f1 : Float;
		var f2 : Float;
		var cx : Float;
		var cy : Float;
		
		if (recursive == null)
		{
			var xy = rotate(x1, y1, -rad);
			
			x1 = xy.x;
			y1 = xy.y;
			xy = rotate(x2, y2, -rad);
			x2 = xy.x;
			y2 = xy.y;
			
			var x = (x1 - x2) / 2;
			var y = (y1 - y2) / 2;
			var h = (x * x) / (rx * rx) + (y * y) / (ry * ry);
			if (h > 1)
			{
				h = Math.sqrt(h);
				rx = h * rx;
				ry = h * ry;
			}
			
			var rx2 = rx * rx;
			var ry2 = ry * ry;
			var k = (isLargeArc == isSweep ? -1 : 1) * Math.sqrt(Math.abs((rx2 * ry2 - rx2 * y * y - ry2 * x * x) / (rx2 * y * y + ry2 * x * x)));
			
			cx = k * rx * y / ry + (x1 + x2) / 2;
			cy = k * -ry * x / rx + (y1 + y2) / 2;
			f1 = Math.asin((y1 - cy) / ry);
			f2 = Math.asin((y2 - cy) / ry);

			f1 = x1 < cx ? Math.PI - f1 : f1;
			f2 = x2 < cx ? Math.PI - f2 : f2;
			if (f1 < 0) f1 = Math.PI * 2 + f1;
			if (f2 < 0) f2 = Math.PI * 2 + f2;
			
			if (isSweep && f1 > f2)
			{
				f1 = f1 - Math.PI * 2;
			}
			
			if (!isSweep && f2 > f1)
			{
				f2 = f2 - Math.PI * 2;
			}
		}
		else
		{
			f1 = recursive.f1;
			f2 = recursive.f2;
			cx = recursive.cx;
			cy = recursive.cy;
		}
		
		var df = f2 - f1;
		if (Math.abs(df) > RAD_120)
		{
			var f2old = f2;
			var x2old = x2;
			var y2old = y2;
			f2 = f1 + RAD_120 * (isSweep && f2 > f1 ? 1 : -1);
			x2 = cx + rx * Math.cos(f2);
			y2 = cy + ry * Math.sin(f2);
			res = arcToCubicCurves(x2, y2, rx, ry, angle, false, isSweep, x2old, y2old, { f1:f2, f2:f2old, cx:cx, cy:cy });
		}
		
		df = f2 - f1;
		var c1 = Math.cos(f1);
		var s1 = Math.sin(f1);
		var c2 = Math.cos(f2);
		var s2 = Math.sin(f2);
		var t = Math.tan(df / 4);
		var hx = 4 / 3 * rx * t;
		var hy = 4 / 3 * ry * t;
		var m1 = { x:x1, y:y1 };
		var m2 = { x:x1 + hx * s1, y:y1 - hy * c1 };
		var m3 = { x:x2 + hx * s2, y:y2 - hy * c2 };
		var m4 = { x:x2, y:y2 };
		
		m2.x = 2 * m1.x - m2.x;
		m2.y = 2 * m1.y - m2.y;
		
		if (recursive != null)
		{
			return [ m2, m3, m4 ].concat(res);
		}
		else
		{		
			res = [ m2, m3, m4 ].concat(res);
			var newres = [];
			for (i in 0...res.length)
			{
				newres.push(rotate(res[i].x, res[i].y, rad));
			}
			return newres;
		}
	}
	
	static function rotate(x:Float, y:Float, rad:Float) : Point
	{
		return
		{
			x: x * Math.cos(rad) - y * Math.sin(rad),
			y: x * Math.sin(rad) + y * Math.cos(rad)
		};
	}
}
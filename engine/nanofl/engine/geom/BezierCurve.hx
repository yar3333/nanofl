package nanofl.engine.geom;

import stdlib.Debug;
using nanofl.engine.geom.PointTools;
using nanofl.engine.geom.BoundsTools;

typedef BezierCurvesIntersection =
{
	var a : Array<BezierCurve>;
	var b : Array<BezierCurve>;
}

#if profiler @:build(Profiler.buildMarked()) #end
class BezierCurve
{
	static inline var EPS = 1e-10;
	static inline var GAP = 0.01;
	
	public var p1(default, null) : Point;			// handle 0 of curve
	public var p2(default, null) : Point;			// handle 1 of curve
	public var p3(default, null) : Point;			// handle 2 of curve
	
	public function new(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float)
	{
		p1 = { x:x1, y:y1 };
		p2 = { x:x2, y:y2 };
		p3 = { x:x3, y:y3 };
	}
	
	@:profile
	public function getNearestPoint(x:Float, y:Float) : { t:Float, point:Point, dist:Float, orientedDist:Float, nor:Point }
	{
		var Ax = p2.x - p1.x;
		var Ay = p2.y - p1.y;
		var Bx = p1.x - 2 * p2.x + p3.x;
		var By = p1.y - 2 * p2.y + p3.y;
		
		var dx = p1.x - x;
		var dy = p1.y - y;
		
		var sol = Equation.solveCube
		(
			Bx * Bx + By * By,
			3 * (Ax * Bx + Ay * By),
			2 * (Ax * Ax + Ay * Ay) + dx * Bx + dy * By,
			dx * Ax + dy * Ay
		);
		
		var d1 = PointTools.getSqrDist(x, y, p1.x, p1.y);
		var d3 = PointTools.getSqrDist(x, y, p3.x, p3.y);
		
		if (sol.length > 0)
		{
			var tMin : Float = null;
			var distMin : Float = 1.0e100;
			var pointMin : Point = null;
			
			for (t in sol)
			{
				if (t >= 0 && t <= 1)
				{
					var pt = getPoint(t);
					var dist = PointTools.getSqrDist(x, y, pt.x, pt.y);
					if (dist < distMin)
					{
						// minimum found!
						tMin = t;
						distMin = dist;
						pointMin = pt;
					}
				}
			}
			
			if (tMin != null && distMin < d1 && distMin < d3)
			{
				var nor = { x:Ay + tMin * By, y: -(Ax + tMin * Bx) };
				nor.normalize();
				
				var dist = Math.sqrt(distMin);
				
				var orientedDist = dist;
				if ((x - pointMin.x) * nor.x + (y - pointMin.y) * nor.y < 0)
				{
					nor.x *= -1;
					nor.y *= -1;
					orientedDist *= -1;
				}
				
				return { t:tMin, point:pointMin, nor:nor, dist:dist, orientedDist:orientedDist };
			}
		}
		
		if (d1 < d3)
		{
			var dist = Math.sqrt(d1);
			return { t:0, point:p1.clone(), nor:PointTools.normalize( { x:x - p1.x, y:y - p1.y } ), dist:dist, orientedDist:dist };
		}
		else
		{
			var dist = Math.sqrt(d3);
			return { t:1, point:p3.clone(), nor:PointTools.normalize( { x:x - p3.x, y:y - p3.y } ), dist:dist, orientedDist:dist };
		}
	}
	
	public function getNearestPointP(pt:Point) : { t:Float, point:Point, dist:Float, orientedDist:Float, nor:Point }
	{
		return getNearestPoint(pt.x, pt.y);
	}
	
	public function getPoint(t:Float) : Point
	{
		if (t == 0) return p1.clone();
		if (t == 1) return p3.clone();
		
		var z = 1 - t;
		var a = z * z;
		var b = 2 * t * z;
		var c = t * t;
		
		return
		{
			x: a * p1.x + b * p2.x + c * p3.x,
			y: a * p1.y + b * p2.y + c * p3.y
		};
	}
	
	function getPointX(t:Float) : Float
	{
		if (t == 0) return p1.x;
		if (t == 1) return p3.x;
		
		var z = 1 - t;
		var a = z * z;
		var b = 2 * t * z;
		var c = t * t;
		
		return a * p1.x + b * p2.x + c * p3.x;
	}
	
	public function getNor(t:Float) : Point
	{
		var Ax = p2.x - p1.x;
		var Ay = p2.y - p1.y;
		var Bx = p1.x - 2 * p2.x + p3.x;
		var By = p1.y - 2 * p2.y + p3.y;
		
		var nor = { x:Ay + t * By, y:-(Ax + t * Bx) };
		nor.normalize();
		return nor;
	}
	
	@:profile
	public function getBounds() : Bounds
	{
		var r =
		{
			minX: Math.min(p1.x, Math.min(p2.x, p3.x)),
			maxX: Math.max(p1.x, Math.max(p2.x, p3.x)),
			minY: Math.min(p1.y, Math.min(p2.y, p3.y)),
			maxY: Math.max(p1.y, Math.max(p2.y, p3.y))
		};
		
		var Ax = p2.x - p1.x;
		var Ay = p2.y - p1.y;
		var Bx = p1.x - 2 * p2.x + p3.x;
		var By = p1.y - 2 * p2.y + p3.y;
		
		if (Math.abs(Bx) > EPS && (r.minX == p2.x || r.maxX == p2.x))
		{
			var u = -Ax / Bx; // u where getTan(u).x == 0
			u = (1 - u) * (1 - u) * p1.x + 2 * u * (1 - u) * p2.x + u * u * p3.x;
			if (r.minX == p2.x) r.minX = u;
			else				r.maxX = u;
		}
		
		if (Math.abs(By) > EPS && (r.minY == p2.y || r.maxY == p2.y))
		{
			var u = -Ay / By; // u where getTan(u).y == 0
			u = (1 - u) * (1 - u) * p1.y + 2 * u * (1 - u) * p2.y + u * u * p3.y;
			if (r.minY == p2.y) r.minY = u;
			else				r.maxY = u;
		}
		
		return r;
	}
	
	
	@:profile
	public function getIntersectionPointsX_rightRay(mx:Float, my:Float) : Array<Float>
	{
		//trace("getIntersectionPointsX_rightRay vvvvvvvvvvvvvvvvvvvvv mx=" + mx + ", my=" + my);
		
		var r = [];
		
		if (my >= Math.min(p1.y, Math.min(p2.y, p3.y)) && my <= Math.max(p1.y, Math.max(p2.y, p3.y)) && mx <= Math.max(p1.x, Math.max(p2.x, p3.x)))
		{
			var Ay = p2.y - p1.y;
			var By = p1.y - 2 * p2.y + p3.y;
			
			var lineIntersectionCount = 0;
			for (t in Equation.solveQuadratic(By, 2 * Ay, p1.y - my))
			{
				//trace("getIntersectionPointsX_rightRay t = " + t);
				if (t > 0 && t < 1.0)
				{
					var x = getPointX(t);
					//trace("getIntersectionPointsX_rightRay x = " + x);
					if (x > mx) r.push(x);
					lineIntersectionCount++;
				}
			}
			
			//if (p1.y == my && p1.x > mx && p2.y > my) r.push(p1.x);
			//if (p3.y == my && p3.x > mx && p2.y > my) r.push(p3.x);
			
			//trace("getIntersectionPointsX_rightRay " + r);
			
			// detect touch
			if (lineIntersectionCount == 1
			 && (
					p1.y < my && p3.y < my
				 || p1.y > my && p3.y > my
			    )
			) return [];
		}
		
		//trace("getIntersectionPointsX_rightRay ^^^^^^^^^^^^^^^^^^^^^ r = " + r);
		
		return r;
	}
	
	public function getIntersectionCount_rightRay(mx:Float, my:Float) : Int
	{
		return getIntersectionPointsX_rightRay(mx, my).length;
	}
	
	@:profile
	function getIntersections_horizontalStraightSection(m1x:Float, my:Float, m2x:Float) : Array<{ t:Float, x:Float, y:Float }>
	{
		//log('getIntersections_horizontalStraightSection m1x=$m1x, my=$my, m2x=$m2x');
		//log('getIntersections_horizontalStraightSection x1=${p1.x}, y1=${p1.y}, x2=${p2.x}, y2=${p2.y}, x3=${p3.x}, y3=${p3.y}');
		
		var r = [];
		
		if (my >= Math.min(p1.y, Math.min(p2.y, p3.y)) && my <= Math.max(p1.y, Math.max(p2.y, p3.y)))
		{
			//log("getIntersections_horizontalStraightSection IN IF");
			
			//var Ax = p2.x - p1.x;
			var Ay = p2.y - p1.y;
			//var Bx = p1.x - 2 * p2.x + p3.x;
			var By = p1.y - 2 * p2.y + p3.y;
			
			var tt = Equation.solveQuadratic(By, 2 * Ay, p1.y - my);
			
			//log("getIntersections_horizontalStraightSection tt = " + tt);
			
			for (t in tt)
			{
				if (t >= 0 && t <= 1)
				{
					var x = (1 - t) * (1 - t) * p1.x + 2 * (1 - t) * t * p2.x + t * t * p3.x;
					if (x > Math.min(m1x, m2x) && x < Math.max(m1x, m2x))
					{
						r.push({ t:t, x:x, y:my });
					}
				}
			}
			
			if (r.length == 2 && r[0].t > r[1].t)
			{
				var z = r[0];
				r[0] = r[1];
				r[1] = z;
			}
		}
		return r;
	}
	
	@:profile
	public function getIntersection_straightSection(line:StraightLine) : { curves:Array<BezierCurve>, lines:Array<StraightLine> }
	{
		//log("getIntersection_straightSection");
		
		if (!getBounds().isIntersect(line.getBounds())) return null;
		
		//var commonPoints = getCommonPoints_straightSection(line);
		//if (commonPoints.length == 2) return null;
		//log("\ncommonPoints = " + commonPoints.length);
		
		var tt = getIntersection_straightSection_getT(line);
		
		//log("\ntt = " + (tt != null ? tt.length : null));
		
		if (tt == null) return null;
		
		/*if (commonPoints.length == 1)
		{
			var i = 0; while (i < tt.length)
			{
				if (getPoint(tt[i]).getDistP(commonPoints[0]) < EPS) tt.splice(i, 1);
				else i++;
			}
		}*/
		
		if (tt.length == 1)
		{
			var curves = split(tt);
			var m = curves[0].p3;
			var lines = [
				new StraightLine(line.x1, line.y1, m.x, m.y),
				new StraightLine(m.x, m.y, line.x2, line.y2)
			];
			//log("\ncurves = " + curves);
			//log("\nlines = " + lines);
			return { curves:excludeDegenerated(curves), lines:excludeDegenerated(lines) };
		}
		else
		if (tt.length == 2)
		{
			var curves = split(tt);
			var m0 = curves[1].p1;
			var m1 = curves[1].p3;
			
			if (PointTools.getSqrDist(line.x1, line.y1, m0.x, m0.y) < PointTools.getSqrDist(line.x1, line.y1, m1.x, m1.y))
			{
				var lines = [
					new StraightLine(line.x1, line.y1, m0.x, m0.y),
					new StraightLine(m0.x, m0.y, m1.x, m1.y),
					new StraightLine(m1.x, m1.y, line.x2, line.y2)
				];
				return { curves:excludeDegenerated(curves), lines:excludeDegenerated(lines) };
			}
			else
			{
				var lines = [
					new StraightLine(line.x1, line.y1, m1.x, m1.y),
					new StraightLine(m1.x, m1.y, m0.x, m0.y),
					new StraightLine(m0.x, m0.y, line.x2, line.y2)
				];
				return { curves:excludeDegenerated(curves), lines:excludeDegenerated(lines) };
			}
		}
		
		return null;
	}
	
	function getIntersection_straightSection_getT(line:StraightLine) : Array<Float>
	{
		if (!getBounds().isIntersect(line.getBounds())) return null;
		
		//log("getIntersection_straightSection_getT:");
		//log("\tline = " + line);
		//log("\tcurve = " + this);
		
		var dx = line.x2 - line.x1; //log("getIntersection_straightSection_getT dx = " + dx);
		var dy = line.y2 - line.y1; //log("getIntersection_straightSection_getT dy = " + dy);
		
		var len = Math.sqrt(dx * dx + dy * dy);
		var da = Math.atan2(dy, dx); //log("getIntersection_straightSection_getT da = " + da);
		
		var rotatedCurve = clone().translate(-line.x1, -line.y1).rotate(-da);
		//log("\trotatedCurve = " + rotatedCurve);
		//log("\tlen = " + len);
		
		var I = rotatedCurve.getIntersections_horizontalStraightSection(0, 0, len);
		for (i in I)
		{
			var p = PointTools.rotate(i.x, i.y, da);
			i.x = p.x + line.x1;
			i.y = p.y + line.y1;
		}
		
		//log("getIntersection_straightSection_getT I = " + I);
		
		if (I.length == 1)
		{
			return [ I[0].t ];
		}
		else
		if (I.length == 2)
		{
			return [ I[0].t, I[1].t ];
		}
		
		return null;
	}
	
	@:profile
	public function getIntersection_bezierCurve(curve:BezierCurve) : BezierCurvesIntersection
	{
		var r = getIntersection_bezierCurve_inner(this, curve);
		//log("getIntersection_bezierCurve:");
		//log(this.toString()  + " => " + (r != null ? r.a : []));
		//log(curve.toString() + " => " + (r != null ? r.b : []));
		return r;
	}
	
	@:profile
	static function isTrianglesIntersect(curveA:BezierCurve, curveB:BezierCurve) : Bool
	{
		var contourA = new Contour(curveA.getTriangle());
		var contourB = new Contour(curveB.getTriangle());
		
		for (a in contourA.edges)
		for (b in contourB.edges)
		{
			if (a.asStraightLine().getIntersection_straightSection(b.asStraightLine()) != null) return true;
		}
		
		if ((contourA.hasPoint(curveB.p1.x, curveB.p1.y) || !contourA.isPointInside(curveB.p1.x, curveB.p1.y))
		 && (contourA.hasPoint(curveB.p2.x, curveB.p2.y) || !contourA.isPointInside(curveB.p2.x, curveB.p2.y))
		 && (contourA.hasPoint(curveB.p3.x, curveB.p3.y) || !contourA.isPointInside(curveB.p3.x, curveB.p3.y)))
		{
			if ((contourB.hasPoint(curveA.p1.x, curveA.p1.y) || !contourB.isPointInside(curveA.p1.x, curveA.p1.y))
			 && (contourB.hasPoint(curveA.p2.x, curveA.p2.y) || !contourB.isPointInside(curveA.p2.x, curveA.p2.y))
			 && (contourB.hasPoint(curveA.p3.x, curveA.p3.y) || !contourB.isPointInside(curveA.p3.x, curveA.p3.y)))
			{
				return false;
			}
		}
		return true;
	}
	
	static function getIntersection_bezierCurve_inner(curveA:BezierCurve, curveB:BezierCurve) : BezierCurvesIntersection
	{
		if (curveA.equ(curveB)) return null;
		
		//log("vvvvvvvvvvv getIntersection_bezierCurve_inner curveA = " + curveA + "; curveB = " + curveB);
		
		var I = getIntersection_bezierCurve_getT(0, 1, curveA, 0, 1, curveB, 0);
		if (I == null) return null;
		
		Debug.assert(I.a.length == I.b.length, "I.a.length=" + I.a.length + " != I.b.length=" + I.b.length);
		//Debug.assert(I.a.length <= 4, "I.a.length = " + I.a.length + " ON:\ngetIntersection_bezierCurve_inner(" + curveA + ", " + curveB + ")");
		if (I.a.length > 4)
		{
			log("I.a.length = " + I.a.length + " ON:\ngetIntersection_bezierCurve_inner(" + curveA + ", " + curveB + ")");
			return null;
		}
		
		if (I.a.length == 0) return null;
		
		//I.a.sort(Reflect.compare);
		//I.b.sort(Reflect.compare);
		
		//log("before sort");
		//log("I.a = " + I.a);
		//log("I.b = " + I.b);
		
		var relatedIndexesInB = [ for (i in 0...I.a.length) i ]; 
		parallelSort(I.a, relatedIndexesInB);
		//log("relatedIndexesInB(1) = " + relatedIndexesInB);
		parallelSort(I.b, relatedIndexesInB, true);
		//log("relatedIndexesInB(2) = " + relatedIndexesInB);
		
		//log("after sort");
		//log("I.a = " + I.a);
		//log("I.b = " + I.b);
		
		//log("");
		//log("curveA = " + curveA);
		//log("curveB = " + curveB);
		//log("");
		//log("I.a = " + I.a);
		//log("I.b = " + I.b);
		
		var r = { a:curveA.split(I.a), b:curveB.split(I.b) };
		//log("r.a =\n" + r.a.join(";\n"));
		//log("r.b =\n" + r.b.join(";\n"));
		
		
		//log("fixCurvesIntersectionPoints vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
		//log("before:\n" + r.a.join(";\n") + ";\n---\n" + r.b.join(";\n") + ";");
		for (i in 0...(r.a.length - 1))
		{
			r.a[i].p3.x = r.a[i + 1].p1.x = r.b[relatedIndexesInB[i]].p3.x;
			r.a[i].p3.y = r.a[i + 1].p1.y = r.b[relatedIndexesInB[i]].p3.y;
		}
		//log("afer:\n" + r.a.join(";\n") + ";\n---\n" + r.b.join(";\n") + ";");
		//log("fixCurvesIntersectionPoints ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		
		excludeDegenerated(r.a);
		excludeDegenerated(r.b);
		//log("r.a =\n" + r.a.join(";\n"));
		//log("r.b =\n" + r.b.join(";\n"));
		
		return r;
	}
	
	static function excludeDegenerated<T:{ function isDegenerated():Bool; }>(arr:Array<T>) : Array<T>
	{
		//log("\nexcludeDegenerated BEGIN " + arr);
		var i = 0; while (i < arr.length)
		{
			if (arr[i].isDegenerated()) arr.splice(i, 1);
			else i++;
		}
		//log("\nexcludeDegenerated   END " + arr);
		return arr;
	}
	
	public function isDegenerated() : Bool return p1.equ(p2) && p2.equ(p3);
	
	static function getIntersection_bezierCurve_getT(ta1:Float, ta2:Float, curveA:BezierCurve, tb1:Float, tb2:Float, curveB:BezierCurve, level:Int) : { a:Array<Float>, b:Array<Float> }
	{
		level++;
		
		if (!curveA.getBounds().isIntersect(curveB.getBounds())) return null;
		if (!isTrianglesIntersect(curveA, curveB)) return null;
		
		var tinyA = curveA.isTiny();
		var tinyB = curveB.isTiny();
		
		var I1 : { a:Array<Float>, b:Array<Float> } = null;
		var I2 : { a:Array<Float>, b:Array<Float> } = null;
		var I3 : { a:Array<Float>, b:Array<Float> } = null;
		var I4 : { a:Array<Float>, b:Array<Float> } = null;
		
		if (!tinyA && !tinyB)
		{
			var subCurvesA = curveA.split([ 0.5 ]);
			var subCurvesB = curveB.split([ 0.5 ]);
			
			I1 = getIntersection_bezierCurve_getT(ta1, (ta1 + ta2) / 2, subCurvesA[0], tb1, (tb1 + tb2) / 2, subCurvesB[0], level);
			I2 = getIntersection_bezierCurve_getT(ta1, (ta1 + ta2) / 2, subCurvesA[0], (tb1 + tb2) / 2, tb2, subCurvesB[1], level);
			I3 = getIntersection_bezierCurve_getT((ta1 + ta2) / 2, ta2, subCurvesA[1], tb1, (tb1 + tb2) / 2, subCurvesB[0], level);
			I4 = getIntersection_bezierCurve_getT((ta1 + ta2) / 2, ta2, subCurvesA[1], (tb1 + tb2) / 2, tb2, subCurvesB[1], level);
		}
		else
		if (!tinyA && tinyB)
		{
			var subCurvesA = curveA.split([ 0.5 ]);
			
			I1 = getIntersection_bezierCurve_getT(ta1, (ta1 + ta2) / 2, subCurvesA[0], tb1, tb2, curveB, level);
			I2 = getIntersection_bezierCurve_getT((ta1 + ta2) / 2, ta2, subCurvesA[1], tb1, tb2, curveB, level);
		}
		else
		if (tinyA && !tinyB)
		{
			var subCurvesB = curveB.split([ 0.5 ]);
			
			I1 = getIntersection_bezierCurve_getT(ta1, ta2, curveA, tb1, (tb1 + tb2) / 2, subCurvesB[0], level);
			I2 = getIntersection_bezierCurve_getT(ta1, ta2, curveA, (tb1 + tb2) / 2, tb2, subCurvesB[1], level);
		}
		else
		{
			var lineA = new StraightLine(curveA.p1.x, curveA.p1.y, curveA.p3.x, curveA.p3.y);
			var lineB = new StraightLine(curveB.p1.x, curveB.p1.y, curveB.p3.x, curveB.p3.y);
			
			if (lineA.getIntersection_straightSection(lineB) != null)
			{
				return { a:[ (ta1 + ta2) / 2 ], b:[ (tb1 + tb2) / 2 ] };
			}
			
			return null;
		}
		
		if (I1 == null && I2 == null && I3 == null && I4 == null) return null;
		
		var r = { a:[], b:[] };
		
		if (I1 != null)
		{
			for (e in I1.a) r.a.push(e);
			for (e in I1.b) r.b.push(e);
		}
		
		if (I2 != null)
		{
			for (e in I2.a) r.a.push(e);
			for (e in I2.b) r.b.push(e);
		}
		
		if (I3 != null)
		{
			for (e in I3.a) r.a.push(e);
			for (e in I3.b) r.b.push(e);
		}
		
		if (I4 != null)
		{
			for (e in I4.a) r.a.push(e);
			for (e in I4.b) r.b.push(e);
		}
		
		Debug.assert(r.a.length == r.b.length);
		
		return r;
	}
	
	public function getFirstPart(t:Float) : BezierCurve
	{
		var m = getPoint(t);
		return new BezierCurve(p1.x, p1.y, p1.x + t * (p2.x - p1.x), p1.y + t * (p2.y - p1.y), m.x, m.y);
	}
	
	public function getSecondPart(t:Float) : BezierCurve
	{
		var m = getPoint(t);
		return new BezierCurve(m.x, m.y, p2.x + t * (p3.x - p2.x), p2.y + t * (p3.y - p2.y), p3.x, p3.y);
	}
	
	public function getPart(t1:Float, t2:Float) : BezierCurve
	{
		return getSecondPart(t1).getFirstPart((t2 - t1) / (1 - t1));
	}
	
	public function split(tt:Array<Float>) : Array<BezierCurve>
	{
		if (tt.length == 0) return [ clone() ];
		
		if (tt.length == 1)
		{
			var m = getPoint(tt[0]);
			return
			[
				new BezierCurve(p1.x, p1.y, p1.x + tt[0] * (p2.x - p1.x), p1.y + tt[0] * (p2.y - p1.y), m.x, m.y),
				new BezierCurve(m.x, m.y, p2.x + tt[0] * (p3.x - p2.x), p2.y + tt[0] * (p3.y - p2.y), p3.x, p3.y)
			];
		}
		
		if (tt.length == 2)
		{
			var curves = split([ tt[0] ]);
			var r =
			[
				curves[0],
				curves[1].getFirstPart((tt[1] - tt[0]) / (1 - tt[0])),
				getSecondPart(tt[1])
			];
			Debug.assert(r[0].p3.x == r[1].p1.x && r[0].p3.y == r[1].p1.y);
			r[1].p3.x = r[2].p1.x;
			r[1].p3.y = r[2].p1.y;
			Debug.assert(r[1].p3.x == r[2].p1.x && r[1].p3.y == r[2].p1.y);
			return r;			
		}
		
		var r = [];
		r.push(getFirstPart(tt[0]));
		for (i in 0...(tt.length - 1))
		{
			r.push(getPart(tt[i], tt[i + 1]));
		}
		r.push(getSecondPart(tt[tt.length - 1]));
		for (i in 0...tt.length)
		{
			r[i].p3.x = r[i + 1].p1.x;
			r[i].p3.y = r[i + 1].p1.y;
		}
		return r;
	}
	
	public function translate(dx:Float, dy:Float) : BezierCurve
	{
		p1.x += dx;
		p1.y += dy;
		p2.x += dx;
		p2.y += dy;
		p3.x += dx;
		p3.y += dy;
		
		return this;
	}
	
	public function rotate(da:Float) : BezierCurve
	{
		p1 = PointTools.getRotated(p1, da);
		p2 = PointTools.getRotated(p2, da);
		p3 = PointTools.getRotated(p3, da);
		
		return this;
	}
	
	public function clone() : BezierCurve
	{
		return new BezierCurve(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
	}
	
	function isTiny()
	{
		return Math.abs(p1.x - p2.x) < GAP && Math.abs(p1.y - p2.y) < GAP
		    && Math.abs(p3.x - p2.x) < GAP && Math.abs(p3.y - p2.y) < GAP;
	}
	
	public function equ(curve:BezierCurve)
	{
		return PointTools.equ(p2, curve.p2) &&
		(
			PointTools.equ(p1, curve.p1) && PointTools.equ(p3, curve.p3)
		 || PointTools.equ(p1, curve.p3) && PointTools.equ(p3, curve.p1)
		);
	}
	
	public function getReversed() : BezierCurve
	{
		return new BezierCurve(p3.x, p3.y, p2.x, p2.y, p1.x, p1.y);
	}
	
	public function reverse() : Void
	{
		var z = p1;
		p1 = p3;
		p3 = p1;
	}
	
	public function getLength() : Float
	{
		var Ax = p2.x - p1.x;
		var Ay = p2.y - p1.y;
		var Bx = p1.x - 2 * p2.x + p3.x;
		var By = p1.y - 2 * p2.y + p3.y;
		
		var ax2 = 2 * Ax;
		var ay2 = 2 * Ay;
		
		var a = 4 * (Bx * Bx + By * By);
		var b = 4 * (Bx * ax2 + By * ay2);
		var c = ax2 * ax2 + ay2 * ay2;

		var z1 = 2 * Math.sqrt(a + b + c);
		var z2 = Math.sqrt(a);
		var z3 = 2 * a * z2;
		var z4 = 2 * Math.sqrt(c);
		var z5 = b / z2;

		return (z3 * z1 + z2 * b * (z1 - z4) + (4 * c * a - b * b) * Math.log((2 * z2 + z5 + z1) / (z5 + z4))) / (4 * z3);
	}
	
	public function getTangent(t:Float) : Float
	{
		var Cx = (p2.x - p1.x) * t + p1.x;
		var Cy = (p2.y - p1.y) * t + p1.y;
		
		var Dx = (p3.x - p2.x) * t + p2.x;
		var Dy = (p3.y - p2.y) * t + p2.y;
		
		return Math.atan2(Dy - Cy, Dx - Cx);
    }
	
	/*function getCommonPoints_straightSection(line:StraightLine) : Array<Point>
	{
		var r = [];
		if (p1.x == line.x1 && p1.y == line.y1 || p1.x == line.x2 && p1.y == line.y2) r.push(p1);
		if (p3.x == line.x1 && p3.y == line.y1 || p3.x == line.x2 && p3.y == line.y2) r.push(p3);
		return r;
	}
	
	function getCommonPoints_bezierCurve(curve:BezierCurve) : Array<Point>
	{
		var r = [];
		if (p1.x == curve.p1.x && p1.y == curve.p1.y || p1.x == curve.p3.x && p1.y == curve.p3.y) r.push(p1);
		if (p3.x == curve.p1.x && p3.y == curve.p1.y || p3.x == curve.p3.x && p3.y == curve.p3.y) r.push(p3);
		return r;
	}*/
	
	function getTriangle() : Array<Edge>
	{
		return [ new Edge(p1.x, p1.y, p2.x, p2.y), new Edge(p2.x, p2.y, p3.x, p3.y), new Edge(p3.x, p3.y, p1.x, p1.y) ];
	}
	
	public function toString() return 'curve(${p1.x}, ${p1.y}, ${p2.x}, ${p2.y}, ${p3.x}, ${p3.y})';
	
	static function parallelSort(a:Array<Float>, b:Array<Int>, byValue=false)
	{
		for (i in 0...(a.length - 1))
		{
			for (j in 0...(a.length - 1))
			{
				if (a[j] > a[j + 1])
				{
					var z = a[j];
					a[j] = a[j + 1];
					a[j + 1] = z;
					
					if (!byValue)
					{
						var t = b[j];
						b[j] = b[j + 1];
						b[j + 1] = t;
					}
					else
					{
						var n1 = b.indexOf(j);
						var n2 = b.indexOf(j + 1);
						b[n1] = j + 1;
						b[n2] = j;
					}
				}
			}
		}
	}
	
	public function getMonotoneT(k:Float) : Float
	{
		if (k == 0) return 0;
		if (k == 1) return 1;
		
		var eps = GAP / 2;
		
		var need = getLength() * k;
		var t = 0.5;
		var d = 0.5;
		while (true)
		{
			var part = getFirstPart(t);
			var len = part.getLength();
			if (Math.abs(need - len) < eps) return t;
			d /= 2;
			if (need < len) t -= d;
			else            t += d;
		}
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.log(Reflect.isFunction(v) ? v() : v);
	}
}
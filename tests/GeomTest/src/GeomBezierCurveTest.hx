import nanofl.engine.geom.Edges;
import nanofl.engine.geom.BezierCurve;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.StraightLine;
using Lambda;

@:access(nanofl.engine.geom.BezierCurve)
class GeomBezierCurveTest extends BaseTest
{
	function assertIntersection(curveA:BezierCurve, curveB:BezierCurve, r:BezierCurvesIntersection)
	{
		assertEquals(curveA.p1.x, r.a[0].p1.x);
		assertEquals(curveA.p1.y, r.a[0].p1.y);
		assertEquals(curveA.p3.x, r.a[r.a.length - 1].p3.x);
		assertEquals(curveA.p3.y, r.a[r.a.length - 1].p3.y);
		
		assertEquals(curveB.p1.x, r.b[0].p1.x);
		assertEquals(curveB.p1.y, r.b[0].p1.y);
		assertEquals(curveB.p3.x, r.b[r.b.length - 1].p3.x);
		assertEquals(curveB.p3.y, r.b[r.b.length - 1].p3.y);
		
		assertSequence(r.a);
		assertSequence(r.b);
	}
	
	function assertSequence(curves:Array<BezierCurve>)
	{
		for (i in 0...curves.length - 1)
		{
			assertEquals(curves[i].p3.x, curves[i + 1].p1.x);
			assertEquals(curves[i].p3.y, curves[i + 1].p1.y);
		}
	}
	
	function test_bezierCurvesSplit_a()
	{
		var curve = new BezierCurve(516.17, 419.26, 609.25, -260.39, 672.06, 425.14);
		var r = curve.split([ 0.5 ]);
		assertEquals(2, r.length);
		assertTrue(Edges.isSequence(r.map(Edge.fromBezierCurve)));
	}
	
	function test_bezierCurvesSplit_b()
	{
		var curve = new BezierCurve(516.17, 419.26, 609.25, -260.39, 672.06, 425.14);
		var r = curve.split([ 0.2, 0.8 ]);
		assertEquals(3, r.length);
		assertTrue(Edges.isSequence(r.map(Edge.fromBezierCurve)));
	}
	
	function test_bezierCurvesSplit_c()
	{
		var curve = new BezierCurve(516.17, 419.26, 609.25, -260.39, 672.06, 425.14);
		var r = curve.split([ 0.2, 0.5, 0.8 ]);
		assertEquals(4, r.length);
		assertTrue(Edges.isSequence(r.map(Edge.fromBezierCurve)));
	}
	
	function test_bezierCurvesSplit_d()
	{
		var curve = new BezierCurve(516.17, 419.26, 609.25, -260.39, 672.06, 425.14);
		var r = curve.split([ 0.1, 0.2, 0.5, 0.8 ]);
		assertEquals(5, r.length);
		assertTrue(Edges.isSequence(r.map(Edge.fromBezierCurve)));
	}
	
	function test_bezierCurvesSplit_e()
	{
		var curve = new BezierCurve(516.17, 419.26, 609.25, -260.39, 672.06, 425.14);
		var r = curve.split([ 0.079833984375, 0.17236328125, 0.83251953125, 0.902099609375 ]);
		assertEquals(5, r.length);
	}
	
	function test_bezierCurvesIntersectRightRay()
	{
		var r = new BezierCurve(3, 4, 6, 6, 3, 8).getIntersectionCount_rightRay(1, 6);
		assertEquals(1, r);
	}
	
	function test_bezierCurvesIntersect_copy()
	{
		var curve = new BezierCurve(2, 8, 9, 2, 13, 5);
		var r = curve.getIntersection_bezierCurve(curve.clone());
		assertEquals(null, r);
	}
	
	function test_bezierCurvesIntersect_c()
	{
		var curveA = new BezierCurve(359.72, 200.49, 376.93, 149.82, 145, 98);
		var curveB = new BezierCurve(145, 98, 576.82, 194.49, 145, 286.95);
		var r = curveA.getIntersection_bezierCurve(curveB);
		assertIntersection(curveA, curveB, r);
	}
	
	function test_bezierCurvesIntersect_d()
	{
		var curveA = new BezierCurve(400, 50, 5, 70, 350, 100);
		var curveB = new BezierCurve(250, 110, 260, -20, 270, 120);
		
		var r = curveA.getIntersection_bezierCurve(curveB);
		
		assertEquals(5, r.a.length);
		assertEquals(5, r.b.length);
		
		assertIntersection(curveA, curveB, r);
	}
	
	function test_bezierCurvesIntersect_e()
	{
		var curveA = new BezierCurve(516.17, 419.26, 609.25, -260.39, 672.06, 425.14);
		var curveB = new BezierCurve(386.76, 216.31, 1220.86, 258.82, 395.58, 332.49);
		
		var r = curveA.getIntersection_bezierCurve(curveB);
		
		assertEquals(5, r.a.length);
		assertEquals(5, r.b.length);
		
		assertIntersection(curveA, curveB, r);
	}
	
	function test_bezierCurvesIntersect_f()
	{
		var curveA = new BezierCurve(648.97, 234.07, 610, -36.40, 650.02, 234.17);
		var curveB = new BezierCurve(648.97, 234.07, 649.49, 234.12, 650.02, 234.17);
		
		var r = curveA.getIntersection_bezierCurve(curveB);
		
		assertEquals(null, r);
	}
	
	function test_bezierCurvesIntersect_straightLine_a()
	{
		var edgeA = new BezierCurve(145, 98, 576.8228515625, 194.496875, 145, 286.95);
		var edgeB = new StraightLine(200, 371.95, 200, 183);
		
		var p = edgeA.getIntersection_straightSection(edgeB);
		
		assertTrue(p != null);
		assertEquals(2, p.curves.length);
		assertEquals(2, p.lines.length);
	}
	
	function test_bezierCurvesIntersect_straightLine_b()
	{
		var edgeA = new BezierCurve(358.20, 194.17, 345.88, 176, 358.20, 157.82);
		var edgeB = new StraightLine(208, 183.5, 419, 183.5);
		
		var p = edgeA.getIntersection_straightSection(edgeB);
		
		assertTrue(p != null);
		assertEquals(2, p.curves.length);
		assertEquals(2, p.lines.length);
	}
	
	function test_bezierCurvesIntersect_straightLine_c()
	{
		var edgeA = new BezierCurve(464.68, 219.88, 433.5, 227.0625, 402.31, 219.88);
		var edgeB = new StraightLine(419, 183.5, 419, 307.5);
		
		var p = edgeA.getIntersection_straightSection(edgeB);
		
		assertTrue(p != null);
		assertEquals(2, p.curves.length);
		assertEquals(2, p.lines.length);
	}
	
	function test_bezierCurvesIntersect_straightLine_d()
	{
		var edgeA = new BezierCurve(400.05, 298.12, 441.02, 264.06, 482, 230);
		var edgeB = new StraightLine(393, 219, 399.33, 298.71);
		
		var p = edgeA.getIntersection_straightSection(edgeB);
		
		assertTrue(p == null);
	}
	
	function testIntersectionRightRay()
	{
		var curve = new BezierCurve(339.37, 175.36, 250.32, 3.98, 166.5, 174.63);
		var point = { x:243, y:143 };
		
		var tt = curve.getIntersectionPointsX_rightRay(point.x, point.y);
		
		assertEquals(1, tt.length);
	}
}
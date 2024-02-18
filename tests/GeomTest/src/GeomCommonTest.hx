import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.SolidFill;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Contours;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.Polygons;
import nanofl.engine.geom.StraightLine;
using Lambda;

class GeomCommonTest extends BaseTest
{
	function testIntersectionLines()
	{
		var lineA = new StraightLine(340, 140, 340, 240);
		var lineB = new StraightLine(190,240, 355,200);
		
		var pt = lineA.getIntersection_straightSection(lineB);
		
		this.assertTrue(pt != null);
	}
	
	function testLineIntersection()
	{
		var r = new StraightLine(3, 8, 3, 4).isIntersect_rightRay(1, 6);
		assertTrue(r);
	}
	
	function testRightRayIntersectionTriangle()
	{
		var edgeA = new Edge(10, 5, 15, 20);
		var edgeB = new Edge(15, 20, 5, 20);
		var edgeC = new Edge(5, 20, 10, 5);
		var edgeD = new Edge(5, 20, 15, 20);
		
		assertEquals(1, edgeA.getIntersectionCount_rightRay(0, 5));
		assertEquals(0, edgeB.getIntersectionCount_rightRay(0, 5));
		assertEquals(0, edgeD.getIntersectionCount_rightRay(0, 5));
		assertEquals(1, edgeC.getIntersectionCount_rightRay(0, 5));
		
		assertEquals(0, edgeA.getIntersectionCount_rightRay(0, 20));
		assertEquals(0, edgeB.getIntersectionCount_rightRay(0, 20));
		assertEquals(0, edgeD.getIntersectionCount_rightRay(0, 20));
		assertEquals(0, edgeC.getIntersectionCount_rightRay(0, 20));
		
		assertEquals(0, edgeB.getIntersectionCount_rightRay(10, 20));
		assertEquals(0, edgeD.getIntersectionCount_rightRay(10, 20));
	}
	
	function testPointInside()
	{
		var ctx = new EdgesBuilder();
		ctx.moveTo(11.5, -18);
		ctx.lineTo(11.5, 26);
		ctx.lineTo(3.5, 26);
		ctx.lineTo(3.5, 4.35);
		ctx.lineTo(-3.5, 7.5);
		ctx.lineTo(-3.5, 26);
		ctx.lineTo(-11.5, 26);
		ctx.lineTo(-11.5, -4.65);
		ctx.quadraticCurveTo(-11.5, -6.35, -11.05, -9.9);
		ctx.quadraticCurveTo(-10.65, -13.45, -9.1, -17);
		ctx.quadraticCurveTo(-7.6, -20.55, -4.6, -23.25);
		ctx.quadraticCurveTo(-1.6, -26, 3.5, -26);
		ctx.quadraticCurveTo(7.05, -26, 9.25, -24);
		ctx.quadraticCurveTo(11.5, -22, 11.5, -18);
		
		var outer = new Contour(ctx.edges);
		assertTrue(outer.isPointInside(3.5, -18));
	}
	
	function testIsContourInside()
	{
		var ctx = new EdgesBuilder();
		ctx.moveTo(1.25, -17.35);
		ctx.quadraticCurveTo(0.05, -16.7, -1, -14.95);
		ctx.quadraticCurveTo(-2.05, -13.2, -2.75, -10.2);
		ctx.quadraticCurveTo(-3.5, -7.25, -3.5, -2.55);
		ctx.lineTo(3.5, -5.6);
		ctx.lineTo(3.5, -18);
		ctx.quadraticCurveTo(2.5, -18, 1.25, -17.35);
		
		var inner = new Contour(ctx.edges);
		
		ctx = new EdgesBuilder();
		ctx.moveTo(11.5, -18);
		ctx.lineTo(11.5, 26);
		ctx.lineTo(3.5, 26);
		ctx.lineTo(3.5, 4.35);
		ctx.lineTo(-3.5, 7.5);
		ctx.lineTo(-3.5, 26);
		ctx.lineTo(-11.5, 26);
		ctx.lineTo(-11.5, -4.65);
		ctx.quadraticCurveTo(-11.5, -6.35, -11.05, -9.9);
		ctx.quadraticCurveTo(-10.65, -13.45, -9.1, -17);
		ctx.quadraticCurveTo(-7.6, -20.55, -4.6, -23.25);
		ctx.quadraticCurveTo(-1.6, -26, 3.5, -26);
		ctx.quadraticCurveTo(7.05, -26, 9.25, -24);
		ctx.quadraticCurveTo(11.5, -22, 11.5, -18);
		
		var outer = new Contour(ctx.edges);
		
		assertTrue(inner.isNestedTo(outer));
		assertFalse(outer.isNestedTo(inner));
	}
	
	@:access(nanofl.engine.geom.Contours)
	function testSequences()
	{
		var edges =
		[
			new Edge(377, 148, 377, 261),
			new Edge(377, 261, 314, 246),
			new Edge(314, 246, 290, 220, 276, 199),
			new Edge(276, 199, 231, 135, 276, 129),
			new Edge(276, 129, 306, 125, 377, 148),
			new Edge(276, 92,  276, 129),
			new Edge(276, 129, 276, 199),
			new Edge(276, 199, 276, 234)
		];
		
		var sequences = Contours.getSequencesFromEdges(edges);
		//trace("sequences =\n" + sequences.map(function(s) return s.edges).join("\n"));
		
		assertEquals(5, sequences.length);
	}
	
	function testFindContours()
	{
		var edges =
		[
			new Edge(377, 148, 377, 261),
			new Edge(377, 261, 314, 246),
			new Edge(314, 246, 290, 220, 276, 199),
			new Edge(276, 199, 231, 135, 276, 129),
			new Edge(276, 129, 306, 125, 377, 148),
			new Edge(276, 92,  276, 129),
			new Edge(276, 129, 276, 199),
			new Edge(276, 199, 276, 234)
		];
		
		var contours = Contours.fromEdges(edges);
		assertEquals(2, contours.length);
	}
	
	function testIsEdgeInContour()
	{
		var edges =
		[
			new Edge(377,148, 377,261),
			new Edge(377,261, 314,246), 
			new Edge(314,246, 290,220, 276,199),
			new Edge(276,199, 276,129),
			new Edge(276,129, 306,125, 377,148)
		];
		
		var contour = new Contour(edges);
		assertFalse(contour.isEdgeInside(new Edge(276, 199, 231, 135, 276, 129)));
	}
	
	function testMerge()
	{
		var polygons =
		[
			new Polygon
			([
				new Contour
				([
					curve(175, 331.95, 184.19582859799505, 329.98117623865267, 193, 328.01051866538387),
					line(193, 328.01051866538387, 193, 423.95),
					curve(193, 423.95, 379.7526565843816, 383.9663200238167, 404.9735433000438, 343.2263182225573),
					curve(404.9735433000438, 343.2263182225573, 514.1631776029167, 294.55342539917365, 389.95272737009867, 244.77680175900616),
					curve(389.95272737009867, 244.77680175900616, 396.45678632095235, 223.45260007688123, 359.1686104699969, 201.9657655954361),
					curve(359.1686104699969, 201.9657655954361, 342.9111680223052, 241.47874571081456, 174.99999999999997, 280.2816548438754),
					line(174.99999999999997,280.2816548438754, 175,331.95)
				])
			]),
			new Polygon
			([
				new Contour
				([
					curve(359.1686104699969, 201.9657655954361, 307.69163942372734, 172.65180859856198, 175, 143),
					line(175, 143, 174.99999999999997, 280.2816548438754),
					curve(174.99999999999997, 280.2816548438754, 160.56073072516907, 283.61845286760564, 145, 286.95),
					line(145, 286.95, 145, 98),
					curve(145,98, 380.30971794128413,150.5832580566406, 359.1686104699969,201.9657655954361)
				]).reverse()
			]),
			new Polygon
			([
				new Contour
				([
					curve(359.1686104699969, 201.9657655954361, 307.69163942372734, 172.65180859856198, 175, 143),
					line(175, 143, 174.99999999999997, 280.2816548438754),
					curve(174.99999999999997,280.2816548438754, 342.9111680223052,241.47874571081456, 359.1686104699969,201.9657655954361)
				])
			])
		];
		
		var fill = new SolidFill("red");
		for (p in polygons)
		{
			p.fill = fill;
			this.assertEquals(1, p.contours.length);
			this.assertTrue(p.contours[0] != null);
		}
		
		Polygons.mergeByCommonEdges(polygons, []);
		
		assertEquals(1, polygons.length);
		assertEquals(1, polygons[0].contours.length);
		assertEquals(polygons[0].contours[0].edges.length, 9);
	}
	
	function testIntersect()
	{
		var edgesA =
		[
			line(276,  92,    276, 234),
			line(276, 234,    178, 161.5),
			line(178, 161.5,  276,  92)
		];
		
		var edgesB =
		[
			line(377, 261,    241, 178.75),
			line(241, 178.75, 377, 148)
		];
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(5, edgesA.length);
		assertEquals(4, edgesB.length);
	}
	
	function testCombinePoint()
	{
		var shape = new ShapeElement
		([
			new Polygon(new SolidFill("#FF0000"), [ new Contour
			([
				new Edge(377, 261, 377, 148),
				new Edge(377, 148, 199, 105.75),
				new Edge(199, 105.75, 377, 261)
			])])
		]);
		
		shape.combine(cast shape.clone());
		
		assertTrue(true);
	}
	
	function testFindContours2()
	{
		var edges =
		[
			new Edge(0,   0,  100, 0),
			new Edge(100, 0,  100, 50),
			new Edge(100, 50, 0,   50),
			new Edge(0,   50, 0,   0),
			
			new Edge(0+200,   0,  100+200, 0),
			new Edge(100+200, 0,  100+200, 50),
			new Edge(100+200, 50, 0+200,   50),
			new Edge(0+200,   50, 0+200,   0),
			
			new Edge(0+400,   0,  100+400, 0),
			new Edge(100+400, 0,  100+400, 50),
			new Edge(100+400, 50, 0+400,   50),
			new Edge(0+400,   50, 0+400,   0)
		];
		
		var contours = Contours.fromEdges(edges);
		
		assertEquals(3, contours.length);
	}
}

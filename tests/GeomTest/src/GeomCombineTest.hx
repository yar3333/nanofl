import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.EraseFill;
import nanofl.engine.fills.SolidFill;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Edges;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.strokes.SolidStroke;
using Lambda;

@:access(nanofl.ide.elements.ShapeElement)
class GeomCombineTest extends BaseTest
{
	function testA()
	{
		var edgesA = [ new Edge(200, 371.95, 200, 183) ];
		var edgesB = [ new Edge(145, 98, 576.82, 194.49, 145, 286.95) ];
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(2, edgesA.length);
		assertEquals(2, edgesB.length);
	}
	
	function testCombineSelf()
	{
		var red = new SolidStroke("red");
		
		var edges =
		[
			new StrokeEdge(400,240, 190,240, red),
			new StrokeEdge(190,240, 355,200, red),
			new StrokeEdge(355,200, 340,140, red),
			new StrokeEdge(340,140, 400,240, red)
		];
		
		var shapeA = new ShapeElement(edges);
		var shapeB = new ShapeElement(edges.copy());
		shapeA.combine(shapeB);
		
		this.assertEquals(4, shapeA.edges.length);
	}
	
	function test_intersect_a()
	{
		var edgesA = [ new Edge(410.35114624759, 263.298918841423, 450.560060413149, 318.305176661994, 200, 371.95), new Edge(200, 371.95, 200, 183), new Edge(200, 183, 213.950698691059, 186.117479361925, 227, 189.23073821346), new Edge(227, 189.23073821346, 227, 131), new Edge(227, 131, 526.830124473572, 198.001248168945, 410.35114624759, 263.298918841423) ];
		var edgesB = [ new Edge(145, 286.95, 145, 98), new Edge(145, 98, 576.8228515625, 194.496875, 145, 286.95) ];
		
		Edges.normalize(edgesA);
		Edges.normalize(edgesB);
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(7, edgesA.length);
		assertEquals(4, edgesB.length);
	}
	
	function test_intersect_b()
	{
		var edgesA = [ new Edge(200, 371.95, 200, 183) ];
		var edgesB = [ new Edge(145, 98, 576.8228515625, 194.496875, 145, 286.95) ];
		
		Edges.normalize(edgesA);
		Edges.normalize(edgesB);
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(2, edgesA.length);
		assertEquals(2, edgesB.length);
	}
	
	function test_intersect_c()
	{
		var edgesA = [ new Edge(648.970501174762,234.074656056214, 610.006239867374,-36.4032508106704, 650.0261725986,234.175330588818) ];
		var edgesB = [ new Edge(648.970501174762,234.074656056214, 649.499226857321,234.12497661056, 650.0261725986,234.175330588818) ];
		
		Edges.normalize(edgesA);
		Edges.normalize(edgesB);
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(1, edgesA.length);
		assertEquals(1, edgesB.length);
	}
	
	function test_intersect_d()
	{
		var edgesA = [ new Edge(516.17,419.26, 609.25,-260.39, 672.06,425.14) ];
		var edgesB = [ new Edge(386.76,216.31, 1220.86,258.82, 395.58,332.49) ];
		
		Edges.normalize(edgesA);
		Edges.normalize(edgesB);
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(5, edgesA.length);
		assertEquals(5, edgesB.length);
	}
	
	function test_edgesIntersect()
	{
		var edgesA =
		[
			new Edge(410.35114624759, 263.2989188414234, 450.560060413149, 318.30517666199376, 200, 371.95),
			new Edge(200, 371.95, 200, 183),
			new Edge(200, 183, 213.95069869105933, 186.1174793619253, 227, 189.23073821345983),
			new Edge(227, 189.23073821345983, 227, 131),
			new Edge(227, 131, 526.8301244735717, 198.00124816894532, 410.35114624759, 263.2989188414234)
		];
		
		var edgesB =
		[
			new Edge(145, 286.95, 145, 98),
			new Edge(145, 98, 576.8228515625, 194.496875, 145, 286.95)
		];
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(7, edgesA.length);
		assertEquals(4, edgesB.length);
	}
	
	function test_combine_a()
	{
		assertTrue(Edge.getIntersection(new Edge(200, 371.95, 200, 183), new Edge(145, 98, 576.82, 194.5, 145, 286.95)) != null);
		
		var red = new SolidFill("red");
		
		var pa = new Polygon
		(red, [
			new Contour
			([
				new Edge(410.35114624759, 263.2989188414234, 450.560060413149, 318.30517666199376, 200, 371.95),
				new Edge(200, 371.95, 200, 183),
				new Edge(200, 183, 213.95069869105933, 186.1174793619253, 227, 189.23073821345983),
				new Edge(227, 189.23073821345983, 227, 131),
				new Edge(227, 131, 526.8301244735717, 198.00124816894532, 410.35114624759, 263.2989188414234)
			]).reverse()
		]);

		var pb = new Polygon
		(red, [
			new Contour
			([
				new Edge(145, 286.95, 145, 98),
				new Edge(145, 98, 576.8228515625, 194.496875, 145, 286.95)
			]).reverse()
		]);
		
		var sa = new ShapeElement([], [pa]);
		var sb = new ShapeElement([], [pb]);
		
		sa.combine(sb);
		
		if (sa.polygons.length != 1)
		{
			trace("\n" + sa.polygons);
			assertTrue(false);
		}
		else
		{
			assertTrue(true);
		}
	}
	
	function test_edgesIntersectA()
	{
		var edgesA =
		[
			new Edge(226, 159, 657, 255, 176, 347),
			new Edge(176, 347, 176, 159),
			new Edge(176, 159, 202, 164, 226, 200),
			new Edge(226, 200, 226, 159)
		];
		
		var edgesB =
		[
			new Edge(145, 286, 145, 100),
			new Edge(145, 100, 576, 194, 145, 286)
		];
		
		Edges.intersect(edgesA, edgesB);
		
		assertEquals(6, edgesA.length);
		assertEquals(4, edgesB.length);
	}
	
	function test_combine_b()
	{
		var fill = new SolidFill("red");
		
		var a = new Polygon
		(fill, [
			new Contour
			([
				new Edge(226, 159, 657, 255, 176, 347),
				new Edge(176, 347, 176, 159),
				new Edge(176, 159, 202, 164, 226, 200),
				new Edge(226, 200, 226, 159)
			]).reverse()
		]);
		
		var b = new Polygon
		(fill, [
			new Contour
			([
				new Edge(145, 286, 145, 100),
				new Edge(145, 100, 576, 194, 145, 286)
			]).reverse()
		]);
		
		var shapeA = new ShapeElement([], [a]);
		var shapeB = new ShapeElement([], [b]);
		
		shapeA.combine(shapeB);
		
		assertTrue(true);
	}
	
	function test_combine_c()
	{
		var fill = new SolidFill("red");
		
		var a = new Polygon
		(fill, [
			new Contour
			([
				line(215.7384307299999, 364.11919716, 215.73843072999995, 270.27415029593215),
				curve(215.73843072999995, 270.27415029593215, 183.86762231315413, 278.6284553407296, 145, 286.95),
				line(145, 286.95, 145, 98),
				curve(145, 98, 405.1793412412661, 156.1407243236339, 351.83525794027366, 212.81347359290777),
				curve(351.83525794027366,212.81347359290777, 563.0100305949596,289.7684662640039, 215.7384307299999,364.11919716)
			]).reverse()
		]);
		
		var b = new Polygon
		(fill, [
			new Contour
			([
				line(145, 286.95, 145, 98),
				curve(145, 98, 576.8228515625, 194.496875, 145, 286.95)
			]).reverse()
		]);
		
		var fa = new ShapeElement([], [a]);
		var fb = new ShapeElement([], [b]);
		
		fa.combine(fb);
		
		assertTrue(true);
	}
	
	function test_combine_d()
	{
		var shape = new ShapeElement
		([
			new Polygon(new SolidFill("#FF0000"), [new Contour
			([
				new Edge(276, 92, 276, 185.78869047619048), 
				new Edge(276, 185.78869047619048, 299, 176), 
				new Edge(299, 176, 299, 289), 
				new Edge(299, 289, 215, 211.75), 
				new Edge(215, 211.75, 234.63079168186792, 203.39522854015738), 
				new Edge(234.63079168186792, 203.39522854015738, 178, 161.5), 
				new Edge(178, 161.5, 276, 92)
			]).reverse()]) 
		]);
		
		shape.combine(new ShapeElement([ new Polygon(new SolidFill("#FF0000"), [new Contour
		([
			new Edge(276, 92, 276, 234), 
			new Edge(276, 234, 178, 161.5), 
			new Edge(178, 161.5, 276, 92)
		]).reverse()])]));
		
		assertTrue(true);
	}
	
	function test_combine_e()
	{
		var shapeA = new ShapeElement
		(
			[
				new StrokeEdge(208,183.5, 419,183.5, new SolidStroke("red"), false),
				new StrokeEdge(419,183.5, 419,307.5, new SolidStroke("red"), false),
				new StrokeEdge(419,307.5, 208,307.5, new SolidStroke("red"), false),
				new StrokeEdge(208, 307.5, 208, 183.5, new SolidStroke("red"), false)
			],
			[
				new Polygon(new SolidFill("green"),
				[ 
					new Contour([new Edge(208, 183.5, 419, 183.5), new Edge(419, 183.5, 419, 307.5), new Edge(419, 307.5, 208, 307.5), new Edge(208, 307.5, 208, 183.5) ]).reverse()
				])
			]
		);
		
		var shapeB = new ShapeElement
		(
			[
				new StrokeEdge(508.7961818996699,194.17746303734177, 495.4513928667064,212.10664001433807, 464.6886997377548,219.8842777942861, new SolidStroke("red"), false),
				new StrokeEdge(464.6886997377548,219.8842777942861, 433.5,227.0625, 402.3113002622452,219.8842777942861, new SolidStroke("red"), false),
				new StrokeEdge(402.3113002622452,219.8842777942861, 371.5486071332936,212.1066400143381, 358.2038181003301,194.17746303734177, new SolidStroke("red"), false),
				new StrokeEdge(358.2038181003301,194.17746303734177, 345.8875,176, 358.2038181003301,157.82253696265823, new SolidStroke("red"), false),
				new StrokeEdge(358.2038181003301,157.82253696265823, 371.5486071332936,139.89335998566193, 402.31130026224514,132.1157222057139, new SolidStroke("red"), false),
				new StrokeEdge(402.31130026224514,132.1157222057139, 433.5,124.9375, 464.68869973775486,132.1157222057139, new SolidStroke("red"), false),
				new StrokeEdge(464.68869973775486,132.1157222057139, 495.4513928667064,139.8933599856619, 508.7961818996698,157.8225369626582, new SolidStroke("red"), false),
				new StrokeEdge(508.7961818996698,157.8225369626582, 521.1125,176, 508.7961818996699,194.17746303734177, new SolidStroke("red"), false)
			],
			[
				new Polygon(new SolidFill("green"),
				[
					new Contour([new Edge(508.7961818996699, 194.17746303734177, 495.4513928667064, 212.10664001433807, 464.6886997377548, 219.8842777942861), new Edge(464.6886997377548, 219.8842777942861, 433.5, 227.0625, 402.3113002622452, 219.8842777942861), new Edge(402.3113002622452, 219.8842777942861, 371.5486071332936, 212.1066400143381, 358.2038181003301, 194.17746303734177), new Edge(358.2038181003301, 194.17746303734177, 345.8875, 176, 358.2038181003301, 157.82253696265823), new Edge(358.2038181003301, 157.82253696265823, 371.5486071332936, 139.89335998566193, 402.31130026224514, 132.1157222057139), new Edge(402.31130026224514, 132.1157222057139, 433.5, 124.9375, 464.68869973775486, 132.1157222057139), new Edge(464.68869973775486, 132.1157222057139, 495.4513928667064, 139.8933599856619, 508.7961818996698, 157.8225369626582), new Edge(508.7961818996698, 157.8225369626582, 521.1125, 176, 508.7961818996699, 194.17746303734177) ]) .reverse()
				])
			]
		);
		
		
		shapeA.combine(shapeB);
		
		assertTrue(true);
	}
	
	function test_combine_f()
	{
		var shapeA = new ShapeElement
		(
			[
				new StrokeEdge(208,183.5, 419,183.5, new SolidStroke("red"), false),
				new StrokeEdge(419,183.5, 419,307.5, new SolidStroke("red"), false)
			]
		);
		
		var shapeB = new ShapeElement
		(
			[
				new StrokeEdge(464.6886997377548,219.8842777942861, 433.5,227.0625, 402.3113002622452,219.8842777942861, new SolidStroke("red"), false),
				new StrokeEdge(402.3113002622452,219.8842777942861, 371.5486071332936,212.1066400143381, 358.2038181003301,194.17746303734177, new SolidStroke("red"), false),
				new StrokeEdge(358.2038181003301,194.17746303734177, 345.8875,176, 358.2038181003301,157.82253696265823, new SolidStroke("red"), false)
			]
		);
		
		shapeA.combine(shapeB);
		
		assertEquals(9, shapeA.edges.length);
	}
	
	function test_combine_g()
	{
		var shapeA = new ShapeElement
		(
			[
				new StrokeEdge(507.91036260090294,277.65796600829447, 494.81118318204307,306.91083370760424, 464.6146745892072,319.6006637696247, new SolidStroke("red"), false),
				new StrokeEdge(464.6146745892072,319.6006637696247, 434,331.3125, 403.3853254107928,319.6006637696247, new SolidStroke("red"), false),
				new StrokeEdge(403.3853254107928,319.6006637696247, 373.18881681795693,306.91083370760424, 360.08963739909706,277.65796600829447, new SolidStroke("red"), false),
				new StrokeEdge(360.08963739909706,277.65796600829447, 348,248, 360.08963739909706,218.34203399170556, new SolidStroke("red"), false),
				new StrokeEdge(360.08963739909706,218.34203399170556, 373.1888168179569,189.08916629239576, 403.3853254107928,176.3993362303753, new SolidStroke("red"), false),
				new StrokeEdge(403.3853254107928,176.3993362303753, 434,164.6875, 464.6146745892072,176.3993362303753, new SolidStroke("red"), false),
				new StrokeEdge(464.6146745892072,176.3993362303753, 494.81118318204307,189.08916629239576, 507.9103626009029,218.3420339917055, new SolidStroke("red"), false),
				new StrokeEdge(507.9103626009029,218.3420339917055, 520,247.99999999999997, 507.91036260090294,277.65796600829447, new SolidStroke("red"), false)
			],
			[
				new Polygon(new SolidFill("green"),
				[
					new Contour
					([
						new Edge(507.91036260090294,277.65796600829447, 494.81118318204307,306.91083370760424, 464.6146745892072,319.6006637696247),
						new Edge(464.6146745892072,319.6006637696247, 434,331.3125, 403.3853254107928,319.6006637696247),
						new Edge(403.3853254107928,319.6006637696247, 373.18881681795693,306.91083370760424, 360.08963739909706,277.65796600829447),
						new Edge(360.08963739909706,277.65796600829447, 348,248, 360.08963739909706,218.34203399170556),
						new Edge(360.08963739909706,218.34203399170556, 373.1888168179569,189.08916629239576, 403.3853254107928,176.3993362303753),
						new Edge(403.3853254107928,176.3993362303753, 434,164.6875, 464.6146745892072,176.3993362303753),
						new Edge(464.6146745892072,176.3993362303753, 494.81118318204307,189.08916629239576, 507.9103626009029,218.3420339917055),
						new Edge(507.9103626009029,218.3420339917055, 520,247.99999999999997, 507.91036260090294,277.65796600829447)
					]).reverse()
				])
			]
		);
		
		var shapeB = new ShapeElement
		(
			[
				new StrokeEdge(459,253.5, 647,253.5, new SolidStroke("red"), false),
				new StrokeEdge(647,253.5, 647,391.5, new SolidStroke("red"), false),
				new StrokeEdge(647,391.5, 459,391.5, new SolidStroke("red"), false),
				new StrokeEdge(459,391.5, 459,253.5, new SolidStroke("red"), false)
			],
			[
				new Polygon(new SolidFill("green"),
				[
					new Contour
					([
						new Edge(459,253.5, 647,253.5),
						new Edge(647,253.5, 647,391.5),
						new Edge(647,391.5, 459,391.5),
						new Edge(459,391.5, 459,253.5)
					]).reverse()
				])
			]
		);
		
		shapeA.combine(shapeB);
		
		assertTrue(true);
	}
	
	function test_combine_h()
	{
		var shapeA = new ShapeElement
		([
			new StrokeEdge(322, 363, 361.02, 330.56, 400.05, 298.12, new SolidStroke("red"), false),
			new StrokeEdge(400.05, 298.12, 441.02, 264.06, 482, 230, new SolidStroke("red"), false),
			new StrokeEdge(345, 252, 372.52, 275.06, 400.05, 298.12, new SolidStroke("red"), false)
		]);
		
		var shapeB = new ShapeElement
		([
			new StrokeEdge(393, 219, 405, 370, new SolidStroke("red"), false)
		]);
		
		shapeA.combine(shapeB);
		
		assertTrue(true);
	}
	
	function test_combine_i()
	{
		var shapeA = new ShapeElement
		([
			new StrokeEdge(322, 363, 361.02, 330.56, 400.05, 298.12, new SolidStroke("red"), false),
			new StrokeEdge(400.05, 298.12, 441.02, 264.06, 482, 230, new SolidStroke("red"), false),
			new StrokeEdge(345, 252, 372.52, 275.06, 400.05, 298.12, new SolidStroke("red"), false),
			new StrokeEdge(400.05, 298.12, 446.52, 337.06, 493, 376, new SolidStroke("red"), false)
		]);
		
		var shapeB = new ShapeElement
		([
			new StrokeEdge(393, 219, 405, 370, new SolidStroke("red"), false)
		]);
		
		shapeA.combine(shapeB);
		
		assertTrue(true);
	}
	
	function test_combine_j()
	{
		var stroke = new SolidStroke("red");
		
		var shapeA = new ShapeElement
		(
			[
				new StrokeEdge(20, 20, 30, 20, stroke),
				new StrokeEdge(30, 20, 30, 30, stroke), 
				new StrokeEdge(30, 30, 20, 30, stroke), 
				new StrokeEdge(20, 30, 20, 20, stroke)
			],
			[
				new Polygon(new SolidFill("green"),
				[
					new Contour
					([
						new Edge(20, 20, 30, 20), 
						new Edge(30, 20, 30, 30), 
						new Edge(30, 30, 20, 30), 
						new Edge(20, 30, 20, 20)
					]).reverse()
				])
			]
		);
		
		var shapeB = new ShapeElement
		(
			[
				new StrokeEdge(10, 10, 50, 10, stroke),
				new StrokeEdge(50, 10, 50, 50, stroke),
				new StrokeEdge(50, 50, 10, 50, stroke), 
				new StrokeEdge(10, 50, 10, 10, stroke)
			],
			[
				new Polygon(new SolidFill("green"),
				[
					new Contour
					([
						new Edge(10, 10, 50, 10),
						new Edge(50, 10, 50, 50),
						new Edge(50, 50, 10, 50), 
						new Edge(10, 50, 10, 10)
					]).reverse()
				])
			]
		);
		
		shapeA.combine(shapeB);
		
		assertEquals(1, shapeA.polygons.length);
	}
	
	function test_combine_k()
	{
		var stroke = new SolidStroke("red");
		
		var shapeA = new ShapeElement
		(
			[],
			[
				new Polygon(new SolidFill("green"),
				[
					new Contour
					([
						new Edge(0, 0, 0, 30),
						new Edge(0, 30, 50, 30),
						new Edge(50, 30, 50, 0),
						new Edge(50, 0, 0, 0)
					])
				])
			]
		);
		
		var shapeB = new ShapeElement
		(
			[
				new StrokeEdge(25, -10, 25, 40, new SolidStroke("red"))
			],
			[]
		);
		
		shapeA.combine(shapeB);
		
		assertEquals(3, shapeA.edges.length);
		assertEquals(2, shapeA.polygons.length);
	}
	
	function test_combine_l()
	{
		var contourA = new Contour
		([
			new Edge(301.13, 282.33, 281.5, 295, 281.5, 302.5),
			new Edge(281.5, 302.5, 571.5, 302.5),
			new Edge(571.5,302.5, 571.5,232.5, 301.13,282.33)
			
		]);
		
		var contourB = new Contour
		([
			new Edge(402.74, 295.57, 394.24, 318.57, 401.04, 357.88),
			new Edge(401.04, 357.88, 431.76, 332.43, 440.26, 309.43),
			new Edge(440.26,309.43, 428.43,283.74, 402.74,295.57)
		]);
		
		var shapeA = new ShapeElement([ new Polygon(new SolidFill("green"), [ contourA ]) ]);
		var shapeB = new ShapeElement([ new Polygon(new SolidFill("red"),   [ contourB ]) ]);
		
		shapeA.combine(shapeB);
		
		assertTrue(true);
	}
	
	function test_combine_m()
	{
		var shape = new ShapeElement
		(
			[
				new StrokeEdge(105,61.5, -104.95,61.5, new SolidStroke("#7C0101"), false),
				new StrokeEdge(-104.95,61.5, -104.95,-61.5, new SolidStroke("#7C0101"), false),
				new StrokeEdge(-104.95,-61.5, 105,-61.5, new SolidStroke("#7C0101"), false),
				new StrokeEdge(105,-61.5, 105,61.5, new SolidStroke("#7C0101"), false)
			],
			[
				new Polygon(new SolidFill("#FFFFFF"), 
				[
					new Contour([new Edge(22.45,-15.1, 22.45,-21.75, 18.4,-26.55),new Edge(18.4,-26.55, 14.35,-31.3, 8.55,-33.1),new Edge(8.55,-33.1, 2.7,-34.9, -9.5,-34.9),new Edge(-9.5,-34.9, -23.5,-34.9, -37.5,-34.9),new Edge(-37.5,-34.9, -37.5,-33.85, -37.5,-32.8),new Edge(-37.5,-32.8, -36.05,-32.8, -34.6,-32.8),new Edge(-34.6,-32.8, -30.25,-32.8, -28.05,-30.3),new Edge(-28.05,-30.3, -26.45,-28.45, -26.45,-21.3),new Edge(-26.45,-21.3, -26.45,3.525, -26.45,28.35),new Edge(-26.45,28.35, -26.45,34.95, -27.65,36.65),new Edge(-27.65,36.65, -29.8,39.85, -34.6,39.85),new Edge(-34.6,39.85, -36.05,39.85, -37.5,39.85),new Edge(-37.5,39.85, -37.5,40.875, -37.5,41.9),new Edge(-37.5,41.9, -21.05,41.9, -4.6,41.9),new Edge(-4.6,41.9, -4.6,40.875, -4.6,39.85),new Edge(-4.6,39.85, -6.1,39.85, -7.6,39.85),new Edge(-7.6,39.85, -11.85,39.85, -14.05,37.35),new Edge(-14.05,37.35, -15.65,35.5, -15.65,28.35),new Edge(-15.65,28.35, -15.65,17.175, -15.65,6),new Edge(-15.65,6, -11.625,6, -7.6,6),new Edge(-7.6,6, 5.4,23.95, 18.4,41.9),new Edge(18.4,41.9, 28.65,41.9, 38.9,41.9),new Edge(38.9,41.9, 38.9,40.875, 38.9,39.85),new Edge(38.9,39.85, 32.8,39.2, 28.7,36.65),new Edge(28.7,36.65, 24.85,34.2, 19.35,26.6),new Edge(19.35,26.6, 11.425,15.575, 3.5,4.55),new Edge(3.5,4.55, 13.25,2.35, 17.8,-2.8),new Edge(17.8,-2.8, 22.45,-8.05, 22.45,-15.1)]),
					new Contour([new Edge(9.7,-14.4, 9.7,-7.05, 4.1,-2.25),new Edge(4.1,-2.25, -1.5,2.5, -12.45,2.5),new Edge(-12.45,2.5, -14.05,2.475, -15.65,2.45),new Edge(-15.65,2.45, -15.65,-13.525, -15.65,-29.5),new Edge(-15.65,-29.5, -9.75,-30.6, -6.75,-30.6),new Edge(-6.75,-30.6, 0.65,-30.6, 5.2,-26.05),new Edge(5.2,-26.05, 9.7,-21.55, 9.7,-14.4)])
				]),
				new Polygon(new SolidFill("#000000"),
				[
					new Contour([new Edge(105,61.5, 105,0, 105,-61.5),new Edge(105,-61.5, 0.0249999999999986,-61.5, -104.95,-61.5),new Edge(-104.95,-61.5, -104.95,0, -104.95,61.5),new Edge(-104.95,61.5, 0.0249999999999986,61.5, 105,61.5)]),
					new Contour([new Edge(9.7,-14.4, 9.7,-7.05, 4.1,-2.25),new Edge(4.1,-2.25, -1.5,2.5, -12.45,2.5),new Edge(-12.45,2.5, -14.05,2.475, -15.65,2.45),new Edge(-15.65,2.45, -15.65,-13.525, -15.65,-29.5),new Edge(-15.65,-29.5, -9.75,-30.6, -6.75,-30.6),new Edge(-6.75,-30.6, 0.65,-30.6, 5.2,-26.05),new Edge(5.2,-26.05, 9.7,-21.55, 9.7,-14.4)]),
					new Contour([new Edge(22.45,-15.1, 22.45,-8.05, 17.8,-2.8),new Edge(17.8,-2.8, 13.25,2.35, 3.5,4.55),new Edge(3.5,4.55, 11.425,15.575, 19.35,26.6),new Edge(19.35,26.6, 24.85,34.2, 28.7,36.65),new Edge(28.7,36.65, 32.8,39.2, 38.9,39.85),new Edge(38.9,39.85, 38.9,40.875, 38.9,41.9),new Edge(38.9,41.9, 28.65,41.9, 18.4,41.9),new Edge(18.4,41.9, 5.4,23.95, -7.6,6),new Edge(-7.6,6, -11.625,6, -15.65,6),new Edge(-15.65,6, -15.65,17.175, -15.65,28.35),new Edge(-15.65,28.35, -15.65,35.5, -14.05,37.35),new Edge(-14.05,37.35, -11.85,39.85, -7.6,39.85),new Edge(-7.6,39.85, -6.1,39.85, -4.6,39.85),new Edge(-4.6,39.85, -4.6,40.875, -4.6,41.9),new Edge(-4.6,41.9, -21.05,41.9, -37.5,41.9),new Edge(-37.5,41.9, -37.5,40.875, -37.5,39.85),new Edge(-37.5,39.85, -36.05,39.85, -34.6,39.85),new Edge(-34.6,39.85, -29.8,39.85, -27.65,36.65),new Edge(-27.65,36.65, -26.45,34.95, -26.45,28.35),new Edge(-26.45,28.35, -26.45,3.525, -26.45,-21.3),new Edge(-26.45,-21.3, -26.45,-28.45, -28.05,-30.3),new Edge(-28.05,-30.3, -30.25,-32.8, -34.6,-32.8),new Edge(-34.6,-32.8, -36.05,-32.8, -37.5,-32.8),new Edge(-37.5,-32.8, -37.5,-33.85, -37.5,-34.9),new Edge(-37.5,-34.9, -23.5,-34.9, -9.5,-34.9),new Edge(-9.5,-34.9, 2.7,-34.9, 8.55,-33.1),new Edge(8.55,-33.1, 14.35,-31.3, 18.4,-26.55),new Edge(18.4,-26.55, 22.45,-21.75, 22.45,-15.1)])
				])
			]
		);
		
		shape.fixErrors();
		
		assertTrue(true);
	}
}
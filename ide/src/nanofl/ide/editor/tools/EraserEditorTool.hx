package nanofl.ide.editor.tools;

import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.EraseFill;
import nanofl.engine.fills.SolidFill;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.PointTools;
import nanofl.engine.geom.Polygon;

class EraserEditorTool extends DrawEditorTool
{
	static inline var R = 15;
	
	var edges = new Array<Edge>();
	var startPos : Point;
	
	override function getStatusBarText() return
		   "Hold Shift key to draw a line wih beauty angle."
		+ " Hold Ctrl key to magnet on.";
	
	override public function getCursor() return "url(images/circle.cur), auto";
	
	override function init() 
	{
		super.init();
		editor.deselectAllWoUpdate();
	}
	
	override function drawingBegin(pos:Point)
	{
		startPos = pos;
		edges = [ new Edge(pos.x, pos.y, pos.x, pos.y) ];
	}
	
	override function drawingMove(_, newPos:Point)
	{
		newPos = getShiftPoint(startPos, newPos);
		edges.push(new Edge(startPos.x, startPos.y, newPos.x, newPos.y));
		startPos = newPos;
	}
	
	override function drawingEnd(pos:Point)
	{
		for (edge in edges)
		{
			var contour = getContour(edge.x1, edge.y1, edge.x3, edge.y3);
			var eraseShape = new ShapeElement
			(
				[ new Polygon(new EraseFill(), [ contour ]) ]
			);
			editor.activeShape.combine(eraseShape);
		}
		
		edges = [];
		editor.deselectAllWoUpdate();
	}
	
	override function drawingUpdateSelections(g:easeljs.display.Graphics)
	{
		new SolidFill("rgba(255,255,255,0.5)").begin(g);
		for (edge in edges)
		{
			getContour(edge.x1, edge.y1, edge.x3, edge.y3).draw(g);
		}
		g.endFill();
	}
	
	function getContour(x1:Float, y1:Float, x2:Float, y2:Float) : Contour
	{
		var r = R / (editor.zoomLevel / 100);
		var len = PointTools.getDist(x1, y1, x2, y2);
		var t = r * 0.9;
		
		var edges =
		[
			new Edge( 0, -r, -t, -t, -r, 0),
			new Edge(-r,  0, -t,  t,  0, r),
			new Edge(0, r, len, r),
			new Edge(len, r, len + t, t, len + r, 0),
			new Edge(len + r, 0, len + t, -t, len, -r),
			new Edge(len, -r, 0, -r)
		];
		
		var contour = new Contour(edges);
		contour.transform(new Matrix().rotate(Math.atan2(y2 - y1, x2 - x1)).translate(x1, y1));
		return contour;
	}
}
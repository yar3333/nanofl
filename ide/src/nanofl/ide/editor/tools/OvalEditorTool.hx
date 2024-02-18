package nanofl.ide.editor.tools;

import nanofl.engine.elements.ShapeElement;
import nanofl.engine.fills.TypedFill;
import nanofl.engine.geom.Contour;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.libraryitems.BitmapItem;
import nanofl.engine.ShapeRender;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.tools.DrawEditorTool;

class OvalEditorTool extends DrawEditorTool
{
	var pt1 : Point;
	var pt2 : Point;
	
	override function getStatusBarText() return
		"Hold Shift key to draw a circle.";
	
	override function init() 
	{
		super.init();
		editor.deselectAllWoUpdate();
	}
	
	override function drawingBegin(pos:Point)
	{
		pt1 = pos;
	}
	
	override function drawingMove(oldPos:Point, newPos:Point)
	{
		pt2 = newPos;
	}
	
	override function drawingEnd(pos:Point)
	{
		if (pt1 != null && pt2 != null)
		{
			editor.activeShape.combine(createShape());
			pt1 = null;
			pt2 = null;
			editor.deselectAllWoUpdate();
		}
	}
	
	override function drawingUpdateSelections(g:ShapeRender)
	{
		if (pt1 != null && pt2 != null)
		{
			createShape().draw(g, 1);
		}
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject
	{
		return PropertiesObject.SHAPE(editor.figure, newObjectParams, new ShapePropertiesOptions().showStrokePane().showFillPane());
	}
	
	function createShape() : ShapeElement
	{
		if (editor.shift)
		{
			var d = Math.min(pt2.x - pt1.x, pt2.y - pt1.y);
			
			if (pt1.x < pt2.x) pt2.x = pt1.x + d;
			else               pt1.x = pt2.x - d;
			
			if (pt1.y < pt2.y) pt2.y = pt1.y + d;
			else               pt1.y = pt2.y - d;
		}
		
		var cx = (pt1.x + pt2.x) / 2;
		var cy = (pt1.y + pt2.y) / 2;
		
		var rx = Math.abs(pt2.x - pt1.x) / 2;
		var ry = Math.abs(pt2.y - pt1.y) / 2;
		
		var fill = newObjectParams.fill;
		if (fill != null)
		{
			switch (fill.getTyped())
			{
				case TypedFill.solid(_):
					// nothing to do
					
				case TypedFill.linear(fill):
					fill.x0 = cx;
					fill.y0 = cy;
					fill.x1 = cx + rx;
					fill.y1 = cy + ry;
					
				case TypedFill.radial(fill):
					fill.cx = cx;
					fill.cy = cy;
					fill.r = Math.max(rx, ry);
					fill.fx = cx;
					fill.fy = cy;
					
				case TypedFill.bitmap(fill):
					var bitmap = library.getItem(fill.bitmapPath);
					if (Std.isOfType(bitmap, BitmapItem))
					{
						var w = (cast bitmap:BitmapItem).image.naturalWidth;
						var h = (cast bitmap:BitmapItem).image.naturalHeight;
						var k = Math.max(rx, ry) / Math.min(w, h) * 2;
						
						fill.matrix = new Matrix()
							.translate(-w/2, -h/2)
							.scale(k, k)
							.translate(cx, cy);
					}
			}
		}
		
		return ShapeElement.createOval(cx, cy, rx, ry, 0, 360, 0, true, newObjectParams.stroke, newObjectParams.fill);
	}
}
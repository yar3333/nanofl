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

class RectangleEditorTool extends DrawEditorTool
{
	var pt1 : Point;
	var pt2 : Point;
	
	override function getStatusBarText() return
		   "Hold Shift key to draw a square."
		+ " Hold Ctrl key to magnet on.";
	
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
		return PropertiesObject.SHAPE(editor.figure, newObjectParams, new ShapePropertiesOptions().showStrokePane().showFillPane().showRoundRadiusPane());
	}
	
	function createShape() : ShapeElement
	{
		var x1 = Math.min(pt1.x, pt2.x);
		var y1 = Math.min(pt1.y, pt2.y);
		var x2 = Math.max(pt1.x, pt2.x);
		var y2 = Math.max(pt1.y, pt2.y);
		
		if (editor.shift)
		{
			var d = Math.min(x2 - x1, y2 - y1);
			
			if (pt1.x < pt2.x) x2 = x1 + d;
			else               x1 = x2 - d;
			
			if (pt1.y < pt2.y) y2 = y1 + d;
			else               y1 = y2 - d;
		}
		
		var r = Math.min(newObjectParams.roundRadius, Math.min((x2 - x1) / 2, (y2 - y1) / 2));
		
		if (newObjectParams.fill != null)
		{
			switch (newObjectParams.fill.getTyped())
			{
				case TypedFill.solid(_):
					// nothing to do
					
				case TypedFill.linear(fill):
					//fill.matrix = new Matrix().scale((x2 - x1) / 2, (y2 - y1) / 2).translate((x1 + x2) / 2, (y1 + y2) / 2);
					fill.x0 = x1;
					fill.y0 = y1;
					fill.x1 = x2;
					fill.y1 = y2;
					
				case TypedFill.radial(fill):
					//fill.matrix = new Matrix().scale((x2 - x1) / 2, (y2 - y1) / 2).translate((x1 + x2) / 2, (y1 + y2) / 2);
					fill.cx = fill.fx = (x1 + x2) / 2;
					fill.cy = fill.fy = (y1 + y2) / 2;
					fill.r = Math.max(x2 - x1, y2 - y1) / 2;
					
				case TypedFill.bitmap(fill):
					var bitmap = library.getItem(fill.bitmapPath);
					if (Std.isOfType(bitmap, BitmapItem))
					{
						var w = (cast bitmap:BitmapItem).image.naturalWidth;
						var h = (cast bitmap:BitmapItem).image.naturalHeight;
						var k = Math.max(x2 - x1, y2 - y1) / Math.min(w, h);
						
						fill.matrix = new Matrix()
							.translate(-w/2, -h/2)
							.scale(k, k)
							.translate((x1 + x2) / 2, (y1 + y2) / 2);
					}
			}
		}
		
		return ShapeElement.createRectangle(x1, y1, x2 - x1, y2 - y1, r, r, r, r, newObjectParams.stroke, newObjectParams.fill);
	}
}
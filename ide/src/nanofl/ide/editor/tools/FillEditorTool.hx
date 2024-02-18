package nanofl.ide.editor.tools;

import easeljs.display.Graphics;
import nanofl.engine.fills.TypedFill;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.geom.StrokeEdges;
import nanofl.engine.strokes.SolidStroke;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.tools.DrawEditorTool;

class FillEditorTool extends DrawEditorTool
{
	var edge : StrokeEdge;
	
	override function getStatusBarText() return
		"Click in closed area to fill.";
	
	override function drawingBegin(pos:Point)
	{
		edge = null;
	}
	
	override function drawingMove(oldPos:Point, newPos:Point)
	{
		if (edge == null)
		{
			edge = new StrokeEdge(oldPos.x, oldPos.y, newPos.x, newPos.y, new SolidStroke("black", true));
		}
		else
		{
			edge.translateEnd(newPos.x - oldPos.x, newPos.y - oldPos.y);
		}
	}
	
	override function drawingEnd(pos:Point)
	{
		if (edge == null) edge = new StrokeEdge(pos.x, pos.y, pos.x, pos.y, null);
		
		if (editor.figure.hasSelectedPolygons())
		{
			editor.figure.setSelectedPolygonsFill(newObjectParams.fill, edge.x1, edge.y1, edge.x3, edge.y3);
		}
		else
		{
			editor.activeShape.floodFill(newObjectParams.fill, edge.x1, edge.y1, edge.x3, edge.y3);
		}
		
		edge = null;
	}
	
	override function drawingUpdateSelections(g:Graphics)
	{
		if (edge == null) return;
		
		var fill = newObjectParams.getFillByType(newObjectParams.fillType);
		switch (fill.getTyped())
		{
			case TypedFill.solid(fill):
				// nothing to do
				
			case TypedFill.linear(fill):
				StrokeEdges.drawSorted([ edge ], g, 1);
				
			case TypedFill.radial(fill):
				edge.stroke.begin(g);
				g.drawCircle(edge.x1, edge.y1, Math.sqrt((edge.x3 - edge.x1) * (edge.x3 - edge.x1) + (edge.y3 - edge.y1) * (edge.y3 - edge.y1)));
				g.endStroke();
				
			case TypedFill.bitmap(fill):
				StrokeEdges.drawSorted([ edge ], g, 1);
		}
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject
	{
		return PropertiesObject.SHAPE(editor.figure, newObjectParams, new ShapePropertiesOptions().showFillPane().disallowNoneFill());
	}
}
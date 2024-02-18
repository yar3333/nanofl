package nanofl.ide.editor.tools;

import nanofl.engine.elements.ShapeElement;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.geom.StrokeEdges;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.tools.DrawEditorTool;

class LineEditorTool extends DrawEditorTool
{
	var edge : StrokeEdge;
	var startPos : Point;
	
	override function getStatusBarText() return
		   "Hold Shift key to draw a line wih beauty angle."
		+ " Hold Ctrl key to magnet on.";
	
	override function init() 
	{
		super.init();
		editor.deselectAllWoUpdate();
		if (newObjectParams.strokeType == "none") newObjectParams.strokeType = "solid";
	}
	
	override function drawingBegin(pos:Point)
	{
		edge = null;
		startPos = pos;
	}
	
	override function drawingMove(_, newPos:Point)
	{
		newPos = getShiftPoint(startPos, newPos);
		edge = new StrokeEdge(startPos.x, startPos.y, newPos.x, newPos.y, newObjectParams.stroke);
	}
	
	override function drawingEnd(pos:Point)
	{
		if (edge != null)
		{
			editor.activeShape.combine(new ShapeElement([edge]));
			edge = null;
			editor.deselectAllWoUpdate();
		}
	}
	
	override function drawingUpdateSelections(g:easeljs.display.Graphics)
	{
		if (edge != null) StrokeEdges.drawSorted([ edge ], g, 1);
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject
	{
		return PropertiesObject.SHAPE(editor.figure, newObjectParams, new ShapePropertiesOptions().showStrokePane().disallowNoneStroke());
	}
}
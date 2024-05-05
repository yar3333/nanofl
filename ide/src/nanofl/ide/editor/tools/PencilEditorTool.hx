package nanofl.ide.editor.tools;

import nanofl.engine.geom.Edges;
import nanofl.engine.elements.ShapeElement;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.StrokeEdge;
import nanofl.engine.geom.StrokeEdges;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.tools.DrawEditorTool;

#if profiler @:build(Profiler.buildMarked()) #end
class PencilEditorTool extends DrawEditorTool
{
	var edges = new Array<StrokeEdge>();
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
		edges = [];
		startPos = pos;
	}
	
	override function drawingMove(_, newPos:Point)
	{
		newPos = getShiftPoint(startPos, newPos);
		edges.push(new StrokeEdge(startPos.x, startPos.y, newPos.x, newPos.y, newObjectParams.stroke));
		startPos = newPos;
	}
	
	@:profile
	override function drawingEnd(pos:Point)
	{
		log("drawingEnd edges(1) = " + edges.length);
		Edges.smoothStraightLineSequence(edges, 1);
		log("drawingEnd edges(2) = " + edges.length);
		edges = Edges.simplificate(edges, 2 * 100 / editor.zoomLevel);
		log("drawingEnd edges(3) = " + edges.length);
		Edges.intersectSelf(edges);
		log("drawingEnd edges(4) = " + edges.length);
		editor.activeShape.combine(new ShapeElement(edges));
		edges = [];
		editor.deselectAllWoUpdate();
	}
	
	override function drawingUpdateSelections(g:easeljs.display.Graphics)
	{
		StrokeEdges.drawSorted(edges, g, 1);
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject
	{
		return PropertiesObject.SHAPE
		(
			editor.figure,
			newObjectParams,
			new ShapePropertiesOptions().showStrokePane().disallowNoneStroke()
		);
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.namedLog("PencilEditorTool", v);
	}
}
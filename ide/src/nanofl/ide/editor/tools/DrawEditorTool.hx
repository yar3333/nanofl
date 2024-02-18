package nanofl.ide.editor.tools;

import easeljs.display.Graphics;
import easeljs.display.Shape;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.MagnetMark;
import nanofl.engine.geom.Point;
using nanofl.engine.geom.PointTools;

class DrawEditorTool extends EditorTool
{
	var oldPos : Point;
	var magnetMark = new MagnetMark();
	
	override public function stageMouseDown(e:EditorMouseEvent)
	{
		if (!isActiveLayerEditable()) return;
		
		undoQueue.beginTransaction({ figure:true });
		
		oldPos = { x:e.x, y:e.y };
		
		if (editor.magnet)
		{
			var m = editor.figure.getMagnetPointEx(oldPos.x, oldPos.y);
			oldPos.x = m.point.x;
			oldPos.y = m.point.y;
		}
		
		drawingBegin(oldPos.clone());
		
		e.invalidateEditorLight();
	}
	
	override public function stageMouseMove(e:EditorMouseEvent)
	{
		super.stageMouseMove(e);
		
		var pos = { x:e.x, y:e.y };
		
		if (editor.magnet)
		{
			var m = editor.figure.getMagnetPointEx(pos.x, pos.y);
			if (m.found) magnetMark.show(m.point);
			else         magnetMark.hide();
			pos.x = m.point.x;
			pos.y = m.point.y;
		}
		else
		{
			magnetMark.hide();
		}
		
		if (oldPos == null) return;
		
		drawingMove(oldPos, pos.clone());
		oldPos = pos;
		
		e.invalidateEditorLight();
	}
	
	override public function stageMouseUp(e:EditorMouseEvent)
	{
		super.stageMouseUp(e);
		
		if (oldPos == null) return;
		
		magnetMark.hide();
		drawingEnd(oldPos);
		oldPos = null;
		undoQueue.commitTransaction();
		
		e.invalidateEditorShapes();
	}
	
	override public function draw(shapeSelections:Shape, itemSelections:Shape) 
	{
		super.draw(shapeSelections, itemSelections);
		
		#if profiler Profiler.measure("DrawEditorTool", "draw", function() { #end
		drawingUpdateSelections(shapeSelections.graphics);
		magnetMark.draw(shapeSelections);
		#if profiler }); #end
	}
	
	function drawingBegin(pos:Point) { }
	function drawingMove(oldPos:Point, newPos:Point) { }
	function drawingEnd(pos:Point) { }
	function drawingUpdateSelections(g:Graphics) { }
}
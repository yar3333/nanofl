package nanofl.ide.editor.tools;

import easeljs.geom.Rectangle;
import easeljs.display.Shape;
import nanofl.engine.geom.Edge;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.Polygon;
import nanofl.engine.geom.StrokeEdge;
import nanofl.ide.editor.EditorLayer;
import nanofl.ide.editor.MagnetMark;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.PropertiesObject;
import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.tools.EditorTool;
using nanofl.engine.geom.PointTools;
using nanofl.engine.DrawTools;
using stdlib.Lambda;

private enum MouseMode
{
	UNKNOW;
	TRANSLATE_SELECTED;
	TRANSLATE_VERTEX(originalPoint:Point, translatedPoint:Point);
	TRANSLATE_CURVE_CONTROL_POINT(edgeWithLayers:Array<{ edge:Edge, layerIndex:Int }>);
	SELECT_BY_RECTANGLE(from:Point, to:Point);
}

#if profiler @:build(Profiler.buildMarked()) #end
class SelectEditorTool extends EditorTool
{
	static var preventMovingDelay = 100;
	
	var startPos : Point;
	var oldPos : Point;
	var mouseMode = MouseMode.UNKNOW;
	var magnetMark = new MagnetMark();
	
	var preventMovingMouseDownMoment : Date;
	var preventMovingPos : Point;
	
	var accumDX : Float;
	var accumDY : Float;
	
	override function getStatusBarText() return
		   "Press the middle mouse button to move view."
		+ " Use wheel to zoom."
		+ " Double click on symbol to edit."
		+ " Ctrl+drag on line to break."
		+ " Drag center of line to move curve contol point."
		+ " Hold Ctrl key to magnet on.";
	
	override public function stageMouseDown(e:EditorMouseEvent)
	{
		preventMovingMouseDownMoment = Date.now();
		preventMovingPos = null;
		
		startPos = oldPos = { x:e.x, y:e.y };
		mouseMode = MouseMode.UNKNOW;
		
		if (editor.magnet)
		{
			var m = editor.figure.getEdgeAtPos(startPos);
			if (m != null)
			{
				var d = m.edge.getNearestPoint(startPos.x, startPos.y);
				if (d.t != 0 && d.t != 1)
				{
					var point = editor.figure.splitEdge(m.edge, d.t);
					if (point != null)
					{
						undoQueue.commitTransaction();
						undoQueue.beginTransaction({ figure:true });
						
						mouseMode = MouseMode.TRANSLATE_VERTEX(point, point.clone());
						
						e.invalidateEditorLight();
					}
				}
			}
		}
	}
	
	override public function stageMouseMove(e:EditorMouseEvent)
	{
		if (oldPos == null) return;
		
		if (Date.now().getTime() - preventMovingMouseDownMoment.getTime() < preventMovingDelay)
		{
			if (preventMovingPos == null) preventMovingPos = { x:e.x, y:e.y };
			return;
		}
		
		var pos = preventMovingPos != null ? preventMovingPos : { x:e.x, y:e.y };
		preventMovingPos = null;
		
		switch (mouseMode)
		{
			case MouseMode.UNKNOW:
				if (editor.hasSelected())
				{
					log("has selected: YES");
					if (editor.isSelectedAtPos(oldPos))
					{
						log("selected under cursor: YES");
						mouseMode = MouseMode.TRANSLATE_SELECTED;
					}
					else
					{
						log("selected under cursor: NO");
						var item = editor.getItemAtPos(oldPos);
						if (item != null)
						{
							editor.select(item);
							mouseMode = MouseMode.TRANSLATE_SELECTED;
							
						}
						else
						{
							mouseMode = MouseMode.SELECT_BY_RECTANGLE(oldPos, pos.clone());
						}
					}
				}
				else
				{
					log("has selected: NO");
					mouseMode = MouseMode.SELECT_BY_RECTANGLE(oldPos, pos.clone());
					
					for (layer in editor.getEditableLayers())
					{
						if (detectStartMoveItem(layer, oldPos)) break;
						if (detectStartMoveVertex(layer, oldPos)) break;
						if (detectStartMoveStrokEdgeControlPoint(layer, oldPos)) break;
						if (detectStartMovePolygonEdgeControlPoint(layer, oldPos)) break;
					}
				}
				
				if (mouseMode == MouseMode.TRANSLATE_SELECTED)
				{
					undoQueue.commitTransaction();
					undoQueue.beginTransaction({ figure:true, transformations:true });
					accumDX = pos.x - startPos.x;
					accumDY = pos.y - startPos.y;
					editor.translateSelected(accumDX, accumDY, true);
					if (editor.figure.hasSelected()) e.invalidateEditorShapes();
					else                             e.invalidateEditorLight();
				}
				
			case MouseMode.TRANSLATE_SELECTED:
				editor.translateSelected( -accumDX + pos.x - startPos.x, -accumDY + pos.y - startPos.y, true);
				accumDX = pos.x - startPos.x;
				accumDY = pos.y - startPos.y;
				if (editor.figure.hasSelected()) e.invalidateEditorShapes();
				else                             e.invalidateEditorLight();
				
			case MouseMode.TRANSLATE_VERTEX(originalPoint, translatedPoint):
				undoQueue.revertTransaction();
				
				if (editor.magnet)
				{
					var m = editor.figure.getMagnetPointEx(pos.x, pos.y, true);
					if (m.found) magnetMark.show(m.point);
					else         magnetMark.hide();
					pos.x = m.point.x;
					pos.y = m.point.y;
				}
				else
				{
					magnetMark.hide();
				}
				
				var dx = pos.x - originalPoint.x;
				var dy = pos.y - originalPoint.y;
				editor.figure.translateVertex(originalPoint, dx, dy);
				translatedPoint.x = originalPoint.x + dx;
				translatedPoint.y = originalPoint.y + dy;
				e.invalidateEditorShapes();
				
			case MouseMode.TRANSLATE_CURVE_CONTROL_POINT(edgeWithLayers):
				for (edgeWithLayer in edgeWithLayers)
				{
					edgeWithLayer.edge.x2 += pos.x - oldPos.x;
					edgeWithLayer.edge.y2 += pos.y - oldPos.y;
				}
				e.invalidateEditorShapes();
				
			case MouseMode.SELECT_BY_RECTANGLE(from, to):
				to.x = pos.x;
				to.y = pos.y;
				e.invalidateEditorLight();
		}
		
		oldPos = pos;
	}
	
	function detectStartMoveItem(layer:EditorLayer, pos:Point) : Bool
	{
		var item = layer.getItemAtPos(oldPos);
		if (item == null) return false;
		
		editor.select(item);
		mouseMode = MouseMode.TRANSLATE_SELECTED;
		
		var layerIndex = editor.getObjectLayerIndex(item);
		navigator.pathItem.setLayerIndex(layerIndex);
		
		return true;
	}
	
	function detectStartMoveVertex(layer:EditorLayer, pos:Point) : Bool
	{
		var p = layer.shape.element.getNearestVertex(pos);
		if (p == null || p.distMinusEdgeThickness > editor.getHitTestGap()) return false;
		
		undoQueue.commitTransaction();
		undoQueue.beginTransaction({ figure:true });					
		
		mouseMode = MouseMode.TRANSLATE_VERTEX(p.point, { x:p.point.x, y:p.point.y } );
		
		return true;
	}
	
	function detectStartMoveStrokEdgeControlPoint(layer:EditorLayer, pos:Point) : Bool
	{
		var edgeWithLayers = editor.figure.getSameEdgeWithLayers(layer.getStrokeEdgeAtPos(oldPos));
		if (edgeWithLayers.length == 0) return false;
		beginMoveEdgeControlPoint(edgeWithLayers);
		return true;
	}
	
	
	function detectStartMovePolygonEdgeControlPoint(layer:EditorLayer, pos:Point) : Bool
	{
		var edgeWithLayers = editor.figure.getSameEdgeWithLayers(layer.getPolygonEdgeAtPos(oldPos));
		if (edgeWithLayers.length == 0) return false;
		beginMoveEdgeControlPoint(edgeWithLayers);
		return true;
	}
	
	function beginMoveEdgeControlPoint(edgeWithLayers)
	{
		undoQueue.commitTransaction();
		undoQueue.beginTransaction({ figure:true });
		
		mouseMode = MouseMode.TRANSLATE_CURVE_CONTROL_POINT(edgeWithLayers);
	}
	
	override public function stageMouseUp(e:EditorMouseEvent)
	{
		super.stageMouseUp(e);
		
		if (oldPos == null) return;
		
		#if profiler Profiler.measure("SelectEditorTool", "stageMouseUp", function() { #end
		
		switch (mouseMode)
		{
			case MouseMode.UNKNOW:
				var objAndLayer = editor.getObjectAtPosEx(oldPos);
				if (objAndLayer != null) navigator.setLayerIndex(objAndLayer.layerIndex);
				
				if (e.shiftKey)
				{
					editor.selectWoUpdate(objAndLayer != null ? objAndLayer.obj : null, false);
				}
				else
				if (e.ctrlKey)
				{
					if (objAndLayer != null)
					{
						if (objAndLayer.obj.selected) editor.deselectWoUpdate(objAndLayer.obj);
						else                          editor.selectWoUpdate(objAndLayer.obj, false);
					}
				}
				else
				{
					editor.selectWoUpdate(objAndLayer != null ? objAndLayer.obj : null);
				}
				
			case MouseMode.TRANSLATE_VERTEX(originalPoint, translatedPoint):
				magnetMark.hide();
				editor.figure.combineSelf();
				commitTransaction();
				
			case MouseMode.TRANSLATE_CURVE_CONTROL_POINT(edgeWithLayers):
				for (edgeWithLayer in edgeWithLayers)
				{
					editor.figure.combineSelf();
				}
				commitTransaction();
				
			case MouseMode.TRANSLATE_SELECTED:
				editor.magnetSelectedToGuide();
				editor.figure.combineSelected();
				commitTransaction();
				
			case MouseMode.SELECT_BY_RECTANGLE(from, to):
				if (!e.ctrlKey && !e.shiftKey) editor.deselectAllWoUpdate();
				var rect = new Rectangle(Math.min(from.x, to.x), Math.min(from.y, to.y), Math.abs(to.x - from.x), Math.abs(to.y - from.y));
				for (obj in editor.getObjectsInRectangle(rect.x, rect.y, rect.width, rect.height))
				{
					obj.selected = true;
				}
				selectionChange();
				e.invalidateEditorLight();
		}
		
		mouseMode = MouseMode.UNKNOW;
		
		oldPos = null;
		
		#if profiler }); #end
		
		e.invalidateEditorShapes();
	}
	
	override public function stageDoubleClick(e:EditorMouseEvent) 
	{
		var edgeOrPolygon = editor.figure.getStrokeEdgeOrPolygonAtPos(e);
		if (edgeOrPolygon != null)
		{
			navigator.setLayerIndex(edgeOrPolygon.layerIndex);
			
			if (Std.isOfType(edgeOrPolygon.obj, Polygon))
			{
				var edges = (cast edgeOrPolygon.obj:Polygon).getEdges();
				for (edge in editor.activeShape.edges)
				{
					if (edges.exists(x -> x.equ(edge))) edge.selected = true;
				}
			}
			else
			{
				var lines = [ (cast edgeOrPolygon.obj:StrokeEdge) ];
				var i = 0; while (i < lines.length)
				{
					var edgeA = lines[i];
					for (edgeB in editor.activeShape.edges)
					{
						if (edgeB.x1 == edgeA.x1 && edgeB.y1 == edgeA.y1
						 || edgeB.x1 == edgeA.x3 && edgeB.y1 == edgeA.y3
						 || edgeB.x3 == edgeA.x1 && edgeB.y3 == edgeA.y1
						 || edgeB.x3 == edgeA.x3 && edgeB.y3 == edgeA.y3)
						{
							edgeB.selected = true;
							if (edgeB.indexIn(lines) < 0) lines.push(edgeB);
						}
					}
					i++;
				}
			}
			
			editor.update();
		}
		else
		{
			super.stageDoubleClick(e);			
		}
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject
	{
		var shapeSelected = editor.figure.hasSelected();
		
		if (shapeSelected && selectedItems.length == 0)
		{
			return PropertiesObject.SHAPE(editor.figure, newObjectParams, new ShapePropertiesOptions().disallowNoneStroke().disallowNoneFill());
		}
		
		if (selectedItems.length == 1 && !shapeSelected)
		{
			return selectedItems[0].getPropertiesObject(newObjectParams);
		}
		
		return PropertiesObject.NONE;
	}
	
	override function draw(shapeSelections:Shape, itemSelections:Shape)
	{
		super.draw(shapeSelections, itemSelections);
		editor.figure.updateShapes();
		for (item in editor.getSelectedItems()) item.update();
		magnetMark.draw(shapeSelections);
		
		switch (mouseMode)
		{
			case MouseMode.SELECT_BY_RECTANGLE(from, to):
				var pt0 = shapeSelections.localToGlobal(from.x, from.y);
				pt0 = shapeSelections.globalToLocal(Math.round(pt0.x) + 0.5, Math.round(pt0.y) + 0.5);
				
				var pt1 = shapeSelections.localToGlobal(to.x, to.y);
				pt1 = shapeSelections.globalToLocal(Math.round(pt1.x) + 0.5, Math.round(pt1.y) + 0.5);
				
				var dashPt0 = shapeSelections.globalToLocal(0, 0);
				var dashPt1 = shapeSelections.globalToLocal(2, 2);
				var dashLen = (Math.abs(dashPt1.x - dashPt0.x) + Math.abs(dashPt1.y - dashPt0.y)) / 2;
				shapeSelections.graphics
					.setStrokeStyle(1.0, null, null, null, true)
					.drawDashedRect(pt0.x, pt0.y, pt1.x, pt1.y, "#000000", "#FFFFFF", dashLen);
				
			case _:
		}
	}
	
	override public function selectionChange()
	{
		super.selectionChange();
		
		undoQueue.commitTransaction();
		undoQueue.beginTransaction({});
	}
	
	function commitTransaction()
	{
		undoQueue.commitTransaction();
	}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
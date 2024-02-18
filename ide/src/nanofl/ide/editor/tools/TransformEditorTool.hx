package nanofl.ide.editor.tools;

import nanofl.engine.libraryitems.MeshItem;
import easeljs.display.Container;
import easeljs.display.DisplayObject;
import easeljs.display.Shape;
import nanofl.engine.geom.Bounds;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.Point;
import nanofl.engine.geom.PointTools;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.elements.EditorElementInstance;
import nanofl.ide.editor.tools.SelectEditorTool;
import nanofl.ide.editor.transformationshapes.TransformationBox;
import stdlib.Std;

class TransformEditorTool extends SelectEditorTool
{
	var transformationBox : TransformationBox;
	
	override function getStatusBarText() return
		   "Hold Shift key during rotation to rotate on 30/45/90 deg."
		+ " Hold Shift key during resizing to scaling proportionally.";
	
	override public function isShowRegPoints() return false;
	
	override function init() 
	{
		super.init();
		undoQueue.beginTransaction({ figure:true, transformations:true });
	}
	
	override function createControls(controls:Container) 
	{
		super.createControls(controls);
		
		controls.addChild(transformationBox = new TransformationBox());
		transformationBox.rotateCursorUrl = "rotate.cur";
		
		transformationBox.resize.bind(function(_, e)
		{
			var selectedItems = editor.getSelectedItems();
			var shapeSelected = editor.figure.hasSelected();
			
			if (selectedItems.length == 1 && !shapeSelected)
			{
				var item = selectedItems[0];

                var oldScaleX = item.dispObj.scaleX;
                var oldScaleY = item.dispObj.scaleY;
                item.dispObj.scaleX = 1;
                item.dispObj.scaleY = 1;
                var scale = localToLocalVector(transformationBox, e.kx, e.ky, item.dispObj);
                item.dispObj.scaleX = oldScaleX * scale.x;
                item.dispObj.scaleY = oldScaleY * scale.y;
                
                var bounds = item.getBounds();
                var v = localToLocalVector(item.dispObj, bounds.x, bounds.y, transformationBox.parent);
                item.dispObj.x = transformationBox.x - v.x;
                item.dispObj.y = transformationBox.y - v.y;
                
                item.originalElement.matrix.setMatrix(item.dispObj.getMatrix());
			}
			else
			{
				var angle = transformationBox.rotation * Math.PI / 180;
				
				var m = new Matrix()
					.translate(-e.regX, -e.regY)
					.rotate(-angle)
					.scale(e.kx, e.ky)
					.rotate( angle)
					.translate( e.regX,  e.regY);
					
				for (item in selectedItems)
				{
					item.originalElement.matrix.prependMatrix(m);
				}
				
				editor.figure.transformSelected(m);
			}
			
			editor.update();
		});
		
		transformationBox.rotate.bind(function(t, e)
		{
			var m = new Matrix()
					.translate(-e.regX, -e.regY)
					.rotate(e.angle)
					.translate( e.regX,  e.regY);
			
			for (item in editor.getSelectedItems())
			{
				item.originalElement.matrix.prependMatrix(m);
			}
			
			editor.figure.transformSelected(m);
			
			editor.update();
		});
		
		transformationBox.changeRegPoint.bind(function(t, _)
		{
			var selectedItems = editor.getSelectedItems();
			var shapeSelected = editor.figure.hasSelected();
			
			if (selectedItems.length == 1 && !shapeSelected)
			{
				var item = selectedItems[0];
				var regPoint = transformationBox.localToLocal(transformationBox.regPointX, transformationBox.regPointY, item.dispObj);
				item.currentElement.regX = regPoint.x;
				item.currentElement.regY = regPoint.y;
				item.update();
			}
		});

		transformationBox.barMove.bind(function(t, e)
        {
            var selectedItems = editor.getSelectedItems();
            var shapeSelected = editor.figure.hasSelected();
            
            if (selectedItems.length == 1 && !shapeSelected)
            {
                var item = selectedItems[0];
                if (Std.is(item, EditorElementInstance))
                {
                    switch (e.code)
                    {
                        case "l", "r":
                            (cast item:EditorElementInstance).element.meshParams.rotationX = (0.5 - e.value) * 360;
                            transformationBox.leftBarPosition =
                            transformationBox.rightBarPosition = e.value;
                            
                        case "t", "b":
                            (cast item:EditorElementInstance).element.meshParams.rotationY = (e.value - 0.5) * 360;
                            transformationBox.topBarPosition =
                            transformationBox.bottomBarPosition = e.value;
                            
                        case _:
                    }
                    item.update();
                }
            }
        });
		
		selectionChange();
	}
	
	override function selectionChange()
	{
		super.selectionChange();
		updateTransformationBox();
		undoQueue.beginTransaction({ figure:true, transformations:true });
	}
	
	function updateTransformationBox()
	{
		var selectedItems = editor.getSelectedItems();
		var figureSelected = editor.figure.hasSelected();
		
		if (selectedItems.length > 0 || figureSelected)
		{
			transformationBox.visible = true;
			transformationBox.enableBars = false;
			
			if (selectedItems.length == 1 && !figureSelected)
			{
				var item = selectedItems[0];
				
				transformationBox.rotation = item.dispObj.rotation;
				transformationBox.skewX = item.dispObj.skewX;
				transformationBox.skewY = item.dispObj.skewY;
				transformationBox.scaleX = stdlib.Std.sign(item.dispObj.scaleX);
				transformationBox.scaleY = stdlib.Std.sign(item.dispObj.scaleY);
				
				var bounds = item.getBounds();
				var pos = item.dispObj.localToLocal(bounds.x, bounds.y, transformationBox.parent);
				transformationBox.x = pos.x;
				transformationBox.y = pos.y;
				transformationBox.width  = PointTools.getLength(localToLocalVector(item.dispObj, bounds.width,  0, transformationBox));
				transformationBox.height = PointTools.getLength(localToLocalVector(item.dispObj, 0, bounds.height, transformationBox));
				
				var regPoint = item.dispObj.localToLocal(item.currentElement.regX, item.currentElement.regY, transformationBox);
				transformationBox.regPointX = regPoint.x;
				transformationBox.regPointY = regPoint.y;

				if (Std.is(item, EditorElementInstance) && Std.isOfType((cast item:EditorElementInstance).element.symbol, MeshItem))
				{
					transformationBox.enableBars = true;
					
					var kx = 0.5 + normalizeAngleDeg((cast item:EditorElementInstance).element.meshParams.rotationY) / 360;
					transformationBox.topBarPosition =
					transformationBox.bottomBarPosition = kx;
					
					var ky = 0.5 - normalizeAngleDeg((cast item:EditorElementInstance).element.meshParams.rotationX) / 360;
					transformationBox.leftBarPosition =
					transformationBox.rightBarPosition = ky;
				}
			}
			else
			{
				transformationBox.rotation = 0;
				transformationBox.skewX = 0;
				transformationBox.skewY = 0;
				transformationBox.scaleX = 1;
				transformationBox.scaleY = 1;
				
				var bounds = { minX:1.0e10, minY:1.0e10, maxX:-1.0e10, maxY:-1.0e10 };
				
				for (item in selectedItems)
				{
					var b = item.getBounds();
					extendBounds(bounds, b.x, b.y, item.dispObj, transformationBox.parent);
					extendBounds(bounds, b.x + b.width, b.y, item.dispObj, transformationBox.parent);
					extendBounds(bounds, b.x + b.width, b.y + b.height, item.dispObj, transformationBox.parent);
					extendBounds(bounds, b.x, b.y + b.height, item.dispObj, transformationBox.parent);
				}
				
				editor.figure.getSelectedBounds(bounds);
				
				transformationBox.x = bounds.minX;
				transformationBox.y = bounds.minY;
				transformationBox.width = bounds.maxX - bounds.minX;
				transformationBox.height = bounds.maxY - bounds.minY;
			}
			
			updateDefaultRegPoint();
		}
		else
		{
			transformationBox.visible = false;
		}
	}
	
	function updateDefaultRegPoint()
	{
		var selectedItems = editor.getSelectedItems();
		if (selectedItems.length == 1)
		{
			editor.updateTransformations();
			var pt = selectedItems[0].dispObj.localToLocal(0, 0, transformationBox);
			transformationBox.defaultRegPointX = pt.x;
			transformationBox.defaultRegPointY = pt.y;
		}
		else
		{
			transformationBox.defaultRegPointX = transformationBox.width / 2;
			transformationBox.defaultRegPointY = transformationBox.height / 2;
		}
	}
	
	function extendBounds(bounds:Bounds, x:Float, y:Float, src:DisplayObject, dest:DisplayObject)
	{
		var pt = src.localToLocal(x, y, dest);
		bounds.minX = Math.min(bounds.minX, pt.x);
		bounds.minY = Math.min(bounds.minY, pt.y);
		bounds.maxX = Math.max(bounds.maxX, pt.x);
		bounds.maxY = Math.max(bounds.maxY, pt.y);
	}
	
	function localToLocalVector(src:DisplayObject, x:Float, y:Float, dst:DisplayObject) : Point
	{
		var pt0 = src.localToLocal(0, 0, dst);
		var pt1 = src.localToLocal(x, y, dst);
		return { x:pt1.x - pt0.x, y:pt1.y - pt0.y };
	}
	
	override function draw(shapeSelections:Shape, itemSelections:Shape) 
	{
		super.draw(shapeSelections, itemSelections);
		updateDefaultRegPoint();
	}
	
	override function onSelectedTranslate(dx:Float, dy:Float)
	{
		super.onSelectedTranslate(dx, dy);
		
		transformationBox.x += dx;
		transformationBox.y += dy;
	}
	
	override function commitTransaction()
	{
		super.commitTransaction();
		undoQueue.beginTransaction({ figure:true, transformations:true });
	}
	
	override public function stageMouseMove(e:EditorMouseEvent) 
	{
		super.stageMouseMove(e);
		transformationBox.magnet = e.ctrlKey || e.shiftKey;
	}
	
	override public function itemChanged(item:EditorElement) 
	{
		super.itemChanged(item);
		
		if (item.selected)
		{
			updateTransformationBox();
		}
	}
	
	override public function figureChanged()
	{
		super.figureChanged();
		
		if (editor.figure.hasSelected())
		{
			updateTransformationBox();
		}
	}
	
	function normalizeAngleDeg(a:Float)
	{
		var sign = Std.sign(a);
		a = Math.abs(a);
		a -= Std.int(a / 360) * 360;
		if (a > 180.0) a -= 360;
		return a * sign;
	}
	
	function traceDO(dispObj:Container)
	{
		trace("scaleX=" + dispObj.scaleX + ", scaleY=" + dispObj.scaleY + ", skewX=" + dispObj.skewX + ", skewY=" + dispObj.skewY);
	}
}
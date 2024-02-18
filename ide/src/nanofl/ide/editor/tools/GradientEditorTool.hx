package nanofl.ide.editor.tools;

import easeljs.display.Container;
import nanofl.engine.geom.Matrix;
import nanofl.engine.ISelectable;
import nanofl.engine.libraryitems.BitmapItem;
import nanofl.ide.editor.FigureElement;
import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.PropertiesObject;
import nanofl.ide.editor.tools.EditorTool;
import nanofl.ide.editor.transformationshapes.TransformationBox;
import nanofl.ide.editor.transformationshapes.TransformationCircle;
import nanofl.ide.editor.transformationshapes.TransformationVector;
using nanofl.ide.editor.FigureElementTools;

class GradientEditorTool extends EditorTool
{
	var transformationVector : TransformationVector;
	var transformationCircle : TransformationCircle;
	var transformationBox : TransformationBox;
	
	override function getStatusBarText() return
		   "Hold Shift key during rotation to rotate on 30/45/90 deg."
		+ " Hold Shift key during resizing to scaling proportionally.";
	
	override public function isShowRegPoints() return false;
	
	override function init() 
	{
		super.init();
		
		var figureElements = editor.figure.getSelectedElements();
		editor.deselectAllWoUpdate();
		for (figureElement in figureElements) figureElement.select();
		
		undoQueue.beginTransaction({ figure:true });
	}
	
	override function createControls(controls:Container) 
	{
		super.createControls(controls);
		
		// TransformationVector
		{
			controls.addChild(transformationVector = new TransformationVector());
			
			transformationVector.change.bind(function(_, e)
			{
				for (figureElement in editor.figure.getSelectedElements())
				{
					figureElement.processLinearGradient(function(gradient)
					{
						gradient.x0 = transformationVector.pt1.x;
						gradient.y0 = transformationVector.pt1.y;
						gradient.x1 = transformationVector.pt2.x;
						gradient.y1 = transformationVector.pt2.y;
					});
				}
				editor.figure.updateShapes();
			});
		}
		
		// TransformationCircle
		{
			controls.addChild(transformationCircle = new TransformationCircle());
			
			transformationCircle.change.bind(function(_, e)
			{
				for (figureElement in editor.figure.getSelectedElements())
				{
					figureElement.processRadialGradient(function(gradient)
					{
						gradient.cx = transformationCircle.circleCenter.x;
						gradient.cy = transformationCircle.circleCenter.y;
						gradient.r = transformationCircle.circleRadius;
						gradient.fx = transformationCircle.circleFocus.x;
						gradient.fy = transformationCircle.circleFocus.y;
					});
				}
				editor.figure.updateShapes();
			});
		}
		
		// TransformationBox
		{
			controls.addChild(transformationBox = new TransformationBox());
			transformationBox.rotateCursorUrl = "rotate.cur";
			transformationBox.enableRegPoint = false;
			transformationBox.enableTranslatePoint = true;
			
			transformationBox.resize.bind(function(_, e)
			{
				for (figureElement in editor.figure.getSelectedElements())
				{
					figureElement.processBitmapGradient(function(gradient)
					{
						transformationBox.width  /= e.kx;
						transformationBox.height /= e.ky;
						transformationBox.scaleX *= e.kx;
						transformationBox.scaleY *= e.ky;
						gradient.matrix = Matrix.fromNative(transformationBox.getMatrix());
					});
				}
				editor.figure.updateShapes();
			});
			
			transformationBox.rotate.bind(function(t, e)
			{
				for (figureElement in editor.figure.getSelectedElements())
				{
					figureElement.processBitmapGradient(function(gradient)
					{
						gradient.matrix.prependTransform(-e.regX, -e.regY);
						gradient.matrix.prependTransform(0, 0, 1, 1, e.angle * 180 / Math.PI);
						gradient.matrix.prependTransform( e.regX,  e.regY);
					});
				}
				editor.figure.updateShapes();
			});
			
			transformationBox.move.bind(function(t, e)
			{
				for (figureElement in editor.figure.getSelectedElements())
				{
					figureElement.processBitmapGradient(function(gradient)
					{
						gradient.matrix = Matrix.fromNative(transformationBox.getMatrix());
					});
				}
				editor.figure.updateShapes();
			});
		}
		
		selectionChange();
	}
	
	override function selectionChange()
	{
		super.selectionChange();
		updateTransformationBox();
		undoQueue.commitTransaction();
		undoQueue.beginTransaction({ figure:true });
	}
	
	function updateTransformationBox()
	{
		transformationVector.visible = false;
		transformationCircle.visible = false;
		transformationBox.visible = false;
		
		var figureElements = editor.figure.getSelectedElements();
		if (figureElements.length > 0)
		{
			figureElements[0].processLinearGradient(function(gradient)
			{
				transformationVector.visible = true;
				transformationVector.pt1.x = gradient.x0;
				transformationVector.pt1.y = gradient.y0;
				transformationVector.pt2.x = gradient.x1;
				transformationVector.pt2.y = gradient.y1;
			});
			
			figureElements[0].processRadialGradient(function(gradient)
			{
				transformationCircle.visible = true;
				transformationCircle.circleCenter.x = gradient.cx;
				transformationCircle.circleCenter.y = gradient.cy;
				transformationCircle.circleRadius = gradient.r;
				transformationCircle.circleFocus.x = gradient.fx;
				transformationCircle.circleFocus.y = gradient.fy;
			});
			
			figureElements[0].processBitmapGradient(function(gradient)
			{
				transformationBox.visible = true;
				var t = gradient.matrix.decompose();
				transformationBox.set(t);
				var bitmap = cast(library.getItem(gradient.bitmapPath), BitmapItem);
				transformationBox.width = bitmap.image.width;
				transformationBox.height = bitmap.image.height;
				
			});
		}
		
		editor.update();
	}
	
	override public function stageClick(e:EditorMouseEvent) 
	{
		super.stageClick(e);
		
		editor.figure.deselectAll();
		
		for (layer in editor.getEditableLayers())
		{
			var r : ISelectable = layer.getStrokeEdgeAtPos(e);
			if (r == null) r = layer.getPolygonAtPos(e);
			if (r != null)
			{
				r.selected = true;
				break;
			}
		}
		
		selectionChange();
	}
	
	override public function stageMouseMove(e:EditorMouseEvent) 
	{
		super.stageMouseMove(e);
		
		transformationVector.magnet =
		transformationCircle.magnet =
		transformationBox.magnet = e.ctrlKey || e.shiftKey;
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject 
	{
		var figureElements = editor.figure.getSelectedElements();
		if (figureElements.length == 0) return PropertiesObject.NONE;
		
		var options = new ShapePropertiesOptions();
		
		for (figureElement in figureElements)
		{
			switch (figureElement)
			{
				case FigureElement.STROKE_EDGE(e):	options.disallowNoneStroke().showStrokePane();
				case FigureElement.POLYGON(e): 		options.disallowNoneFill().showFillPane();
			}
		}
		
		return PropertiesObject.SHAPE(editor.figure, newObjectParams, options);
	}
}
package nanofl.ide.editor.tools;

import easeljs.display.Container;
import easeljs.display.Shape;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.elements.EditorElementText;
import nanofl.ide.PropertiesObject;
import nanofl.engine.elements.TextElement;
import nanofl.engine.geom.Point;
import nanofl.ide.editor.tools.EditorTool;
import nanofl.ide.editor.tools.SelectEditorTool;
import nanofl.ide.editor.transformationshapes.TransformationBox;
using nanofl.engine.geom.PointTools;

class TextEditorTool extends EditorTool
{
	var textItem : EditorElementText;
	var transformationBox : TransformationBox;
	
	override function getStatusBarText() return
		   "Click to add a text field."
		+ " Double click on text field to edit.";
	
	override function init() 
	{
		super.init();
		editor.deselectAllWoUpdate();
	}
	
	override function createControls(controls:Container) 
	{
		super.createControls(controls);
		
		controls.addChild(transformationBox = new TransformationBox());
		transformationBox.enableRegPoint = false;
		transformationBox.enableRotatePoint = false;
		transformationBox.enableTranslatePoint = true;
		transformationBox.translatePointPositionX = "50%";
		transformationBox.translatePointPositionY = "-10";
		transformationBox.rotateCursorUrl = "rotate.cur";
		
		transformationBox.resize.bind(function(_, e)
		{
			textItem.setPosAndSize(transformationBox);
			view.properties.update();
		});
		
		transformationBox.move.bind(function(_, e)
		{
			textItem.element.translate(e.dx, e.dy);
			editor.updateTransformations();
			view.properties.update();
		});
	}
	
	override public function beginEditing(item:EditorElement)
	{
		if (item == null || !Std.isOfType(item.originalElement, TextElement)) return;
		
		endEditing();
		
		textItem = cast item;
		textItem.beginEditing();
		
		undoQueue.beginTransaction({ element:textItem.originalElement });
	}
	
	override public function endEditing()
	{
		if (textItem == null) return;
		
		editor.deselectAll();
		textItem.endEditing();
		textItem = null;
		undoQueue.commitTransaction();
	}
	
	override public function isShowCenterCross() return textItem == null;
	
	override public function getCursor() return "text";
	
	override public function stageClick(e:EditorMouseEvent)
	{
		super.stageClick(e);
		
		if (!isActiveLayerEditable()) return;
		
		if (textItem != null)
		{
			endEditing();
		}
		else
		{
			undoQueue.beginTransaction({ elements:true });
			var text = new TextElement(null, 30, 16.8, false, false, [], newObjectParams.textFormat);
			text.translate(e.x, e.y);
			beginEditing(editor.activeLayer.addElement(text));
		}
		
		e.invalidateEditorLight();
	}
	
	override public function itemMouseDown(e:EditorMouseEvent, item:EditorElement)
	{
		super.itemMouseDown(e, item);
		
		if (!isActiveLayerEditable()) return;
		
		if (item != textItem)
		{
			endEditing();
			
			if (Std.isOfType(item.originalElement, TextElement))
			{
				beginEditing(item);
				e.invalidateEditorLight();
			}
			else
			{
				editor.switchTool(SelectEditorTool);
			}
		}
	}
	
	override public function itemChanged(item:EditorElement) 
	{
		super.itemChanged(item);
		
		if (item == textItem)
		{
			updateTransformationBox();
			view.properties.update();
		}
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>) : PropertiesObject
	{
		return PropertiesObject.TEXT(textItem, newObjectParams);
	}
	
	override public function draw(shapeSelections:Shape, itemSelections:Shape) 
	{
		super.draw(shapeSelections, itemSelections);
		updateTransformationBox();
	}
	
	function updateTransformationBox()
	{
		if (textItem != null)
		{
			transformationBox.visible = true;
			
			transformationBox.x = textItem.dispObj.x;
			transformationBox.y = textItem.dispObj.y;
			transformationBox.scaleX = textItem.dispObj.scaleX;
			transformationBox.scaleY = textItem.dispObj.scaleY;
			transformationBox.rotation = textItem.dispObj.rotation;
			transformationBox.skewX = textItem.dispObj.skewX;
			transformationBox.skewY = textItem.dispObj.skewY;
			
			var minSize = textItem.getMinSize();
			
			transformationBox.width = PointTools.roundGap(Math.max(textItem.width, minSize.width) / textItem.dispObj.scaleX);
			transformationBox.height = PointTools.roundGap(Math.max(textItem.height, minSize.height) / textItem.dispObj.scaleY);
			
			transformationBox.minWidth = PointTools.roundGap(minSize.width / textItem.dispObj.scaleX);
			transformationBox.minHeight = PointTools.roundGap(minSize.height / textItem.dispObj.scaleY);
		}
		else
		{
			transformationBox.visible = false;
		}
	}
}
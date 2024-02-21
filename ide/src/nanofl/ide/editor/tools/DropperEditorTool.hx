package nanofl.ide.editor.tools;

import nanofl.ide.editor.ShapePropertiesOptions;
import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.PropertiesObject;
import nanofl.engine.ColorTools;
import nanofl.engine.geom.Point;
using nanofl.engine.geom.PointTools;

class DropperEditorTool extends EditorTool
{
	var stroke = false;
	var fill = false;
	
	override function getStatusBarText() return
		   "Left click to pick into stroke color."
		+ " Right click to pick into fill color.";
	
	override public function allowContextMenu() return false;
	
	override function init() 
	{
		super.init();
		editor.deselectAllWoUpdate();
	}
	
	override public function stageMouseDown(e:EditorMouseEvent)
	{
		stroke = true;
		updateColors(e);
	}
	
	override public function stageRightMouseDown(e:EditorMouseEvent)
	{
		fill = true;
		updateColors(e);
	}
	
	override public function stageMouseMove(e:EditorMouseEvent)
	{
		updateColors(e);
	}
	
	override public function stageMouseUp(e:EditorMouseEvent)
	{
		stroke = false;
	}
	
	override public function stageRightMouseUp(e:EditorMouseEvent)
	{
		fill = false;
	}
	
	override public function getPropertiesObject(selectedItems:Array<EditorElement>):PropertiesObject 
	{
		return PropertiesObject.SHAPE(editor.figure, newObjectParams, new ShapePropertiesOptions().showStrokePane().showFillPane());
	}
	
	function updateColors(pos:Point)
	{
		if (stroke || fill)
		{
			pos = editor.container.localToGlobal(pos.x, pos.y);
			var imageData = editor.container.stage.canvas.getContext2d().getImageData(pos.x, pos.y, 1, 1);
			var data = imageData.data;
			var color = ColorTools.rgbaToString({ r:data[0], g:data[1], b:data[2], a:data[3]/255 });
			if (stroke) newObjectParams.setStrokeParams({ color:color });
			if (fill)   newObjectParams.setFillParams({ color:color });
			view.properties.update();
		}
	}
}
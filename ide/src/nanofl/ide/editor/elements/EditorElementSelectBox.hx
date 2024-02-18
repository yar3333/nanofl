package nanofl.ide.editor.elements;

import easeljs.events.MouseEvent;
import nanofl.ide.editor.EditorMouseEvent;
import nanofl.ide.editor.elements.EditorElement;
using nanofl.engine.geom.PointTools;

abstract class EditorElementSelectBox extends EditorElement
{
	override public function updateTransformations() 
	{
		super.updateTransformations();
		
		var pt0 = metaDispObj.localToGlobal(0, 0);
		var pt1 = metaDispObj.localToGlobal(1, 0);
		var descale = 1 / pt0.getDistP(pt1);
		
		var bounds = getBounds();
		
		emptyClipMark.visible = false;
		emptyClipMarkSelected.visible = false;
		selectionBoxShape.graphics.clear();
		
		if (bounds.width == 0 || bounds.height == 0)
		{
			emptyClipMark.visible = true;
			emptyClipMark.scaleX = emptyClipMark.scaleY = descale;
			if (selected)
			{
				emptyClipMarkSelected.visible = true;
				emptyClipMarkSelected.scaleX = emptyClipMarkSelected.scaleY = descale;
			}
		}
		else
		{
			if (selected)
			{
				selectionBoxShape.graphics
					.beginStroke("#A7D1FC")
					.setStrokeStyle(2, null, null, null, true)
					.drawRect(bounds.x, bounds.y, bounds.width, bounds.height)
					.endStroke();
			}
		}
		
		regPointMark.visible = false;
		if (selected && editor.tool != null && editor.tool.isShowRegPoints() && !Std.isOfType(this, EditorElementText))
		{
			regPointMark.visible = true;
			regPointMark.scaleX = regPointMark.scaleY = descale;
		}
	}
	
	override function onClick(e:MouseEvent) 
	{
		e.stopPropagation();
	}
	
	override function onMouseDown(e:MouseEvent) 
	{
		var ee = new EditorMouseEvent(e, metaDispObj.parent);
		editor.tool.itemMouseDown(ee, this);
		ee.updateInvalidated(editor, view.movie.timeline, view.library);
	}
	
	override function onMouseUp(e:MouseEvent) 
	{
		var ee = new EditorMouseEvent(e, metaDispObj.parent);
		editor.tool.itemPressUp(ee);
		ee.updateInvalidated(editor, view.movie.timeline, view.library);
	}
	
	override function onDoubleClick(e:MouseEvent) 
	{
		e.stopPropagation();
		var ee = new EditorMouseEvent(e, metaDispObj.parent);
		onDoubleClickInner(ee);
		ee.updateInvalidated(editor, view.movie.timeline, view.library);
	}
	
	function onDoubleClickInner(e:EditorMouseEvent) {}
	
	static function log(v:Dynamic, ?infos:haxe.PosInfos)
	{
		//haxe.Log.trace(Reflect.isFunction(v) ? v() : v, infos);
	}
}
package components.nanofl.properties.positionandsize;

import nanofl.ide.editor.elements.EditorElement;
import nanofl.ide.editor.Figure;
import nanofl.ide.PropertiesObject;
import nanofl.engine.geom.Matrix;

#if profiler @:build(Profiler.buildMarked()) #end
class Code extends components.nanofl.properties.base.Code
{
	@:profile
	function updateInner()
	{
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):	    updateElement(item);
			case PropertiesObject.TEXT(item, _):		updateElement(item);
			case PropertiesObject.GROUP(items):			// TODO: updateElement(item);
			case PropertiesObject.SHAPE(figure, _, _):	updateShape(figure);
			case _:	hide();
		};
	}
	
	function updateElement(item:EditorElement)
	{
		if (item != null)
		{
			show();
			template().rotationContainer.show();
			
			template().x.val(roundFloat100(item.originalElement.matrix.tx));
			template().y.val(roundFloat100(item.originalElement.matrix.ty));
			
			template().w.val(Std.string(roundFloat100(item.width)));
			template().h.val(Std.string(roundFloat100(item.height)));
			
			var props = item.originalElement.matrix.decompose();
			var r : Float = null;
			if (props.rotation != 0.0) r = props.rotation;
			else
			if (Math.abs(props.skewX - props.skewY) < 1e-5) r = (props.skewX + props.skewY) / 2;
			template().r.val(r != null ? Std.string(roundFloat100(r)) : "");
		}
		else
		{
			hide();
			template().rotationContainer.hide();
		}
	}
	
	function updateShape(figure:Figure)
	{
		if (figure.hasSelected())
		{
			show();
			template().rotationContainer.hide();
			
			var bounds = figure.getSelectedBounds();
			
			template().x.val(roundFloat100(bounds.minX));
			template().y.val(roundFloat100(bounds.minY));
			
			template().w.val(roundFloat100(bounds.maxX - bounds.minX));
			template().h.val(roundFloat100(bounds.maxY - bounds.minY));
		}
		else
		{
			hide();
			template().rotationContainer.hide();
		}
	}
	
	function x_change(e) parseFloatEx(template().x.val(), changePos.bind(_, null));
	function y_change(e) parseFloatEx(template().y.val(), changePos.bind(null, _));
	
	function w_change(e) parseFloatEx(template().w.val(), changeSize.bind(_, null));
	function h_change(e) parseFloatEx(template().h.val(), changeSize.bind(null, _));
	
	function r_change(e) parseFloatEx(template().r.val(), changeRotation.bind(_));
	
	function changePos(x:Float, y:Float)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):   changeItemPos(item, x, y);
			case PropertiesObject.GROUP(items):		// TODO: changeItemPos(item, x, y);
			case PropertiesObject.TEXT(item, _):	changeItemPos(item, x, y);
			case PropertiesObject.SHAPE(figure, _, _):
				undoQueue.beginTransaction({ figure:true });
				
				var bounds = figure.getSelectedBounds();
				figure.translateSelected(x != null ? x - bounds.minX :0 , y != null ? y - bounds.minY : 0);
				
				fireChangeEvent();
				
			case _:
		}
		
	}
	
	function changeSize(width:Float, height:Float)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):   changeItemSize(item, width, height);
			case PropertiesObject.GROUP(items):		//TODO: changeItemSize(item, width, height);
			case PropertiesObject.TEXT(item, _):	changeItemSize(item, width, height);
			case PropertiesObject.SHAPE(figure, _, _):
				undoQueue.beginTransaction({ figure:true });
				
				var bounds = figure.getSelectedBounds();
				var m = new Matrix();
				m.translate(-bounds.minX, -bounds.minY);
				if (width  != null) m.scale(width / (bounds.maxX - bounds.minX), 1);
				if (height != null) m.scale(1, height / (bounds.maxY - bounds.minY));
				m.translate(bounds.minX, bounds.minY);
				figure.transformSelected(m);
				
				fireChangeEvent();
				
			case _:
		}
	}
	
	function changeRotation(rotation:Float)
	{
		if (freeze) return;
		
		switch (obj)
		{
			case PropertiesObject.INSTANCE(item):   changeItemRotation(item, rotation);
			case PropertiesObject.GROUP(items):		// TODO: changeItemRotation(item, rotation);
			case PropertiesObject.TEXT(item, _):	changeItemRotation(item, rotation);
			case _:
		}
	}
	
	function changeItemPos(item:EditorElement, x:Float, y:Float)
	{
		undoQueue.beginTransaction({ transformations:true });
		
		if (x != null) item.originalElement.matrix.tx = x;
		if (y != null) item.originalElement.matrix.ty = y;
		
		fireChangeEvent();
	}
	
	function changeItemSize(item:EditorElement, width:Float, height:Float)
	{
		undoQueue.beginTransaction({ transformations:true });
		
		if (width != null) item.width = width; 
		if (height != null) item.height = height; 
		
		fireChangeEvent();
	}
	
	function changeItemRotation(item:EditorElement, rotation:Float)
	{
		if (rotation != null)
		{
			undoQueue.beginTransaction({ transformations:true });
			
			var props = item.originalElement.matrix.decompose();
			props.skewX = 0;
			props.skewY = 0;
			props.rotation = rotation;
			item.originalElement.matrix.setTransform
			(
				props.x, props.y,
				props.scaleX, props.scaleY,
				props.rotation, props.skewX, props.skewY
			);
			
			fireChangeEvent();
		}
	}
}
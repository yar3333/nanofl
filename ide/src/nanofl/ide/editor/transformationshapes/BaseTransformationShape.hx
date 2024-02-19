package nanofl.ide.editor.transformationshapes;

import easeljs.display.Container;
import easeljs.display.Graphics;
import easeljs.events.MouseEvent;
import easeljs.geom.Point;
import easeljs.display.Shape;
import nanofl.engine.geom.Matrix;

class BaseTransformationShape extends Container
{
	final BOX_SIZE : Float;
	final RHOMBUS_T : Float;
	final RHOMBUS_K : Float;
	
	var lines : Shape;
	var needUpdate : Bool;
	
	public var magnet : Bool;
	
	public function new()
	{
		super();

        BOX_SIZE = 4;
        RHOMBUS_T = 0.7;
        RHOMBUS_K = 0.7;

        needUpdate = true;
        magnet = false;

		addChild(lines = new Shape());
	}
	
	function createDot(handlers:{ ?mouseDown:MouseEvent->Shape->Void, ?mouseMove:MouseEvent->Shape->Void, ?mouseUp:MouseEvent->Shape->Void, ?mouseClick:MouseEvent->Shape->Void, ?mouseDoubleClick:MouseEvent->Shape->Void }) : Shape
	{
		var box = new Shape();
		
		var startApsectRatio : Float = null;
		var pressed = false;
		var mouseDelta = new Point();
		
		if (handlers.mouseDown != null)
		{
			box.addMousedownEventListener(function(e)
			{
				e.stopPropagation();
				pressed = true;
				handlers.mouseDown(e, box);
				if (needUpdate) stage.update();
			});
			
			box.addPressmoveEventListener(function(e:MouseEvent)
			{
				if (!pressed) return;
				e.stopPropagation();
				if (handlers.mouseMove != null) handlers.mouseMove(e, box);
				if (needUpdate) stage.update();
			});
			
			box.addPressupEventListener(function(e:MouseEvent)
			{
				if (!pressed) return;
				e.stopPropagation();
				if (handlers.mouseUp != null) handlers.mouseUp(e, box);
				pressed = false;
				if (needUpdate) stage.update();
			});
			
			box.addClickEventListener(function(e:MouseEvent)
			{
				e.stopPropagation();
				if (handlers.mouseClick != null)
				{
					handlers.mouseClick(e, box);
					if (needUpdate) stage.update();
				}
			});
			
			box.addDblclickEventListener(function(e:MouseEvent)
			{
				e.stopPropagation();
				if (handlers.mouseDoubleClick != null)
				{
					handlers.mouseDoubleClick(e, box);
					if (needUpdate) stage.update();
				}
			});
		}
		
		return box;
	}
	
	function enableMouseOver()
	{
		if (stage != null) stage.enableMouseOver(20);
	}

	function disableMouseOver()
	{
		if (stage != null) stage.enableMouseOver(0);
	}
	
	override public function draw(ctx:js.html.CanvasRenderingContext2D, ?ignoreCache:Bool) : Bool
	{
		needUpdate  = false;
		lines.graphics.clear();
		drawLines(lines.graphics);
		drawDots();
		updateBounds();
		enableMouseOver();
		return super.draw(ctx, ignoreCache);
	}
	
	function drawDot(dot:Shape, type:DotType, ?x:Float, ?y:Float, ?cursor:String)
	{
		if (x == null) x = dot.x;
		if (y == null) y = dot.y;
		
		dot.visible = true;
		if (cursor != null) dot.cursor = cursor;
		
		switch (type)
		{
			case DotType.CIRCLE:
				var m = Matrix.fromNative(getConcatenatedMatrix());
				m.invert();
				var t = m.decompose();
				dot.scaleX = t.scaleX;
				dot.scaleY = t.scaleY;
				dot.skewX = t.skewX;
				dot.skewY = t.skewY;
				dot.rotation = t.rotation;
				dot.x = x;
				dot.y = y;
				
				dot.graphics
					.clear()
					.beginStroke("black")
					.beginFill("white")
					.drawCircle(0, 0, 4)
					.endFill()
					.endStroke();
				
			case _:
				var zeroPoint = localToGlobal(0, 0);
				
				var lrVec = localToGlobal(1, 0);
				lrVec.x -= zeroPoint.x;
				lrVec.y -= zeroPoint.y;
				lrVec = normalize(lrVec);
				
				var tbVec = localToGlobal(0, 1);
				tbVec.x -= zeroPoint.x;
				tbVec.y -= zeroPoint.y;
				tbVec = normalize(tbVec);
				
				var centerPoint = localToGlobal(x, y);
				var ltPoint = globalToLocal(centerPoint.x - (lrVec.x + tbVec.x) * BOX_SIZE, centerPoint.y - (lrVec.y + tbVec.y) * BOX_SIZE);
				var rbPoint = globalToLocal(centerPoint.x + (lrVec.x + tbVec.x) * BOX_SIZE, centerPoint.y + (lrVec.y + tbVec.y) * BOX_SIZE);
				
				var boxWidth = rbPoint.x - ltPoint.x;
				var boxHeight = rbPoint.y - ltPoint.y;
				var halfWidth = boxWidth / 2;
				var halfHeight = boxHeight / 2;
				
				dot.x = ltPoint.x + halfWidth;
				dot.y = ltPoint.y + boxHeight / 2;
				
				var g = dot.graphics;
				g.clear();
				
				g.beginFill("#000000");
				switch (type)
				{
					case DotType.HALFBOX_1:
						g.rect(-halfWidth, -halfHeight, halfWidth, halfHeight);
						g.rect(0, 0, halfWidth, halfHeight);
						
					case DotType.HALFBOX_2:
						g.rect(0, -halfHeight, halfWidth, halfHeight);
						g.rect(-halfWidth, 0, halfWidth, halfHeight);
						
					case DotType.BOX:
						g.rect(-halfWidth, -halfHeight, boxWidth, boxHeight);
						
					case DotType.CIRCLE: // nothing to do
						
					case DotType.RHOMBUS_H:
						g.moveTo(-boxWidth*RHOMBUS_T, 0);
						g.lineTo(0, -boxHeight*RHOMBUS_K);
						g.lineTo(boxWidth*RHOMBUS_T, 0);
						g.lineTo(0, boxHeight*RHOMBUS_K);
						g.lineTo(-boxWidth*RHOMBUS_T, 0);
						
					case DotType.RHOMBUS_V:
						g.moveTo(0, -boxHeight*RHOMBUS_T);
						g.lineTo(boxWidth*RHOMBUS_K, 0);
						g.lineTo(0, boxHeight*RHOMBUS_T);
						g.lineTo(-boxWidth*RHOMBUS_K, 0);
						g.lineTo(0, -boxHeight*RHOMBUS_T);
				}
				g.endFill();
				
				g.beginStroke("#FFFFFF");
				g.setStrokeStyle(1, "round", null, null, true);
				switch (type)
				{
					case DotType.HALFBOX_1:
						g.moveTo(-halfWidth, 0);
						g.lineTo(-halfWidth, -halfHeight);
						g.lineTo(0, -halfHeight);
						g.moveTo(halfWidth, 0);
						g.lineTo(halfWidth, halfHeight);
						g.lineTo(0, halfHeight);
						
					case DotType.HALFBOX_2:
						g.moveTo(0, -halfHeight);
						g.lineTo(halfWidth, -halfHeight);
						g.lineTo(halfWidth, 0);
						g.moveTo(0, halfHeight);
						g.lineTo(-halfWidth, halfHeight);
						g.lineTo(-halfWidth, 0);
						
					case DotType.BOX:
						g.rect(-halfWidth, -halfHeight, boxWidth, boxHeight);
						
					case DotType.CIRCLE: // nothing to do
						
					case DotType.RHOMBUS_H:
						g.moveTo(-boxWidth*RHOMBUS_T, 0);
						g.lineTo(0, -boxHeight*RHOMBUS_K);
						g.lineTo(boxWidth*RHOMBUS_T, 0);
						g.lineTo(0, boxHeight*RHOMBUS_K);
						g.lineTo(-boxWidth*RHOMBUS_T, 0);
						
					case DotType.RHOMBUS_V:
						g.moveTo(0, -boxHeight*RHOMBUS_T);
						g.lineTo(boxWidth*RHOMBUS_K, 0);
						g.lineTo(0, boxHeight*RHOMBUS_T);
						g.lineTo(-boxWidth*RHOMBUS_K, 0);
						g.lineTo(0, -boxHeight*RHOMBUS_T);
				}
				g.endStroke();
		}
	}
	
	function normalize(p:Point) : Point
	{
		var len = Math.sqrt(p.x * p.x + p.y * p.y);
		return new Point(p.x / len, p.y / len);
	}
	
	function drawLines(graphics:Graphics) {}
	function drawDots() {}
	function updateBounds() {}
}
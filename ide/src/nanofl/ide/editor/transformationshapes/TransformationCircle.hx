package nanofl.ide.editor.transformationshapes;

import easeljs.display.Graphics;
import easeljs.display.Shape;
import nanofl.engine.geom.Point;
import stdlib.Event;

private typedef ChangeEventArgs =
{
	var center : Point;
	var radius : Float;
	var focus : Point;
}

class TransformationCircle extends BaseTransformationShape
{
	var tpC : Shape;
	var tpR : Shape;
	var tpF : Shape;
	
	public var circleCenter(get, never) : Point;
	function get_circleCenter() return tpC;
	
	public var circleRadius : Float;
	
	public var circleFocus(get, never) : Point;
	function get_circleFocus() return tpF;
	
	public var change(default, null) : Event<ChangeEventArgs>;
	
	public function new()
	{
		super();
		
		addChild(tpC = createMoveDot(function(dx, dy)
		{
			tpC.x += dx;
			tpC.y += dy;
			tpR.x += dx;
			tpR.y += dy;
			tpF.x += dx;
			tpF.y += dy;
		}));
		
		addChild(tpR = createMoveDot(function(dx, dy)
		{
			circleRadius += dx;
		}));
		
		addChild(tpF = createMoveDot
		(
			function(dx, dy)
			{
				tpF.x += dx;
				tpF.y += dy;
			},
			function()
			{
				tpF.x = tpC.x;
				tpF.y = tpC.y;
			}
		));
		
		change = new Event<ChangeEventArgs>(this);
	}
	
	function createMoveDot(onMove:Float->Float->Void, ?onDoubleClick:Void->Void) : Shape
	{
		var oldMousePos : Point = null;
		
		return createDot
		({
			mouseDown: function(e, dot)
			{
				oldMousePos = globalToLocal(e.stageX, e.stageY);
			},
			mouseMove: function(e, dot)
			{
				var newMousePos = globalToLocal(e.stageX, e.stageY);
				onMove(newMousePos.x - oldMousePos.x, newMousePos.y - oldMousePos.y);
				oldMousePos = newMousePos;
				needUpdate = true;
				fireChange();
			},
			mouseDoubleClick: function(e, dot)
			{
				if (onDoubleClick != null)
				{
					onDoubleClick();
					needUpdate = true;
					fireChange();
				}
			}
		});
	}
	
	override function drawLines(graphics:Graphics)
	{
		graphics
			.setStrokeStyle(1.0, null, null, null, true)
			.beginStroke("#000000")
			.drawCircle(tpC.x, tpC.y, circleRadius)
			.moveTo(tpC.x, tpC.y)
			.lineTo(tpF.x, tpF.y)
			.endStroke();
	}
	
	override function drawDots()
	{
		drawDot(tpC, DotType.CIRCLE, "move");
		drawDot(tpR, DotType.BOX, tpC.x + circleRadius, tpC.y, "move");
		drawDot(tpF, DotType.BOX, "move");
	}
	
	function fireChange()
	{
		change.call
		({
			center: tpC,
			radius: circleRadius,
			focus: tpF
		});
	}
}
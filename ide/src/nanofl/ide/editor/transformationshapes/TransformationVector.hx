package nanofl.ide.editor.transformationshapes;

import easeljs.display.Graphics;
import easeljs.display.Shape;
import nanofl.engine.geom.Point;
import stdlib.Event;

private typedef ChangeEventArgs =
{
	var pt1 : Point;
	var pt2 : Point;
}

class TransformationVector extends BaseTransformationShape
{
	var tpS : Shape;
	var tpE : Shape;
	
	public var pt1(get, never) : Point;
	function get_pt1() return tpS;
	
	public var pt2(get, never) : Point;
	function get_pt2() return tpE;
	
	public var change(default, null) : Event<ChangeEventArgs>;
	
	public function new()
	{
		super();
		
		addChild(tpS=createMoveDot());
		addChild(tpE=createMoveDot());
		
		change = new Event<ChangeEventArgs>(this);
	}
	
	function createMoveDot() : Shape
	{
		var oldMousePos : Point = null;
		var oldDotPos : Point = null;
		
		return createDot
		({
			mouseDown: function(e, dot)
			{
				oldMousePos = globalToLocal(e.stageX, e.stageY);
				oldDotPos = { x:dot.x, y:dot.y };
			},
			mouseMove: function(e, dot)
			{
				var newMousePos = globalToLocal(e.stageX, e.stageY);
				
				dot.x = oldDotPos.x + (newMousePos.x - oldMousePos.x);
				dot.y = oldDotPos.y + (newMousePos.y - oldMousePos.y);
				
				needUpdate = true;
				
				change.call
				({
					pt1: pt1,
					pt2: pt2
				});
			}
		});
	}
	
	override function drawLines(graphics:Graphics)
	{
		graphics
			.setStrokeStyle(1.0, null, null, null, true)
			.beginStroke("#000000")
			.moveTo(tpS.x, tpS.y)
			.lineTo(tpE.x, tpE.y)
			.endStroke();
	}
	
	override function drawDots()
	{
		drawDot(tpS, DotType.BOX, "move");
		drawDot(tpE, DotType.BOX, "move");
		
		var a = Math.atan2(tpE.y - tpS.y, tpE.x - tpS.x) * 180 / Math.PI;
		tpS.rotation = a;
		tpE.rotation = a;
	}
}
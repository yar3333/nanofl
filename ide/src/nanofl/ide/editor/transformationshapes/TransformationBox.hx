package nanofl.ide.editor.transformationshapes;

import easeljs.display.Graphics;
import easeljs.geom.Point;
import easeljs.display.Shape;
import nanofl.engine.geom.Matrix;
import nanofl.engine.geom.StraightLine;
import stdlib.Event;
import stdlib.Std;
using StringTools;

private typedef ResizeEventArgs =
{
	var regX : Float;
	var regY : Float;
	var kx : Float;
	var ky : Float;
}

private typedef RotateEventArgs =
{
	var regX : Float;
	var regY : Float;
	var angle : Float;
}

private typedef MoveEventArgs =
{
	var dx : Float;
	var dy : Float;
}

private typedef BarMoveEventArgs =
{
	var code : String;
	var value : Float;
}

class TransformationBox extends BaseTransformationShape
{
	var tpLT_r : Shape;
	var tpLT_t : Shape;
	var tpRT_r : Shape;
	var tpRT_t : Shape;
	var tpRB_r : Shape;
	var tpRB_t : Shape;
	var tpLB_r : Shape;
	var tpLB_t : Shape;
	
	var tpReg : Shape;
	
	var tpMove : Shape;
	
	var tpBarT : Shape;
	var tpBarR : Shape;
	var tpBarB : Shape;
	var tpBarL : Shape;
	
	public var minWidth : Float;
	public var minHeight : Float;
	
	public var width : Float;
	public var height : Float;
	
	public var regPointX(get, set) : Float;
	function get_regPointX() return tpReg.x;
	function set_regPointX(v:Float) return tpReg.x = v;
	
	public var regPointY(get, set) : Float;
	function get_regPointY() return tpReg.y;
	function set_regPointY(v:Float) return tpReg.y = v;
	
	public var rotateCursorUrl : String;
	
	public var resize(default, null) : Event<ResizeEventArgs>;
	public var rotate(default, null) : Event<RotateEventArgs>;
	public var changeRegPoint(default, null) : Event<{}>;
	public var move(default, null) : Event<MoveEventArgs>;
	public var barMove(default, null) : Event<BarMoveEventArgs>;
	
	public var defaultRegPointX : Float;
	public var defaultRegPointY : Float;
	
	public var enableRegPoint : Bool;
	public var enableRotatePoint : Bool;
	public var enableTranslatePoint : Bool;
	public var enableBars : Bool;
	
	public var translatePointPositionX : String;
	public var translatePointPositionY : String;
	
	public var topBarPosition : Float;
	public var rightBarPosition : Float;
	public var bottomBarPosition : Float;
	public var leftBarPosition : Float;
	
	public function new()
	{
		super();

        minWidth = null;
        minHeight = null;
        
        width = 0.0;
        height = 0.0;

        rotateCursorUrl = "rotate.cur";

        enableRegPoint = true;
        enableRotatePoint = true;
        enableTranslatePoint = false;
        enableBars = false;
        
        translatePointPositionX = "50%";
        translatePointPositionY = "50%";
        
        topBarPosition = 0.5;
        rightBarPosition = 0.5;
        bottomBarPosition = 0.5;
        leftBarPosition = 0.5;
		
		addChild(tpLT_r=createRotateDot());
		addChild(tpLT_t=createResizeDot("lt"));
		addChild(tpRT_r=createRotateDot());
		addChild(tpRT_t=createResizeDot("rt"));
		addChild(tpRB_r=createRotateDot());
		addChild(tpRB_t=createResizeDot("rb"));
		addChild(tpLB_r=createRotateDot());
		addChild(tpLB_t=createResizeDot("lb"));
		
		addChild(tpReg=createRegDot());
		addChild(tpMove=createMoveDot());
		
		addChild(tpBarT=createBarDot("t"));
		addChild(tpBarR=createBarDot("r"));
		addChild(tpBarB=createBarDot("b"));
		addChild(tpBarL=createBarDot("l"));
		
		resize = new Event<ResizeEventArgs>(this);
		rotate = new Event<RotateEventArgs>(this);
		changeRegPoint = new Event<{}>(this);
		move = new Event<MoveEventArgs>(this);
		barMove = new Event<BarMoveEventArgs>(this);
	}
	
	function createResizeDot(posCode:String) : Shape
	{
		var mouseDelta = new Point();
		var accumKX : Float;
		var accumKY : Float;
		
		return createDot
		({
			mouseDown: function(e, dot)
			{
				var boxPos = dot.localToGlobal(0, 0);
				mouseDelta.x = boxPos.x - e.stageX;
				mouseDelta.y = boxPos.y - e.stageY;
				accumKX = 1.0;
				accumKY = 1.0;
			},
			mouseMove: function(e, dot)
			{
				var mousePos = globalToLocal(e.stageX + mouseDelta.x, e.stageY + mouseDelta.y);
				
				var kx = 1.0;
				var ky = 1.0;
				
				if (posCode == "lt")
				{
					if (!enableRegPoint) { tpReg.x = width; tpReg.y = height; }
					if (tpReg.x != 0) kx = (tpReg.x - mousePos.x) / tpReg.x;
					if (tpReg.y != 0) ky = (tpReg.y - mousePos.y) / tpReg.y;
				}
				else
				if (posCode == "rb")
				{
					if (!enableRegPoint) { tpReg.x = 0; tpReg.y = 0; }
					if (width != 0) kx = (mousePos.x - tpReg.x) / (width  - tpReg.x);
					if (height != 0) ky = (mousePos.y - tpReg.y) / (height - tpReg.y);
				}
				else
				if (posCode == "rt")
				{
					if (!enableRegPoint) { tpReg.x = 0; tpReg.y = height; }
					if (width != 0) kx = (mousePos.x - tpReg.x) / (width  - tpReg.x);
					if (tpReg.y != 0) ky = (tpReg.y - mousePos.y) / tpReg.y;
				}
				else
				if (posCode == "lb")
				{
					if (!enableRegPoint) { tpReg.x = width; tpReg.y = 0; }
					if (tpReg.x != 0) kx = (tpReg.x - mousePos.x) / tpReg.x;
					if (height != 0) ky = (mousePos.y - tpReg.y) / (height - tpReg.y);
				}
				
				if (magnet)
				{
					if (width < height)
					{
						kx *= Math.abs((accumKY*ky) / (accumKX*kx)) * Std.sign(kx);
					}
					else
					{
						ky *= Math.abs((accumKX*kx) / (accumKY*ky)) * Std.sign(ky);
					}
				}
				
				var px = applyLimit(kx, width, minWidth);
				kx = px.k;
				width = px.size;
				
				var py = applyLimit(ky, height, minHeight);
				ky = py.k;
				height = py.size;
				
				accumKX *= kx;
				accumKY *= ky;
				
				var oldTpRegPos = localToLocal(tpReg.x, tpReg.y, parent);
				
				if (kx < 0) scaleX *= -1;
				if (ky < 0) scaleY *= -1;
				
				var newTpRegPos = localToLocal(tpReg.x * Math.abs(kx),  tpReg.y * Math.abs(ky), parent);
				x -= newTpRegPos.x - oldTpRegPos.x;
				y -= newTpRegPos.y - oldTpRegPos.y;
				
				tpReg.x *= Math.abs(kx);
				tpReg.y *= Math.abs(ky);
				
				needUpdate = true;
				
				var reg = localToLocal(tpReg.x, tpReg.y, parent);
				resize.call
				({
					regX: reg.x,
					regY: reg.y,
					kx: kx,
					ky: ky
				});
			}
		});
	}
	
	function createRotateDot() : Shape
	{
		var startAngle : Float = null;
		var prevAngle : Float = null;
		
		return createDot
		({
			mouseDown: function(e, dot)
			{
				if (!enableRegPoint) { tpReg.x = width / 2; tpReg.y = height / 2; }
				
				var reg = localToLocal(tpReg.x, tpReg.y, parent);
				var pt = parent.globalToLocal(e.stageX, e.stageY);
				startAngle = prevAngle = Math.atan2(pt.y - reg.y, pt.x - reg.x);
				
				disableMouseOver();
			},
			mouseMove: function(e, dot)
			{
				var reg = localToLocal(tpReg.x, tpReg.y, parent);
				var pt = parent.globalToLocal(e.stageX, e.stageY);
				var newAngle = Math.atan2(pt.y - reg.y, pt.x - reg.x);
				
				if (magnet)
				{
					var step = 15 * Math.PI / 180;
					newAngle = startAngle + Math.round((newAngle-startAngle) / step) * step;
				}
				
				var angle = newAngle - prevAngle;
				prevAngle = newAngle;
				
				var m = new Matrix();
				m.prependTransform(0, 0, scaleX, scaleY);
				m.prependTransform(0, 0, 1, 1, rotation);
				m.prependTransform(0, 0, 1, 1, 0, skewX, skewY);
				var c = m.transformPoint(tpReg.x, tpReg.y);
				m.prependTransform(-c.x, -c.y);
				m.prependTransform(0, 0, 1, 1, angle * 180 / Math.PI);
				m.prependTransform(c.x,  c.y);
				m.prependTransform(x, y);
				
				set(m.decompose());
				
				needUpdate = true;
				
				rotate.call({ regX:reg.x, regY:reg.y, angle:angle });
			},
			mouseUp: function(e, dot)
			{
				enableMouseOver();
			}
		});
	}
	
	function createRegDot() : Shape
	{
		var mouseDeltaPos : Point = null;
		
		return createDot
		({
			mouseDown: function(e, dot)
			{
				var pt = dot.localToGlobal(0, 0);
				mouseDeltaPos = new Point(pt.x - e.stageX, pt.y - e.stageY);
			},
			mouseMove: function(e, dot)
			{
				var pt = globalToLocal(e.stageX + mouseDeltaPos.x, e.stageY + mouseDeltaPos.y);
				dot.x = pt.x;
				dot.y = pt.y;
				changeRegPoint.call(null);
				stage.update();
			},
			mouseDoubleClick: function(e, dot)
			{
				if (defaultRegPointX != null && defaultRegPointY != null)
				{
					regPointX = defaultRegPointX;
					regPointY = defaultRegPointY;
					changeRegPoint.call(null);
					stage.update();
				}
			}
		});
	}
	
	function createMoveDot() : Shape
	{
		var prevMousePos : Point = null;
		
		return createDot
		({
			mouseDown: function(e, dot)
			{
				prevMousePos = new Point(e.stageX, e.stageY);
			},
			mouseMove: function(e, dot)
			{
				var pt1 = parent.globalToLocal(prevMousePos.x, prevMousePos.y);
				var pt2 = parent.globalToLocal(e.stageX, e.stageY);
				
				var dx = pt2.x - pt1.x;
				var dy = pt2.y - pt1.y;
				
				x += dx;
				y += dy;
				
				move.call({ dx:dx, dy:dy });
				stage.update();
				
				prevMousePos.x = e.stageX;
				prevMousePos.y = e.stageY;
			}
		});
	}
	
	/**
	 * @param	posCode "t", "r", "b" or "l".
	 */
	function createBarDot(posCode:String) : Shape
	{
		return createDot
		({
			mouseDown: function(e, dot)	{}, // don't remove: used to capture mouse down
			mouseMove: function(e, dot)
			{
				var pt = globalToLocal(e.stageX, e.stageY);
				var line = getBorderLine(posCode);
				moveBarDot(posCode, line.getNearestPoint(pt.x, pt.y).t);
			},
			mouseDoubleClick: function(e, dot)
			{
				moveBarDot(posCode, 0.5);
			}
		});
	}
	
	function moveBarDot(posCode:String, value:Float)
	{
		switch (posCode)
		{
			case "t": topBarPosition = value;
			case "r": rightBarPosition = value;
			case "b": bottomBarPosition = value;
			case "l": leftBarPosition = value;
			case _:
		}
		
		barMove.call({ code:posCode, value:value });
		stage.update();
	}
	
	function getBorderLine(code:String) : StraightLine
	{
		var localLine: StraightLine = switch (code)
		{
			case "t": new StraightLine(0.0,   0.0,    width, 0.0);
			case "r": new StraightLine(width, 0.0,    width, height);
			case "b": new StraightLine(0.0,   height, width, height);
			case "l": new StraightLine(0.0,   0.0,    0.0,   height);
			case _: null;
		};
		
		var pt1 = localToGlobal(localLine.x1, localLine.y1);
		var pt2 = localToGlobal(localLine.x2, localLine.y2);
		
		var globalLine = new StraightLine(pt1.x, pt1.y, pt2.x, pt2.y);
		
		var fixSize = BOX_SIZE / 2 + BOX_SIZE * RHOMBUS_T * 2 + 4;
		
		if (globalLine.getLength() > fixSize * 2)
		{
			var len = globalLine.getLength();
			var dx = (globalLine.x2 - globalLine.x1) / len * fixSize;
			var dy = (globalLine.y2 - globalLine.y1) / len * fixSize;
			
			globalLine.x1 += dx;
			globalLine.y1 += dy;
			globalLine.x2 -= dx;
			globalLine.y2 -= dy;
			
			var r1 = globalToLocal(globalLine.x1, globalLine.y1);
			var r2 = globalToLocal(globalLine.x2, globalLine.y2);
			
			return new StraightLine(r1.x, r1.y, r2.x, r2.y);
		}
		else
		{
			var c = localLine.getPoint(0.5);
			return new StraightLine(c.x, c.y, c.x, c.y);
		}
	}
	
	override function drawLines(graphics:Graphics)
	{
		var pt0 = halfPoint(0, 0);
		var pt1 = halfPoint(width, height);
		
		graphics
			.setStrokeStyle(1.0, null, null, null, true)
			.beginStroke("#000000")
			.rect(pt0.x, pt0.y, pt1.x - pt0.x, pt1.y - pt0.y)
			.endStroke();
	}
	
	override function drawDots()
	{
		if (width > 0 || height > 0)
		{
			if (enableRotatePoint)
			{
				var rotateCursor = "url(" + rotateCursorUrl + "), auto";
				
				drawDot(tpLT_r, DotType.HALFBOX_1, 0, 0,           rotateCursor);
				drawDot(tpLT_t, DotType.HALFBOX_2, 0, 0,          "nwse-resize");
				drawDot(tpRT_r, DotType.HALFBOX_1, width, 0,       rotateCursor);
				drawDot(tpRT_t, DotType.HALFBOX_2, width, 0,      "nesw-resize");
				drawDot(tpRB_r, DotType.HALFBOX_1, width, height,  rotateCursor);
				drawDot(tpRB_t, DotType.HALFBOX_2, width, height, "nwse-resize");
				drawDot(tpLB_r, DotType.HALFBOX_1, 0, height,      rotateCursor);
				drawDot(tpLB_t, DotType.HALFBOX_2, 0, height,     "nesw-resize");
			}
			else
			{
				tpLT_r.visible = false;
				drawDot(tpLT_t, DotType.BOX, 0, 0,          "nwse-resize");
				tpRT_r.visible = false;
				drawDot(tpRT_t, DotType.BOX, width, 0,      "nesw-resize");
				tpRB_r.visible = false;
				drawDot(tpRB_t, DotType.BOX, width, height, "nwse-resize");
				tpLB_r.visible = false;
				drawDot(tpLB_t, DotType.BOX, 0, height,     "nesw-resize");
			}
			
			if (enableRegPoint)
			{
				drawDot(tpReg, DotType.CIRCLE, "crosshair");
			}
			else
			{
				tpReg.visible = false;
			}
		}
		else
		{
			tpLT_r.visible = false;
			tpLT_t.visible = false;
			tpRT_r.visible = false;
			tpRT_t.visible = false;
			tpRB_r.visible = false;
			tpRB_t.visible = false;
			tpLB_r.visible = false;
			tpLB_t.visible = false;
			
			tpReg.visible = false;
		}
		
		if (enableTranslatePoint) drawDot(tpMove, DotType.CIRCLE, parsePosition(width, translatePointPositionX), parsePosition(height, translatePointPositionY), "move");
		else                      tpMove.visible = false;
		
		if (enableBars)
		{
			var ptT = getBorderLine("t").getPoint(topBarPosition);
			drawDot(tpBarT, DotType.RHOMBUS_H, ptT.x, ptT.y, "ew-resize");
			
			var ptR = getBorderLine("r").getPoint(rightBarPosition);
			drawDot(tpBarR, DotType.RHOMBUS_V, ptR.x, ptR.y, "ns-resize");
			
			var ptB = getBorderLine("b").getPoint(bottomBarPosition);
			drawDot(tpBarB, DotType.RHOMBUS_H, ptB.x, ptB.y, "ew-resize");
			
			var ptL = getBorderLine("l").getPoint(leftBarPosition);
			drawDot(tpBarL, DotType.RHOMBUS_V, ptL.x, ptL.y, "ns-resize");
		}
		else
		{
			tpBarT.visible = false;
			tpBarR.visible = false;
			tpBarB.visible = false;
			tpBarL.visible = false;
		}
	}
	
	override function updateBounds()
	{
		setBounds(-BOX_SIZE, -BOX_SIZE, width + BOX_SIZE, height + BOX_SIZE);
	}
	
	function applyLimit(k:Float, size:Float, minSize:Float) : { k:Float, size:Float }
	{
		if (size != 0)
		{
			if (k > 0)
			{
				if (minSize != null) k = Math.max(k, Math.max(1e-5, minSize) / size);
			}
			else
			if (k < 0)
			{
				if (minSize != null)
				{
					k = Math.max(1e-5, minSize) / size;
				}
			}
			else
			{
				k = 1.0;
			}
			size *= Math.abs(k);
		}
		return { k:k, size:size };
	}
	
	function halfPoint(x:Float, y:Float) : Point
	{
		var pt = localToGlobal(x, y);
		return globalToLocal(Math.round(pt.x) + 0.5, Math.round(pt.y) + 0.5);
	}
	
	function parsePosition(len:Float, pos:String) : Float
	{
		if (pos.endsWith("%"))
		{
			return Std.parseFloat(pos.substring(0, pos.length - 1)) / 100 * len;
		}
		else
		{
			if (pos.endsWith("px")) pos = pos.substring(0, pos.length - 2);
			return Std.parseFloat(pos);
		}
	}
}
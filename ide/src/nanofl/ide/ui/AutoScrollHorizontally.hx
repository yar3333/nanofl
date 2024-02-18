package nanofl.ide.ui;

import haxe.Timer;
import js.JQuery;
private typedef HorizontalScrollbar = components.nanofl.common.horizontalscrollbar.Code;

class AutoScrollHorizontally
{
	var content : JQuery;
	var padLeft : Int;
	var padRight : Int;
	var scrollbar : HorizontalScrollbar;
	var callb : Int->Void;
	
	var isMouseDown : Bool;
	var timer : Timer;
	
	public function new(content:JQuery, scrollbar:HorizontalScrollbar, padLeft=0, padRight=0, ?callb:Int->Void) 
	{
		this.content = content;
		this.scrollbar = scrollbar;
		this.padLeft = padLeft;
		this.padRight = padRight;
		this.callb = callb;
		
		content.on("mousedown", onMouseDown);
		
		new JQuery(js.Browser.document)
			.mousemove(onMouseMove)
			.mouseup(onMouseUp);
	}
	
	function onMouseDown(e:JqEvent)
	{
		if (e.which != 1) return;
		
		var contentPos = content.offset();
		if (e.pageX < contentPos.left + padLeft || e.pageX > contentPos.left + content.width() - padRight) return;
		
		isMouseDown = true;
	}
	
	function onMouseMove(e:JqEvent)
	{
		if (!isMouseDown) return;
		
		var contentPos = content.offset();
		if (e.pageX < contentPos.left + padLeft)
		{
			if (timer == null) timer = new Timer(200);
			timer.run = function()
			{
				var dx = e.pageX - (contentPos.left + padLeft);
				scrollbar.position += dx;
				if (callb != null) callb(dx);
			};
		}
		else
		if (e.pageX > contentPos.left + content.width() - padRight)
		{
			if (timer == null) timer = new Timer(200);
			timer.run = function()
			{
				var dx = e.pageX - (contentPos.left + content.width() - padRight);
				scrollbar.position += dx;
				if (callb != null) callb(dx);
			};
		}
		else
		{
			if (timer != null) { timer.stop(); timer = null; }
		}
	}
	
	function onMouseUp(e:JqEvent)
	{
		if (!isMouseDown) return;
		isMouseDown = false;
		if (timer != null) { timer.stop(); timer = null; }
	}
}
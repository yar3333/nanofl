package components.nanofl.others.gradientselector;

import wquery.Event;
import js.Browser;
import js.JQuery;
import stdlib.Std;
using Lambda;

class Code extends wquery.Component
{
	static var imports =
	{
		"color-selector": components.nanofl.common.color.Code
	};

    var event_change = new Event<{}>();
	
	var controlWidth = 12;
	
	var control : JQuery;
	
	function init()
    {
		var controls = template().controls;
		
		controls.on("click", function(e)
		{
			var control = new JQuery("<div class='chess-back'><div></div></div>");
			controls.append(control);
			setControlPos(control, e.pageX - controlWidth / 2);
		});
		
		var pressed = false;
		var mouseDX : Int;
		var moved = false;
		
		controls.on("mousedown", ">*", function(e)
		{
			e.preventDefault();
			pressed = true;
			moved = false;
			control = q(e.currentTarget);
			mouseDX = control.offset().left - e.pageX;
		});
		
		q(Browser.window).on("mousemove", function(e)
		{
			if (!pressed) return;
			moved = true;
			
			setControlPos(control, e.pageX + mouseDX);
			
			var controlsY = controls.offset().top;
			if (e.pageY < controlsY || e.pageY > controlsY + controls.height())
			{
				control.hide();
			}
			else
			{
				control.show();
			}
		});
		
		q(js.Browser.window).on("mouseup", function(e)
		{
			if (!pressed) return;
			
			pressed = false;
			if (!control.is(":visible"))
			{
				control.remove();
				update();
			}
		});
		
		controls.on("click", ">*", function(e)
		{
			e.stopPropagation();
			if (!moved)
			{
				control = q(e.currentTarget);
				template().color.value = control.children().css("background-color");
				template().color.showPanel();
				var container = template().container;
				var panel = template().color.panel;
				panel.css("left", Std.min(e.pageX,  q(js.Browser.window).width() - panel.outerWidth()) + "px");
				panel.css("top", (container.offset().top + container.outerHeight()) + "px");
			}
		});
	}
	
	function color_change(e)
	{
		control.children().css("background-color", e.color);
		update();
	}
	
	function update()
	{
		var gradient = "linear-gradient(to right";
		for (item in getItems()) gradient += "," + item.color + " " + (item.ratio * 100) + "%";
		gradient += ")";
		template().gradient.css("background-image", gradient);
		event_change.emit(null);
	}
	
	function setControlPos(control:JQuery, pageX:Float)
	{
		var controls = template().controls;
		var x = Std.max(0, Std.min(controls.width() - controlWidth, Math.round(pageX - controls.offset().left)));
		control.css("margin-left", x + "px");
		update();
	}
	
	public function getItems() : Array<{ color:String, ratio:Float }>
	{
		var width = template().controls.width() - controlWidth;
		
		var items = template().controls.children(":visible").map(function(e)
			return { color:e.children().css("background-color"), ratio:Std.parseInt(e.css("margin-left").split("px")[0]) / width }
		).array();
		
		items.sort((a, b) -> a.ratio < b.ratio ? -1 : (a.ratio > b.ratio ? 1 : 0));
		
		return items;
	}
	
	public function get() : { colors:Array<String>, ratios:Array<Float> }
	{
		var items = getItems();
		return { colors:items.map(e -> e.color), ratios:items.map(e -> e.ratio) };
	}
	
	public function set(colors:Array<String>, ratios:Array<Float>)
	{
		var controls = template().controls;
		
		var width = controls.width() - controlWidth;
		var x = controls.offset().left;
		
		controls.html(colors.map(c -> "<div class='chess-back'><div style='background-color:" + c + "'></div></div>").join(""));
		var controlElements = controls.children();
		for (i in 0...colors.length)
		{
			setControlPos(q(controlElements[i]), x + Math.round(ratios[i] * width));
		}
	}
	
	public function show() template().container.show();
	public function hide() template().container.hide();
}
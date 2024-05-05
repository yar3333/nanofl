package components.nanofl.common.slider;

import js.html.WheelEvent;
import wquery.Event;
import stdlib.Std;
using js.bootstrap.Slider;

class Code extends wquery.Component
{
	var event_change = new Event<{ value:Float }>();
	
	public var min = 0.0;
	public var max = 100.0;
	public var step = 1.0;
	public var correction = 0.0;
	public var exponentially = false;
	
	var text = "Label:";
	var units = "%";
	
	var visible = true;
	
	var nativeMax : Int;
	
	var lastValue : Float;
    public var value(get, set) : Float;

	function get_value() : Float
	{
		var v = Std.parseFloat(template().value.val());
		if (Math.isNaN(v)) return null;
		return Math.min(max, Math.max(min, v));
	}
	
	function set_value(v:Float) : Float
	{
		if (v != null)
		{
			template().slider.sliderEnable();
			template().value.val(v);
			template().slider.sliderSetValue(toSliderValue(v));
		}
		else
		{
			template().slider.sliderDisable();
			template().value.val("");
			template().slider.sliderSetValue(0.0);
		}

        lastValue = v;
		
		return v;
	}
	
	function init()
	{
		template().label.html(text);
        template().units.html(units);
	
		var sections = Math.abs(max - min) / step;
		nativeMax = sections > Std.int(sections) ? Std.int(sections) + 1 : Std.int(sections);

		template().slider.data("sliderValue", toSliderValue(Std.parseFloat(template().value.val())));
		template().slider.data("sliderMin", 0);
		template().slider.data("sliderMax", nativeMax);
		
		template().slider.slider();
		
		template().slider.on("slide", e ->
		{
			final v = fromSliderValue((cast e).value);
			template().value.val(Std.string(v));
			event_change.emit({ value:v });
		});

        template().container.on("wheel", ".slider", jqEvent -> 
        {
            final e : WheelEvent = cast jqEvent.originalEvent;
            
            var v = value;

            if (v != null)
            {
                v -= Std.sign(e.deltaY);
                v = Math.max(min, Math.min(max, v));
            }
            else
            {
                v = Std.sign(e.deltaY) > 0 ? min : max;
            }

            if (lastValue != v)
            {
                value = v;
                event_change.emit({ value:v });
            }
        });
    }
	
	public function show()
	{
		if (!visible)
		{
			template().container.show();
			visible = true;
		}
	}
	
	public function hide()
	{
		if (visible)
		{
			template().container.hide();
			visible = false;
		}
	}
	
	public function toggle(b:Bool)
	{
		if (b) show();
		else   hide();
	}
	
	function value_keyup(e)
	{
		final v = value;
        if (v == lastValue) return;
        
        if (v != null)
		{
			template().slider.sliderSetValue(toSliderValue(v));
			event_change.emit({ value:v });
		}
	}
	
	function value_mouseup(e)
	{
		value_keyup(null);
	}
	
	function value_focus(e)
	{
		template().slider.sliderEnable();
	}
	
	function value_blur(e)
	{
		final v = value;
        if (v == lastValue) return;
		
        if (v == null)
		{
			template().slider.sliderDisable();
            lastValue = null;
		}
		else
		{
			set_value(v);
		}
	}
	
	function toSliderValue(v:Float) : Float
	{
		var r = Math.min(max, Math.max(min, v));
		
		if (exponentially)
		{
			var a = max - min + 1;
			var b = r - min + 1;
			r = Math.log(b) / Math.log(a);
		}
		else
		{
			r = (r - min) / (max - min);
		}
		
		r = Math.round(r * nativeMax);
        log("toSliderValue (" + min + "; " + max + "; naviveMax=" + nativeMax + "): " + v + " =>" + r);
        return r;
	}
	
	function fromSliderValue(v:Float) : Float
	{
		var r = v / nativeMax;
		
		if (exponentially)
		{
			r = min + Math.pow(max - min + 1, r) - 1;
		}
		else
		{
			r = min + r * (max - min);
		}
		
		var n = Math.round((r - min) / step);
		r = min + step * n + correction;
		
		r = Math.min(max, Math.max(min, r));
		
        log("fromSliderValue (" + min + "; " + max + "): " + v + " =>" + r);
        return r;
	}
	
	static function log(v:Dynamic)
	{
		//nanofl.engine.Log.console.namedLog("view:Slider", v);
	}
}

package svgexporter;

import js.Browser.console;
import htmlparser.XmlBuilder;
import nanofl.engine.fills.BitmapFill;
import nanofl.engine.fills.IFill;
import nanofl.engine.fills.LinearFill;
import nanofl.engine.fills.RadialFill;
import nanofl.engine.strokes.BitmapStroke;
import nanofl.engine.strokes.IStroke;
import nanofl.engine.strokes.LinearStroke;
import nanofl.engine.strokes.RadialStroke;

class Gradient
{
	var tag : String;
	var colors : Array<String>;
	var ratios : Array<Float>;
	var attributes : Array<{ name:String, value:Dynamic }>;
	
	function new(tag:String, colors:Array<String>, ratios:Array<Float>, attributes:Array<{ name:String, value:Dynamic }>)
	{
		this.tag = tag;
		this.colors = colors;
		this.ratios = ratios;
		this.attributes = attributes;
	}
	
	public function equ(g:Gradient) : Bool
	{
		if (g == this) return true;
		if (g.tag != tag) return false;
		if (g.colors.length != colors.length) return false;
		if (g.attributes.length != attributes.length) return false;
		for (i in 0...colors.length)
		{
			if (g.colors[i] != colors[i]) return false;
			if (g.ratios[i] != ratios[i]) return false;
		}
		for (i in 0...attributes.length)
		{
			if (g.attributes[i].name != attributes[i].name) return false;
			if (g.attributes[i].value != attributes[i].value) return false;
		}
		return true;
	}
	
	public function write(id:Int, xml:XmlBuilder)
	{
		xml.begin(tag);
		
		xml.attr("id", "grad" + id);
		for (a in attributes)
		{
			xml.attr(a.name, a.value);
		}
		xml.attr("gradientUnits", "userSpaceOnUse");
		
		for (i in 0...colors.length)
		{
			xml.begin("stop");
				xml.attr("stop-color", colors[i]);
				xml.attr("offset", ratios[i]);
			xml.end();
		}
		
		xml.end();
	}
	
	public static function fromStroke(stroke:IStroke) : Gradient
	{
		if (Std.is(stroke, LinearStroke))
		{
			var data : LinearStroke = cast stroke;
			return createLinear(data.colors, data.ratios, data.x0, data.y0, data.x1, data.y1);
		}
		else
		if (Std.is(stroke, RadialStroke))
		{
			var data : RadialStroke = cast stroke;
			return createRadial(data.colors, data.ratios, data.cx, data.cy, data.r, data.fx, data.fy);
		}
		else
		if (Std.is(stroke, BitmapStroke))
		{
			console.warn("BitmapStroke is not supported.");
		}
		return null;
	}
	
	public static function fromFill(fill:IFill) : Gradient
	{
		if (Std.is(fill, LinearFill))
		{
			var data : LinearFill = cast fill;
			return createLinear(data.colors, data.ratios, data.x0, data.y0, data.x1, data.y1);
		}
		else
		if (Std.is(fill, RadialFill))
		{
			var data : RadialFill = cast fill;
			return createRadial(data.colors, data.ratios, data.cx, data.cy, data.r, data.fx, data.fy);
		}
		else
		if (Std.is(fill, BitmapFill))
		{
			console.warn("BitmapFill is not supported.");
		}
		return null;
	}
	
	public static function createLinear(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float) : Gradient
	{
		return new Gradient("linearGradient", colors, ratios,
		[
			{ name:"x1", value:x0 },
			{ name:"y1", value:y0 },
			{ name:"x2", value:x1 },
			{ name:"y2", value:y1 }
		]);
	}
	
	public static function createRadial(colors:Array<String>, ratios:Array<Float>, cx:Float, cy:Float, r:Float, fx:Float, fy:Float) : Gradient
	{
		return new Gradient("radialGradient", colors, ratios,
		[
			{ name:"cx", value:cx },
			{ name:"cy", value:cy },
			{ name:"r",  value:r },
			{ name:"fx", value:fx },
			{ name:"fy", value:fy }
		]);
	}
}
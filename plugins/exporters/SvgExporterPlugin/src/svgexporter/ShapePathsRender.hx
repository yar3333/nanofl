package svgexporter;

import htmlparser.XmlBuilder;
import nanofl.engine.ShapeRender;
using stdlib.Lambda;

class ShapePathsRender
{
	var idPrefix = null;
	
	var gradients : Array<Gradient>;
	var xml : XmlBuilder;
	
	var attributes = new Array<{ name:String, value:Dynamic }>();
	var d = "";
	
	public var ids(default, null) = new Array<String>();
	
	public function new(?idPrefix:String, gradients:Array<Gradient>, xml:XmlBuilder)
	{
		this.idPrefix = idPrefix;
		this.gradients = gradients;
		this.xml = xml;
	}
	
	public function moveTo(x:Float, y:Float) : ShapeRender
	{
		d += 'M$x,$y';
		return this;
	}
	
	public function lineTo(x:Float, y:Float) : ShapeRender
	{
		d += 'L$x,$y';
		return this;
	}
	
	public function curveTo(x0:Float, y0:Float, x1:Float, y1:Float) : ShapeRender
	{
		d += 'Q$x0,$y0,$x1,$y1';
		return this;
	}
	
	public function beginStroke(color:String) : ShapeRender
	{
		attr("fill", "none");
		attr("stroke", color);
		return this;
	}
	
	public function beginLinearGradientStroke(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float) : ShapeRender
	{
		attr("fill", "none");
		var g = Gradient.createLinear(colors, ratios, x0, y0, x1, y1);
		attr("stroke", "url(#grad" + gradients.findIndex((x) -> x.equ(g)) + ")");
		return this;
	}
	
	public function beginRadialGradientStroke(colors:Array<String>, ratios:Array<Float>, fx:Float, fy:Float, fr:Float, cx:Float, cy:Float, cr:Float) : ShapeRender
	{
		attr("fill", "none");
		var g = Gradient.createRadial(colors, ratios, cx, cy, cr, fx, fy);
		attributes.push({ name:"stroke", value:"url(#grad" + gradients.findIndex((x) -> x.equ(g)) + ")" });
		return this;
	}
	
	#if js
	public function beginBitmapStroke(image:Dynamic, repeat:String) : ShapeRender
	{
		attr("fill", "none");
		attr("stroke", "#000000");
		return this;
	}
	#else
	public function beginBitmapStroke(url:String, repeat:String) : ShapeRender
	{
		attr("fill", "none");
		attr("stroke", "#000000");
		return this;
	}
	#end
	
	public function setStrokeStyle(thickness:Float, caps:String, joints:String, miterLimit:Float, ignoreScale:Bool) : ShapeRender
	{
		attr("stroke-width", thickness);
		attr("stroke-linecap", caps);
		attr("stroke-linejoin", joints);
		attr("stroke-miterlimit", miterLimit);
		return this;
	}
	
	public function endStroke() : ShapeRender
	{
		finishPath();
		return this;
	}
	
	public function beginFill(color:String) : ShapeRender
	{
		attr("fill", color);
		return this;
	}
	
	public function beginLinearGradientFill(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float) : ShapeRender
	{
		var g = Gradient.createLinear(colors, ratios, x0, y0, x1, y1);
		attr("fill", "url(#grad" + gradients.findIndex((x) -> x.equ(g)) + ")");
		return this;
	}
	
	public function beginRadialGradientFill(colors:Array<String>, ratios:Array<Float>, fx:Float, fy:Float, fr:Float, cx:Float, cy:Float, cr:Float) : ShapeRender
	{
		var g = Gradient.createRadial(colors, ratios, cx, cy, cr, fx, fy);
		attr("fill", "url(#grad" + gradients.findIndex((x) -> x.equ(g)) + ")");
		return this;
	}
	
	#if js
	public function beginBitmapFill(image:Dynamic, repeat:String, matrix:easeljs.geom.Matrix2D) : ShapeRender
	{
		attr("fill", "#000000");
		return this;
	}
	#else
	public function beginBitmapFill(url:String, repeat:String, matrix:nanofl.engine.geom.Matrix) : ShapeRender
	{
		attr("fill", "#000000");
		return this;
	}
	#end
	
	public function endFill() : ShapeRender
	{
		finishPath();
		return this;
	}
	
	function finishPath()
	{
		if (d != "")
		{
			if (idPrefix != null)
			{
				var id = idPrefix + ids.length;
				ids.push(id);
				attributes.unshift({ name:"id", value:id });
			}
			xml.begin("path", attributes).attr("d", d).end();
		}
		
		attributes = [];
		d = "";
	}
	
	function attr<T>(name:String, value:T, ?defaultValue:T)
	{
		if (value != defaultValue)
		{
			attributes.push({ name:name, value:value });
		}
	}
}
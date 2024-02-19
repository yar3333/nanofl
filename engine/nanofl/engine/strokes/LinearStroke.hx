package nanofl.engine.strokes;

import js.lib.Error;
import nanofl.engine.geom.Matrix;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class LinearStroke extends BaseStroke implements IStroke
{
	public var colors : Array<String>;
	public var ratios : Array<Float>;
	public var x0 : Float;
	public var y0 : Float;
	public var x1 : Float;
	public var y1 : Float;
	
	public function new(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float, thickness=1.0, caps="round", joints="round", miterLimit=3.0, ignoreScale=false)
	{
		super(thickness, caps, joints, miterLimit, ignoreScale);
		
		this.colors = colors;
		this.ratios = ratios;
		this.x0 = x0;
		this.y0 = y0;
		this.x1 = x1;
		this.y1 = y1;
	}
	
    #if ide
	function loadProperties(node:HtmlNodeElement) : Void
    {
        loadBaseProperties(node);
        colors = node.getAttr("colors", []);
        ratios = node.getAttr("ratios", [0.0]);
        x0 = node.getAttr("x0", 0.0);
        y0 = node.getAttr("y0", 0.0);
        x1 = node.getAttr("x1", 0.0);
        y1 = node.getAttr("y1", 0.0);
    }
    #end

    function loadPropertiesJson(obj:Dynamic) : Void
    {
        loadBasePropertiesJson(obj);
        colors = (cast obj.colors : Array<String>) ?? [];
        ratios = (cast obj.ratios : Array<Float>) ?? [0.0];
        x0 = obj.x0 ?? 0.0;
        y0 = obj.y0 ?? 0.0;
        x1 = obj.x1 ?? 0.0;
        y1 = obj.y1 ?? 0.0;
    }
        
    #if ide
	function saveProperties(out:XmlBuilder) : Void
	{
		out.attr("colors", colors);
		out.attr("ratios", ratios);
		out.attr("x0", x0);
		out.attr("y0", y0);
		out.attr("x1", x1);
		out.attr("y1", y1);

		saveBaseProperties(out);
	}
	
	function savePropertiesJson(obj:Dynamic) : Void
	{
		obj.colors = colors;
		obj.ratios = ratios;
		obj.x0 = x0;
		obj.y0 = y0;
		obj.x1 = x1;
		obj.y1 = y1;

		saveBasePropertiesJson(obj);
	}
    #end
	
	public function begin(g:ShapeRender) : Void
	{
		g.beginLinearGradientStroke(colors, ratios, x0, y0, x1, y1);
		setStrokeStyle(g);
	}
	
	override public function clone() : LinearStroke
	{
		return new LinearStroke(colors, ratios, x0, y0, x1, y1, thickness, caps, joints, miterLimit, ignoreScale);
	}
	
	override public function equ(e:IStroke) : Bool
	{
		if (e == this) return true;
		if (!Std.isOfType(e, LinearStroke) || !super.equ(e)) return false;
		var ee : LinearStroke = cast e;
		return arrEqu(ee.colors, colors)
			&& arrEqu(ee.ratios, ratios)
			&& ee.x0 == x0
			&& ee.y0 == y0
			&& ee.x1 == x1
			&& ee.y1 == y1;
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String) { }
	
	public function applyAlpha(alpha:Float) : Void
	{
		for (i in 0...colors.length)
		{
			var rgba = ColorTools.parse(colors[i]);
            if (rgba == null) throw new Error("Can't parse color '" + colors[i] + "'.");
			rgba.a *= alpha;
			colors[i] = ColorTools.rgbaToString(rgba);
		}
	}
	
	override public function getTransformed(m:Matrix, applyToThickness:Bool) : LinearStroke
	{
		var r : LinearStroke = cast super.getTransformed(m, applyToThickness);
		
		var p0 = m.transformPoint(x0, y0);
		r.x0 = p0.x;
		r.y0 = p0.y;
		
		var p1 = m.transformPoint(x1, y1);
		r.x1 = p1.x;
		r.y1 = p1.y;
		
		return r;
	}
	
	@:noapi public function getTyped() return TypedStroke.linear(this);
	
	public function toString()
	{
		return 'new LinearStroke(' + colors.map(function(s) return '"' + s + '"') + ', $ratios, $x0, $y0, $x1, $y1)';
	}
	
	function arrEqu<T>(a:Array<T>, b:Array<T>) : Bool
	{
		if (a.length != b.length) return false;
		for (i in 0...a.length) if (a[i] != b[i]) return false;
		return true;
	}
}
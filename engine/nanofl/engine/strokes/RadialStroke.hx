package nanofl.engine.strokes;

import nanofl.engine.geom.Matrix;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class RadialStroke extends BaseStroke implements IStroke
{
	public var colors : Array<String>;
	public var ratios : Array<Float>;
	public var cx : Float;
	public var cy : Float;
	public var r : Float;
	public var fx : Float;
	public var fy : Float;
	
	public function new(colors:Array<String>, ratios:Array<Float>, cx:Float, cy:Float, r:Float, fx:Float, fy:Float, thickness=1.0, caps="round", joints="round", miterLimit=3.0, ignoreScale=false)
	{
		super(thickness, caps, joints, miterLimit, ignoreScale);
		
		this.colors = colors;
		this.ratios = ratios;
		this.cx = cx;
		this.cy = cy;
		this.r = r;
		this.fx = fx;
		this.fy = fy;
	}
	
    #if ide
	function loadProperties(node:HtmlNodeElement) : Void
	{
		loadBaseProperties(node);
		colors = node.getAttr("colors", []);
		ratios = node.getAttr("ratios", [0.0]);
		cx = node.getAttr("cx", 0.0);
		cy = node.getAttr("cy", 0.0);
		r = node.getAttr("r", 0.0);
		fx = node.getAttr("fx", cx);
		fy = node.getAttr("fy", cy);
	}
    #end
	
	function loadPropertiesJson(obj:Dynamic) : Void
	{
		loadBasePropertiesJson(obj);
		colors = (cast obj.colors : Array<String>) ?? [];
		ratios = (cast obj.ratios : Array<Float>) ?? [0.0];
		cx = obj.cx ?? 0.0;
		cy = obj.cy ?? 0.0;
		r = obj.r ?? 0.0;
		fx = obj.fx ?? cx;
		fy = obj.fy ?? cy;
	}
	
    #if ide
	function saveProperties(out:XmlBuilder) : Void
	{
		out.attr("colors", colors);
		out.attr("ratios", ratios);
		out.attr("cx", cx);
		out.attr("cy", cy);
		out.attr("r", r);
		out.attr("fx", fx, cx);
		out.attr("fy", fy, cy);

		super.saveBaseProperties(out);
	}
        
	function savePropertiesJson(obj:Dynamic) : Void
	{
		obj.colors = colors;
		obj.ratios = ratios;
		obj.cx = cx;
		obj.cy = cy;
		obj.r = r;
		obj.fx = fx ?? cx;
		obj.fy = fy ?? cy;

		saveBasePropertiesJson(obj);
	}
    #end
	
	public function begin(g:ShapeRender) : Void
	{
		g.beginRadialGradientStroke(colors, ratios, fx, fy, 0, cx, cy, r);
		setStrokeStyle(g);
	}
	
	override public function clone() : RadialStroke
	{
		return new RadialStroke(colors, ratios, cx, cy, r, fx, fy, thickness, caps, joints, miterLimit, ignoreScale);
	}
	
	override public function equ(e:IStroke) : Bool
	{
		if (e == this) return true;
		if (!Std.isOfType(e, RadialStroke) || !super.equ(e)) return false;
		var ee : RadialStroke = cast e;
		return arrEqu(ee.colors, colors)
			&& arrEqu(ee.ratios, ratios)
			&& ee.cx == cx
			&& ee.cy == cy
			&& ee.r == r
			&& ee.fx == fx
			&& ee.fy == fy;
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String) { }
	
	public function applyAlpha(alpha:Float) : Void
	{
		for (i in 0...colors.length)
		{
			var rgba = ColorTools.parse(colors[i]);
			rgba.a *= alpha;
			colors[i] = ColorTools.rgbaToString(rgba);
		}
	}
	
	override public function getTransformed(m:Matrix, applyToThickness:Bool) : RadialStroke
	{
		var stroke : RadialStroke = cast super.getTransformed(m, applyToThickness);
		
		var c = m.transformPoint(cx, cy);
		stroke.cx = c.x;
		stroke.cy = c.y;
		
		var f = m.transformPoint(fx, fy);
		stroke.fx = f.x;
		stroke.fy = f.y;
		
		stroke.r *= m.getAverageScale();
		
		return stroke;
	}
	
	@:noapi public function getTyped() return TypedStroke.radial(this);
	
	public function toString()
	{
		return 'new RadialStroke(' + colors.map(function(s) return '"' + s + '"') + ', $ratios, $cx, $cy, $r, $fx, $fy)';
	}
	
	function arrEqu<T>(a:Array<T>, b:Array<T>) : Bool
	{
		if (a.length != b.length) return false;
		for (i in 0...a.length) if (a[i] != b[i]) return false;
		return true;
	}
}
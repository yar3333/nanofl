package nanofl.engine.fills;

import nanofl.engine.geom.Matrix;
using nanofl.engine.geom.PointTools;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class RadialFill extends BaseFill implements IFill
{
	public var colors : Array<String>;
	public var ratios : Array<Float>;
	public var cx : Float;
	public var cy : Float;
	public var r : Float;
	public var fx : Float;
	public var fy : Float;

	public function new(colors:Array<String>, ratios:Array<Float>, cx:Float, cy:Float, r:Float, fx:Float, fy:Float)
	{
		this.colors = colors;
		this.ratios = ratios;
		this.cx = cx;
		this.cy = cy;
		this.r = r;
		this.fx = fx;
		this.fy = fy;
	}
	
	#if ide
    public static function load(node:HtmlNodeElement, version:String) : RadialFill
	{
		return Version.handle(version,
		[
			"1.0.0" => function()
			{
				var matrix = Matrix.load(node);
				var props = matrix.decompose();
				
				return new RadialFill
				(
					node.getAttr("colors", []),
					node.getAttr("ratios", [0.0]),
					props.x,
					props.y,
					(props.scaleX + props.scaleY) / 2,
					props.x,
					props.y
				);
			},
			
			"2.0.0" => function()
			{
				var cx = node.getAttr("cx", 0.0);
				var cy = node.getAttr("cy", 0.0);
				
				return new RadialFill
				(
					node.getAttr("colors", []),
					node.getAttr("ratios", [0.0]),
					cx,
					cy,
					node.getAttr("r", 0.0),
					node.getAttr("fx", cx),
					node.getAttr("fy", cy)
				);
			}
		]);
	}
    #end
    
    public static function loadJson(obj:Dynamic, version:String) : RadialFill
	{
        var cx = obj.cx ?? 0.0;
        var cy = obj.cy ?? 0.0;
        
        return new RadialFill
        (
            (cast obj.colors : Array<String>) ?? [],
            (cast obj.ratios : Array<Float>) ?? [0.0],
            cx,
            cy,
            obj.r ?? 0.0,
            obj.fx ?? cx,
            obj.fy ?? cy,
        );
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
		out.begin("fill").attr("type", "radial");
		out.attr("colors", colors);
		out.attr("ratios", ratios);
		out.attr("cx", cx);
		out.attr("cy", cy);
		out.attr("r", r);
		out.attr("fx", fx, cx);
		out.attr("fy", fy, cy);
		out.end();
	}

	public function saveJson()
	{
        return
        {
		    type: "radial",
		    colors: colors,
		    ratios: ratios,
		    cx: cx,
		    cy: cy,
		    r: r,
		    fx: fx ?? cx,
		    fy: fy ?? cy,
        };
	}
    #end
	
	public function clone() : RadialFill
	{
		return new RadialFill(colors.copy(), ratios.copy(), cx, cy, r, fx, fy);
	}
	
	public function applyAlpha(alpha:Float) : Void
	{
		for (i in 0...colors.length)
		{
			var rgba = ColorTools.parse(colors[i]);
			rgba.a *= alpha;
			colors[i] = ColorTools.rgbaToString(rgba);
		}
	}
	
	@:noapi
	public function getTyped() return TypedFill.radial(this);
	
	public function begin(g:ShapeRender)
	{
		g.beginRadialGradientFill(colors, ratios, fx, fy, 0, cx, cy, r);
	}
	
	public function equ(e:IFill) : Bool
	{
		if (e == this) return true;
		if (Std.isOfType(e, RadialFill))
		{
			var ee : RadialFill = cast e;
			return arrEqu(ee.colors, colors)
				&& arrEqu(ee.ratios, ratios)
				&& ee.cx == cx
				&& ee.cy == cy
				&& ee.r == r
				&& ee.fx == fx
				&& ee.fy == fy;
		}
		return false;
	}
	
	function arrEqu<T>(a:Array<T>, b:Array<T>) : Bool
	{
		if (a.length != b.length) return false;
		for (i in 0...a.length) if (a[i] != b[i]) return false;
		return true;
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String) { }
	
	public function setLibrary(library:Library) {}
	
    public function getTransformed(m:Matrix) : IFill
	{
		var fill = clone();
		
		var c = m.transformPoint(cx, cy);
		fill.cx = c.x;
		fill.cy = c.y;
		
		var f = m.transformPoint(fx, fy);
		fill.fx = f.x;
		fill.fy = f.y;
		
		fill.r *= m.getAverageScale();
		
		return fill;
	}
	
	public function toString() : String
	{
		return 'new RadialFill($colors, $ratios, $cx, $cy, $r, $fx, $fy)';
	}
}
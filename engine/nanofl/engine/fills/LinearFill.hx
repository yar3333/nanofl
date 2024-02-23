package nanofl.engine.fills;

import nanofl.engine.geom.Matrix;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class LinearFill extends BaseFill implements IFill
{
	public var colors : Array<String>;
	public var ratios : Array<Float>;
	public var x0 : Float;
	public var y0 : Float;
	public var x1 : Float;
	public var y1 : Float;
	
	public function new(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float)
	{
		this.colors = colors;
		this.ratios = ratios;
		this.x0 = x0;
		this.y0 = y0;
		this.x1 = x1;
		this.y1 = y1;
    }
	
    #if ide
	public static function load(node:HtmlNodeElement, version:String)
	{
		return Version.handle(version,
		[
			"1.0.0" => function()
			{
				var matrix = Matrix.load(node);
				var pt0 = matrix.transformPoint(-1, 0);
				var pt1 = matrix.transformPoint( 1, 0);
				
				return new LinearFill
				(
					node.getAttr("colors", []),
					node.getAttr("ratios", [0.0]),
					node.getAttr("x0", pt0.x),
					node.getAttr("y0", pt0.y),
					node.getAttr("x1", pt1.x),
					node.getAttr("y1", pt1.y)
				);
			},
			
			"2.0.0" => function()
			{
				return new LinearFill
				(
					node.getAttr("colors", []),
					node.getAttr("ratios", [0.0]),
					node.getAttr("x0", 0.0),
					node.getAttr("y0", 0.0),
					node.getAttr("x1", 0.0),
					node.getAttr("y1", 0.0)
				);
			}
		]);
	}
    #end

	public static function loadJson(obj:Dynamic, version:String)
    {
        return new LinearFill
        (
            (cast obj.colors : Array<String>) ?? [],
            (cast obj.ratios : Array<Float>) ?? [0.0],
            obj.x0 ?? 0.0,
            obj.y0 ?? 0.0,
            obj.x1 ?? 0.0,
            obj.y1 ?? 0.0,
        );
    }    
	
    #if ide
	public function save(out:XmlBuilder)
	{
		out.begin("fill").attr("type", "linear");
		out.attr("colors", colors);
		out.attr("ratios", ratios);
		out.attr("x0", x0);
		out.attr("y0", y0);
		out.attr("x1", x1);
		out.attr("y1", y1);
		out.end();
	}

    public function saveJson()
    {
        return 
        {
            type: "linear",
            colors: colors,
            ratios: ratios,
            x0: x0,
            y0: y0,
            x1: x1,
            y1: y1,
        };
    }
    #end
	
	public function clone() : LinearFill
	{
		return new LinearFill(colors.copy(), ratios.copy(), x0, y0, x1, y1);
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
	public function getTyped() return TypedFill.linear(this);
	
	public function begin(g:ShapeRender)
	{
		g.beginLinearGradientFill(colors, ratios, x0, y0, x1, y1);
	}
	
	public function equ(e:IFill) : Bool
	{
		if (e == this) return true;
		if (Std.isOfType(e, LinearFill))
		{
			var ee : LinearFill = cast e;
			return arrEqu(ee.colors, colors)
				&& arrEqu(ee.ratios, ratios)
				&& ee.x0 == x0
				&& ee.y0 == y0
				&& ee.x1 == x1
				&& ee.y1 == y1;
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
		var r = clone();
		
		var p0 = m.transformPoint(x0, y0);
		r.x0 = p0.x;
		r.y0 = p0.y;
		
		var p1 = m.transformPoint(x1, y1);
		r.x1 = p1.x;
		r.y1 = p1.y;
		
		return r;
	}
	
	public function toString() : String
	{
		return 'new LinearFill(' + colors.map(s -> '"' + s + '"') + ', $ratios, $x0, $y0, $x1, $y1)';
	}
}
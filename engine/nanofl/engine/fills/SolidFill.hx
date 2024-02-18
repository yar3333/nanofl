package nanofl.engine.fills;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
import nanofl.engine.geom.Matrix;
using htmlparser.HtmlParserTools;

class SolidFill extends BaseFill implements IFill
{
	public var color : String;
	
	public function new(color:String)
	{
		this.color = color;
	}
	
	public static function load(node:HtmlNodeElement, version:String)
	{
		return new SolidFill(node.getAttr("color", "#000000"));
	}
	
	public static function loadJson(obj:Dynamic, version:String) : Dynamic
	{
		return new SolidFill(obj.color ?? "#000000");
	}
	
	public function save(out:XmlBuilder)
	{
		out.begin("fill").attr("type", "solid");
		out.attr("color", color);
		out.end();
	}
	
	public function saveJson()
	{
        return 
        {
            type: "solid",
            color: color,
        };
	}
	
	public function clone() : SolidFill
	{
		return new SolidFill(color);
	}
	
	public function applyAlpha(alpha:Float) : Void
	{
		var rgba = ColorTools.parse(color);
		rgba.a *= alpha;
		color = ColorTools.rgbaToString(rgba);
	}
	
	public function setLibrary(library:Library) {}
	
    public function getTransformed(m:Matrix) : IFill return this;
	
	@:noapi
	public function getTyped() return TypedFill.solid(this);
	
	public function begin(g:ShapeRender)
	{
		g.beginFill(color);
	}
	
	public function equ(e:IFill) : Bool
	{
		if (e == this) return true;
		if (Std.isOfType(e, SolidFill))
		{
			var ee : SolidFill = cast e;
			return ee.color == color;
		}
		return false;
	}
	
	public function swapInstance(oldNamePath:String, newNamePath:String) { }
	
	public function toString() : String
	{
		return 'new SolidFill("$color")';
	}
}
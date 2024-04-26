package nanofl.engine.coloreffects;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class ColorEffectTint extends ColorEffect
{
	public var color : String;
	public var multiplier : Float;
	
	public function new(color:String, multiplier:Float)
	{
		this.color = color;
		this.multiplier = multiplier;
	}
	
    #if ide
	public static function load(node:HtmlNodeElement) : ColorEffectTint
	{
		return new ColorEffectTint(node.getAttr("color"), node.getAttr("multiplier", 1.0));
	}
    #end
	
	public static function loadJson(obj:Dynamic) : ColorEffectTint
	{
		return new ColorEffectTint(obj.color, obj.multiplier ?? 1.0);
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
		out.begin("color").attr("type", "tint");
		out.attr("color", color);
		out.attr("multiplier", multiplier);
		out.end();
	}
	
	public function saveJson()
	{
        return
        {
            type: "tint",
            color: color,
            multiplier: multiplier,
        };
	}
    #end
	
	public function apply(obj:easeljs.display.DisplayObject)
	{
		final rgb = ColorTools.parse(color);
		
		obj.filters.push
		(
			new easeljs.filters.ColorFilter
			(
				1 - multiplier,
				1 - multiplier,
				1 - multiplier,
				1,
				rgb.r * multiplier,
				rgb.g * multiplier,
				rgb.b * multiplier,
				0
			)
		);
	}
	
	public function clone() : ColorEffectTint
	{
		return new ColorEffectTint(color, multiplier);
	}
	
	public function getNeutralClone() : ColorEffectTint
	{
		return new ColorEffectTint(color, 0);
	}
	
	public function getTweened(k:Float, finish:ColorEffect) : ColorEffectTint
	{
		return new ColorEffectTint
		(
			ColorTools.getTweened(color, k, cast(finish, ColorEffectTint).color),
			multiplier + (cast(finish, ColorEffectTint).multiplier - multiplier) * k
		);
	}
	
	public function equ(c:ColorEffect) : Bool
	{
		return Std.isOfType(c, ColorEffectTint)
			&& color == (cast c:ColorEffectTint).color
			&& multiplier == (cast c:ColorEffectTint).multiplier;
	}
}

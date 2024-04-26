package nanofl.engine.coloreffects;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class ColorEffectBrightness extends ColorEffect
{
	public var value : Float;
	
	public function new(value:Float)
	{
		this.value = value;
	}
	
    #if ide
	public static function load(node:HtmlNodeElement) : ColorEffectBrightness
	{
		return new ColorEffectBrightness(node.getAttr("value", 0.0));
	}
    #end
	
	public static function loadJson(obj:Dynamic) : ColorEffectBrightness
	{
		return new ColorEffectBrightness(obj.value ?? 0.0);
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
		out.begin("color").attr("type", "brightness");
		out.attr("value", value);
		out.end();
	}
	
	public function saveJson()
	{
        return
        {
            type: "brightness",
            value: value,
        };
	}
    #end
	
	public function apply(obj:easeljs.display.DisplayObject)
	{
		if (value > 0)
		{
			obj.filters.push(new easeljs.filters.ColorFilter(1, 1, 1, 1, value*255, value*255, value*255, 0));
		}
		else
		if (value < 0)
		{
			obj.filters.push(new easeljs.filters.ColorFilter(1 + value, 1 + value, 1 + value, 1, 0, 0, 0, 0));
		}
	}
	
	public function clone() : ColorEffectBrightness
	{
		return new ColorEffectBrightness(value);
	}
	
	public function getNeutralClone() : ColorEffectBrightness
	{
		return new ColorEffectBrightness(0);
	}
	
	public function getTweened(k:Float, finish:ColorEffect) : ColorEffectBrightness
	{
		return new ColorEffectBrightness(value + (cast(finish, ColorEffectBrightness).value - value) * k);
	}
	
	public function equ(c:ColorEffect) : Bool
	{
		return Std.isOfType(c, ColorEffectBrightness)
			&& value == (cast c:ColorEffectBrightness).value;
	}
}

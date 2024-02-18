package nanofl.engine.coloreffects;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;

class ColorEffectAlpha extends ColorEffect
{
	public var value : Float;
	
	public function new(value:Float)
	{
		this.value = value;
	}
	
    #if ide
	public static function load(node:HtmlNodeElement) : ColorEffectAlpha
	{
		return new ColorEffectAlpha(node.getAttr("value", 1.0));
	}
    #end
	
	public static function loadJson(obj:Dynamic) : ColorEffectAlpha
	{
		return new ColorEffectAlpha(obj.value ?? 1.0);
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
		out.begin("color").attr("type", "alpha");
		out.attr("value", value);
		out.end();
	}
	
	public function saveJson()
	{
		return 
        {
            type: "alpha",
		    value: value,
        };
	}
    #end
	
	public function apply(obj:easeljs.display.DisplayObject)
	{
		obj.alpha = value;
	}
	
	public function clone() : ColorEffectAlpha
	{
		return new ColorEffectAlpha(value);
	}
	
	public function getNeutralClone() : ColorEffectAlpha
	{
		return new ColorEffectAlpha(1);
	}
	
	public function getTweened(k:Float, finish:ColorEffect) : ColorEffectAlpha
	{
		return new ColorEffectAlpha(value + (cast(finish, ColorEffectAlpha).value - value) * k);
	}
	
	public function equ(c:ColorEffect) : Bool
	{
		return Std.isOfType(c, ColorEffectAlpha)
			&& value == (cast c:ColorEffectAlpha).value;
	}
}

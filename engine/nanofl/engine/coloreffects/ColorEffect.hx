package nanofl.engine.coloreffects;

import htmlparser.HtmlNodeElement;
import nanofl.engine.coloreffects.ColorEffectAdvanced;
import nanofl.engine.coloreffects.ColorEffectAlpha;
import nanofl.engine.coloreffects.ColorEffectBrightness;
import nanofl.engine.coloreffects.ColorEffectTint;
import htmlparser.XmlBuilder;
import stdlib.Debug;
using htmlparser.HtmlParserTools;
using Lambda;

abstract class ColorEffect
{
	public abstract function apply(obj:easeljs.display.DisplayObject) : Void;
	public abstract function clone() : ColorEffect;
	public abstract function getNeutralClone() : ColorEffect;
	public abstract function getTweened(k:Float, finish:ColorEffect) : ColorEffect;
	
    #if ide
	public abstract function save(out:XmlBuilder) : Void;
	public abstract function saveJson() : { type:String };
	#end
    
    public abstract function equ(c:ColorEffect) : Bool;
	
	#if ide
    public static function load(node:HtmlNodeElement) : ColorEffect
	{
		if (node != null)
		{
			Debug.assert(node.name == "color", node.name);
			switch (node.getAttribute("type"))
			{
				case "brightness":	return ColorEffectBrightness.load(node);
				case "tint":		return ColorEffectTint.load(node);
				case "advanced":	return ColorEffectAdvanced.load(node);
				case "alpha":		return ColorEffectAlpha.load(node);
				//case "double":		return ColorEffectDouble.load(node);
			}
		}
		return null;
	}
    #end
	
	public static function loadJson(obj:Dynamic) : ColorEffect
	{
        return switch (obj?.type)
        {
            case "brightness":  ColorEffectBrightness.loadJson(obj);
            case "tint":	    ColorEffectTint.loadJson(obj);
            case "advanced":    ColorEffectAdvanced.loadJson(obj);
            case "alpha":		ColorEffectAlpha.loadJson(obj);
            //case "double":		ColorEffectDouble.loadJson(obj);
            case _: null;
        };
	}
}
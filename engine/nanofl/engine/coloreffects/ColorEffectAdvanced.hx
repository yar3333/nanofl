package nanofl.engine.coloreffects;

import nanofl.engine.coloreffects.ColorEffect;
using Lambda;

#if ide
import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;
using htmlparser.HtmlParserTools;
#end

class ColorEffectAdvanced extends ColorEffect
{
	public var redMultiplier : Float;
	public var greenMultiplier : Float;
	public var blueMultiplier : Float;
	public var alphaMultiplier : Float;
	public var redOffset : Float;
	public var greenOffset : Float;
	public var blueOffset : Float;
	public var alphaOffset : Float;
	
	public function new(alphaMultiplier:Float, redMultiplier:Float, greenMultiplier:Float, blueMultiplier:Float, alphaOffset:Float, redOffset:Float, greenOffset:Float, blueOffset:Float)
	{
		this.alphaMultiplier = alphaMultiplier;
		this.redMultiplier = redMultiplier;
		this.greenMultiplier = greenMultiplier;
		this.blueMultiplier = blueMultiplier;
		this.alphaOffset = alphaOffset;
		this.redOffset = redOffset;
		this.greenOffset = greenOffset;
		this.blueOffset = blueOffset;
	}
	
    #if ide
	public static function load(node:HtmlNodeElement) : ColorEffectAdvanced
	{
		return new ColorEffectAdvanced
		(
			node.getAttr("alphaMultiplier", 1.0),
			node.getAttr("redMultiplier", 1.0),
			node.getAttr("greenMultiplier", 1.0),
			node.getAttr("blueMultiplier", 1.0),
			node.getAttr("alphaOffset", 0.0),
			node.getAttr("redOffset", 0.0),
			node.getAttr("greenOffset", 0.0),
			node.getAttr("blueOffset", 0.0)
		);
	}
    #end
	
	public static function loadJson(obj:Dynamic) : ColorEffectAdvanced
	{
		return new ColorEffectAdvanced
		(
			obj.alphaMultiplier ?? 1.0,
			obj.redMultiplier ?? 1.0,
			obj.greenMultiplier ?? 1.0,
			obj.blueMultiplier ?? 1.0,
			obj.alphaOffset ?? 0.0,
			obj.redOffset ?? 0.0,
			obj.greenOffset ?? 0.0,
			obj.blueOffset ?? 0.0,
		);
	}
	
    #if ide
	public function save(out:XmlBuilder)
	{
		out.begin("color").attr("type", "advanced");
		out.attr("alphaMultiplier", alphaMultiplier);
		out.attr("redMultiplier", redMultiplier);
		out.attr("greenMultiplier", greenMultiplier);
		out.attr("blueMultiplier", blueMultiplier);
		out.attr("alphaOffset", alphaOffset);
		out.attr("redOffset", redOffset);
		out.attr("greenOffset", greenOffset);
		out.attr("blueOffset", blueOffset);
		out.end();
	}
	
	public function saveJson()
	{
        return
        {
            type: "advanced",
            alphaMultiplier: alphaMultiplier,
            redMultiplier: redMultiplier,
            greenMultiplier: greenMultiplier,
            blueMultiplier: blueMultiplier,
            alphaOffset: alphaOffset,
            redOffset: redOffset,
            greenOffset: greenOffset,
            blueOffset: blueOffset,
        };
	}
    #end
	
	public function apply(obj:easeljs.display.DisplayObject)
	{
		if (obj.filters == null) obj.filters = [];
		
		obj.filters.push(new easeljs.filters.ColorFilter(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier, redOffset, greenOffset, blueOffset, alphaOffset));
	}
	
	public function clone() : ColorEffectAdvanced
	{
		return new ColorEffectAdvanced
		(
			alphaMultiplier,
			redMultiplier,
			greenMultiplier,
			blueMultiplier,
			alphaOffset,
			redOffset,
			greenOffset,
			blueOffset
		);
	}
	
	public function getNeutralClone() : ColorEffectAdvanced
	{
		return new ColorEffectAdvanced(1, 1, 1, 1, 0, 0, 0, 0);
	}
	
	public function getTweened(k:Float, finish:ColorEffect) : ColorEffectAdvanced
	{
		stdlib.Debug.assert(Std.isOfType(finish, ColorEffectAdvanced));
		return new ColorEffectAdvanced
		(
			alphaMultiplier + ((cast finish:ColorEffectAdvanced).alphaMultiplier - alphaMultiplier) * k,
			redMultiplier + ((cast finish:ColorEffectAdvanced).redMultiplier - redMultiplier) * k,
			greenMultiplier + ((cast finish:ColorEffectAdvanced).greenMultiplier - greenMultiplier) * k,
			blueMultiplier + ((cast finish:ColorEffectAdvanced).blueMultiplier - blueMultiplier) * k,
			alphaOffset + ((cast finish:ColorEffectAdvanced).alphaOffset - alphaOffset) * k,
			redOffset + ((cast finish:ColorEffectAdvanced).redOffset - redOffset) * k,
			greenOffset + ((cast finish:ColorEffectAdvanced).greenOffset - greenOffset) * k,
			blueOffset + ((cast finish:ColorEffectAdvanced).blueOffset - blueOffset) * k
		);
	}
	
	public function equ(c:ColorEffect) : Bool
	{
		return Std.isOfType(c, ColorEffectAdvanced)
			&& redMultiplier == (cast c:ColorEffectAdvanced).redMultiplier
			&& greenMultiplier == (cast c:ColorEffectAdvanced).greenMultiplier
			&& blueMultiplier == (cast c:ColorEffectAdvanced).blueMultiplier
			&& alphaMultiplier == (cast c:ColorEffectAdvanced).alphaMultiplier
			&& redOffset == (cast c:ColorEffectAdvanced).redOffset
			&& greenOffset == (cast c:ColorEffectAdvanced).greenOffset
			&& blueOffset == (cast c:ColorEffectAdvanced).blueOffset
			&& alphaOffset == (cast c:ColorEffectAdvanced).alphaOffset;
	}
}

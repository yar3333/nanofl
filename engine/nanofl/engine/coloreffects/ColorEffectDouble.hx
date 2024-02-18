package nanofl.engine.coloreffects;

import htmlparser.HtmlNodeElement;
import htmlparser.XmlBuilder;

/**
    Special effect, used internally for MotionTween.
**/
class ColorEffectDouble extends ColorEffect
{
	var effect0 : ColorEffect;
	var effect1 : ColorEffect;
	
	public function new(effect0:ColorEffect, effect1:ColorEffect)
	{
		this.effect0 = effect0;
		this.effect1 = effect1;
	}
	
	public function apply(obj:easeljs.display.DisplayObject)
	{
		effect0.apply(obj);
		effect1.apply(obj);
	}
	
	public function equ(c:ColorEffect) : Bool
	{
		return Std.isOfType(c, ColorEffectDouble)
			&& effect0.equ((cast c:ColorEffectDouble).effect0)
			&& effect1.equ((cast c:ColorEffectDouble).effect1);
	}

	//public static function load(node:HtmlNodeElement) : ColorEffectDouble
    //{
        //return new ColorEffectDouble(ColorEffect.load(node.children[0]), ColorEffect.load(node.children[1]));
    //}    

	//public static function loadJson(obj:Dynamic) : ColorEffectDouble
    //{
        //return new ColorEffectDouble(ColorEffect.loadJson(obj.effect0), ColorEffect.loadJson(obj.effect1));
    //}    
    
    #if ide
    public function save(out:XmlBuilder)
    {
		//out.begin("color").attr("type", "double");
        //effect0.save(out);
        //effect1.save(out);
		//out.end();
        return stdlib.Debug.methodNotSupported(this);
    }
	
	public function saveJson()
    {
        //return
        //{
        //    type: "double",
        //    effect0: effect0.saveJson(),
        //    effect1: effect1.saveJson(),
        //};
        return stdlib.Debug.methodNotSupported(this);
    }
    #end
    
    public function clone() : ColorEffectDouble
    {
        return new ColorEffectDouble(effect0.clone(), effect1.clone());
    }

    public function getNeutralClone() : ColorEffect
    {
        return new ColorEffectDouble(effect0.getNeutralClone(), effect1.getNeutralClone());
    }

    public function getTweened(k:Float, finish:ColorEffect) : ColorEffect
    {
        return new ColorEffectDouble
        (
            effect0.getTweened(k, (cast finish : ColorEffectDouble).effect0),
            effect1.getTweened(k, (cast finish : ColorEffectDouble).effect1),
        );
    }
}
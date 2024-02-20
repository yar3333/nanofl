package nanofl.engine.coloreffects;

/**
 Special effect, used internally for MotionTween.
 */
/**
	
	    Special effect, used internally for MotionTween.
	
**/
extern class ColorEffectDouble extends nanofl.engine.coloreffects.ColorEffect {
	function new(effect0:nanofl.engine.coloreffects.ColorEffect, effect1:nanofl.engine.coloreffects.ColorEffect):Void;
	override function apply(obj:easeljs.display.DisplayObject):Void;
	override function equ(c:nanofl.engine.coloreffects.ColorEffect):Bool;
	override function save(out:htmlparser.XmlBuilder):Void;
	override function saveJson():{ var type : String; };
	override function clone():nanofl.engine.coloreffects.ColorEffectDouble;
	override function getNeutralClone():nanofl.engine.coloreffects.ColorEffect;
	override function getTweened(k:Float, finish:nanofl.engine.coloreffects.ColorEffect):nanofl.engine.coloreffects.ColorEffect;
}
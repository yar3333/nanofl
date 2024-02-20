package nanofl.engine.coloreffects;

extern class ColorEffectAdvanced extends nanofl.engine.coloreffects.ColorEffect {
	function new(alphaMultiplier:Float, redMultiplier:Float, greenMultiplier:Float, blueMultiplier:Float, alphaOffset:Float, redOffset:Float, greenOffset:Float, blueOffset:Float):Void;
	var redMultiplier : Float;
	var greenMultiplier : Float;
	var blueMultiplier : Float;
	var alphaMultiplier : Float;
	var redOffset : Float;
	var greenOffset : Float;
	var blueOffset : Float;
	var alphaOffset : Float;
	override function save(out:htmlparser.XmlBuilder):Void;
	override function saveJson():{ var alphaMultiplier : Float; var alphaOffset : Float; var blueMultiplier : Float; var blueOffset : Float; var greenMultiplier : Float; var greenOffset : Float; var redMultiplier : Float; var redOffset : Float; var type : String; };
	override function apply(obj:easeljs.display.DisplayObject):Void;
	override function clone():nanofl.engine.coloreffects.ColorEffectAdvanced;
	override function getNeutralClone():nanofl.engine.coloreffects.ColorEffectAdvanced;
	override function getTweened(k:Float, finish:nanofl.engine.coloreffects.ColorEffect):nanofl.engine.coloreffects.ColorEffectAdvanced;
	override function equ(c:nanofl.engine.coloreffects.ColorEffect):Bool;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.coloreffects.ColorEffectAdvanced;
	static function loadJson(obj:Dynamic):nanofl.engine.coloreffects.ColorEffectAdvanced;
}
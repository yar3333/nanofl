package nanofl.engine.coloreffects;

extern class ColorEffectBrightness extends nanofl.engine.coloreffects.ColorEffect {
	function new(value:Float):Void;
	var value : Float;
	override function save(out:htmlparser.XmlBuilder):Void;
	override function saveJson():{ var type : String; var value : Float; };
	override function apply(obj:easeljs.display.DisplayObject):Void;
	override function clone():nanofl.engine.coloreffects.ColorEffectBrightness;
	override function getNeutralClone():nanofl.engine.coloreffects.ColorEffectBrightness;
	override function getTweened(k:Float, finish:nanofl.engine.coloreffects.ColorEffect):nanofl.engine.coloreffects.ColorEffectBrightness;
	override function equ(c:nanofl.engine.coloreffects.ColorEffect):Bool;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.coloreffects.ColorEffectBrightness;
	static function loadJson(obj:Dynamic):nanofl.engine.coloreffects.ColorEffectBrightness;
}
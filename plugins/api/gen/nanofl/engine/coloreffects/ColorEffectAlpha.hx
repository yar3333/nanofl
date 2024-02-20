package nanofl.engine.coloreffects;

extern class ColorEffectAlpha extends nanofl.engine.coloreffects.ColorEffect {
	function new(value:Float):Void;
	var value : Float;
	override function save(out:htmlparser.XmlBuilder):Void;
	override function saveJson():{ var type : String; var value : Float; };
	override function apply(obj:easeljs.display.DisplayObject):Void;
	override function clone():nanofl.engine.coloreffects.ColorEffectAlpha;
	override function getNeutralClone():nanofl.engine.coloreffects.ColorEffectAlpha;
	override function getTweened(k:Float, finish:nanofl.engine.coloreffects.ColorEffect):nanofl.engine.coloreffects.ColorEffectAlpha;
	override function equ(c:nanofl.engine.coloreffects.ColorEffect):Bool;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.coloreffects.ColorEffectAlpha;
	static function loadJson(obj:Dynamic):nanofl.engine.coloreffects.ColorEffectAlpha;
}
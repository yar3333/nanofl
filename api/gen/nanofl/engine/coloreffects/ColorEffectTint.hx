package nanofl.engine.coloreffects;

extern class ColorEffectTint extends nanofl.engine.coloreffects.ColorEffect {
	function new(color:String, multiplier:Float):Void;
	var color : String;
	var multiplier : Float;
	override function save(out:htmlparser.XmlBuilder):Void;
	override function saveJson():{ var color : String; var multiplier : Float; var type : String; };
	override function apply(obj:easeljs.display.DisplayObject):Void;
	override function clone():nanofl.engine.coloreffects.ColorEffectTint;
	override function getNeutralClone():nanofl.engine.coloreffects.ColorEffectTint;
	override function getTweened(k:Float, finish:nanofl.engine.coloreffects.ColorEffect):nanofl.engine.coloreffects.ColorEffectTint;
	override function equ(c:nanofl.engine.coloreffects.ColorEffect):Bool;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.coloreffects.ColorEffectTint;
	static function loadJson(obj:Dynamic):nanofl.engine.coloreffects.ColorEffectTint;
}
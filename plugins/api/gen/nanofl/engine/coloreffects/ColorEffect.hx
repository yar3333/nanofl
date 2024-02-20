package nanofl.engine.coloreffects;

extern class ColorEffect {
	function apply(obj:easeljs.display.DisplayObject):Void;
	function clone():nanofl.engine.coloreffects.ColorEffect;
	function getNeutralClone():nanofl.engine.coloreffects.ColorEffect;
	function getTweened(k:Float, finish:nanofl.engine.coloreffects.ColorEffect):nanofl.engine.coloreffects.ColorEffect;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():{ var type : String; };
	function equ(c:nanofl.engine.coloreffects.ColorEffect):Bool;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.coloreffects.ColorEffect;
	static function loadJson(obj:Dynamic):nanofl.engine.coloreffects.ColorEffect;
}
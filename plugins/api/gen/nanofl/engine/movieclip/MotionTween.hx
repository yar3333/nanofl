package nanofl.engine.movieclip;

extern class MotionTween {
	function new(easing:Int, orientToPath:Bool, rotateCount:Int, rotateCountX:Int, rotateCountY:Int, directionalLightRotateCountX:Int, directionalLightRotateCountY:Int):Void;
	var keyFrame : nanofl.engine.movieclip.KeyFrame;
	var easing : Int;
	var orientToPath : Bool;
	var rotateCount : Int;
	var rotateCountX : Int;
	var rotateCountY : Int;
	var directionalLightRotateCountX : Int;
	var directionalLightRotateCountY : Int;
	function apply(frameSubIndex:Int):Array<nanofl.engine.movieclip.TweenedElement>;
	function getInstancesMap():js.lib.Map<nanofl.engine.elements.Instance, nanofl.engine.elements.Instance>;
	function isGood():Bool;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():Dynamic;
	function clone():nanofl.engine.movieclip.MotionTween;
	function equ(_motionTween:nanofl.engine.movieclip.MotionTween):Bool;
	static function load(node:htmlparser.HtmlNodeElement):nanofl.engine.movieclip.MotionTween;
	static function loadJson(obj:Dynamic):nanofl.engine.movieclip.MotionTween;
}
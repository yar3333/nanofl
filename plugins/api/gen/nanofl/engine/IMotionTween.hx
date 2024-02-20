package nanofl.engine;

interface IMotionTween {
	function isGood():Bool;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():Dynamic;
	function equ(x:nanofl.engine.IMotionTween):Bool;
	function apply(frameSubIndex:Int):Array<nanofl.engine.movieclip.TweenedElement>;
	function clone():nanofl.engine.IMotionTween;
}
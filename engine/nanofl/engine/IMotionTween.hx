package nanofl.engine;

import nanofl.engine.movieclip.TweenedElement;

interface IMotionTween
{
	function isGood() : Bool;
	
    #if ide
    function save(out:htmlparser.XmlBuilder) : Void;
    function saveJson() : Dynamic;
	#end
	
    function equ(x:IMotionTween) : Bool;
	function apply(frameSubIndex:Int) : Array<TweenedElement>;
	function clone() : IMotionTween;
}
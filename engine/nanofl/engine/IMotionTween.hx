package nanofl.engine;

import nanofl.engine.movieclip.TweenedElement;
import htmlparser.XmlBuilder;

interface IMotionTween
{
	function isGood() : Bool;
	
    #if ide
    function save(out:XmlBuilder) : Void;
    function saveJson() : Dynamic;
	#end
	
    function equ(x:IMotionTween) : Bool;
	function apply(frameSubIndex:Int) : Array<TweenedElement>;
	function clone() : IMotionTween;
}
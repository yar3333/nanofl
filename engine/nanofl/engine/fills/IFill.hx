package nanofl.engine.fills;

import nanofl.engine.geom.Matrix;

interface IFill
{
	function begin(g:ShapeRender) : Void;
	function clone() : IFill;
	function equ(e:IFill) : Bool;
	function applyAlpha(alpha:Float) : Void;
	function getTransformed(m:Matrix) : IFill;
	@:noapi function getTyped() : TypedFill;
	#if ide
    function save(out:htmlparser.XmlBuilder) : Void;
	function saveJson() : { type:String };
    #end
	function swapInstance(oldNamePath:String, newNamePath:String) : Void;
	function setLibrary(library:Library) : Void;
	function toString() : String;
}

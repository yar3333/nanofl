package nanofl.engine.fills;

import htmlparser.XmlBuilder;
import nanofl.engine.geom.Matrix;

interface IFill
{
	function begin(g:ShapeRender) : Void;
	function clone() : IFill;
	function equ(e:IFill) : Bool;
	function applyAlpha(alpha:Float) : Void;
	function getTransformed(m:Matrix) : IFill;
	@:noapi function getTyped() : TypedFill;
	function save(out:XmlBuilder) : Void;
	function saveJson() : { type:String };
	function swapInstance(oldNamePath:String, newNamePath:String) : Void;
	function setLibrary(library:Library) : Void;
	function toString() : String;
}

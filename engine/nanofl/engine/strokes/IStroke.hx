package nanofl.engine.strokes;

import htmlparser.XmlBuilder;
import nanofl.engine.geom.Matrix;
import nanofl.engine.Library;

interface IStroke
{
	var thickness : Float;
	var caps : String;
	var joints : String;
	var miterLimit : Float;
	var ignoreScale : Bool;
	
	function begin(g:ShapeRender) : Void;
	function clone() : IStroke;
	function equ(e:IStroke) : Bool;
	function applyAlpha(alpha:Float) : Void;
	function getTransformed(m:Matrix, applyToThickness:Bool) : IStroke;
	@:noapi function getTyped() : TypedStroke;
	function save(out:XmlBuilder) : Void;
	function saveJson() : Dynamic;
	function swapInstance(oldNamePath:String, newNamePath:String) : Void;
	function setLibrary(library:Library) : Void;
	function toString() : String;
}

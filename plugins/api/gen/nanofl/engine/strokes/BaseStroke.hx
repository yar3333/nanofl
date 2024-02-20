package nanofl.engine.strokes;

extern class BaseStroke {
	var thickness : Float;
	/**
		
			 *  butt, round, or square. Easeljs's default is butt.
			 
	**/
	var caps : String;
	/**
		
			 * bevel, round, or miter. Easeljs's default is miter.
			 
	**/
	var joints : String;
	/**
		
			 * Miter limit ratio which controls at what point a mitered joint will be clipped. Easeljs's default is 10.
			 
	**/
	var miterLimit : Float;
	var ignoreScale : Bool;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():{ var type : String; };
	function clone():nanofl.engine.strokes.IStroke;
	function equ(e:nanofl.engine.strokes.IStroke):Bool;
	function setLibrary(library:nanofl.engine.Library):Void;
	function getTransformed(m:nanofl.engine.geom.Matrix, applyToThickness:Bool):nanofl.engine.strokes.IStroke;
	static function load(node:htmlparser.HtmlNodeElement, version:String):nanofl.engine.strokes.IStroke;
	static function loadJson(obj:{ var type : String; }, version:String):nanofl.engine.strokes.IStroke;
}
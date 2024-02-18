package nanofl.engine.fills;

extern class LinearFill extends nanofl.engine.fills.BaseFill implements nanofl.engine.fills.IFill {
	function new(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float):Void;
	var colors : Array<String>;
	var ratios : Array<Float>;
	var x0 : Float;
	var y0 : Float;
	var x1 : Float;
	var y1 : Float;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():{ var colors : Array<String>; var ratios : Array<Float>; var type : String; var x0 : Float; var x1 : Float; var y0 : Float; var y1 : Float; };
	function clone():nanofl.engine.fills.LinearFill;
	function applyAlpha(alpha:Float):Void;
	function begin(g:nanofl.engine.ShapeRender):Void;
	function equ(e:nanofl.engine.fills.IFill):Bool;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	override function setLibrary(library:nanofl.engine.Library):Void;
	function getTransformed(m:nanofl.engine.geom.Matrix):nanofl.engine.fills.IFill;
	function toString():String;
	static function load(node:htmlparser.HtmlNodeElement, version:String):nanofl.engine.fills.LinearFill;
	static function loadJson(obj:Dynamic, version:String):nanofl.engine.fills.LinearFill;
}
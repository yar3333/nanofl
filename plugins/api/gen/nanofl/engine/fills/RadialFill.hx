package nanofl.engine.fills;

extern class RadialFill extends nanofl.engine.fills.BaseFill implements nanofl.engine.fills.IFill {
	function new(colors:Array<String>, ratios:Array<Float>, cx:Float, cy:Float, r:Float, fx:Float, fy:Float):Void;
	var colors : Array<String>;
	var ratios : Array<Float>;
	var cx : Float;
	var cy : Float;
	var r : Float;
	var fx : Float;
	var fy : Float;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():{ var colors : Array<String>; var cx : Float; var cy : Float; var fx : Float; var fy : Float; var r : Float; var ratios : Array<Float>; var type : String; };
	function clone():nanofl.engine.fills.RadialFill;
	function applyAlpha(alpha:Float):Void;
	function begin(g:nanofl.engine.ShapeRender):Void;
	function equ(e:nanofl.engine.fills.IFill):Bool;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	override function setLibrary(library:nanofl.engine.Library):Void;
	function getTransformed(m:nanofl.engine.geom.Matrix):nanofl.engine.fills.IFill;
	function toString():String;
	static function load(node:htmlparser.HtmlNodeElement, version:String):nanofl.engine.fills.RadialFill;
	static function loadJson(obj:Dynamic, version:String):nanofl.engine.fills.RadialFill;
}
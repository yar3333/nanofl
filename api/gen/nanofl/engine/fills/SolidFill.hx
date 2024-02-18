package nanofl.engine.fills;

extern class SolidFill extends nanofl.engine.fills.BaseFill implements nanofl.engine.fills.IFill {
	function new(color:String):Void;
	var color : String;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():{ var color : String; var type : String; };
	function clone():nanofl.engine.fills.SolidFill;
	function applyAlpha(alpha:Float):Void;
	override function setLibrary(library:nanofl.engine.Library):Void;
	function getTransformed(m:nanofl.engine.geom.Matrix):nanofl.engine.fills.IFill;
	function begin(g:nanofl.engine.ShapeRender):Void;
	function equ(e:nanofl.engine.fills.IFill):Bool;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	function toString():String;
	static function load(node:htmlparser.HtmlNodeElement, version:String):nanofl.engine.fills.SolidFill;
	static function loadJson(obj:Dynamic, version:String):Dynamic;
}
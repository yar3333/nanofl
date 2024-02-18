package nanofl.engine.fills;

extern class SelectionFill extends nanofl.engine.fills.BaseFill implements nanofl.engine.fills.IFill {
	function new(scale:Float):Void;
	function save(out:htmlparser.XmlBuilder):Void;
	function saveJson():{ var type : String; };
	function clone():nanofl.engine.fills.SelectionFill;
	function applyAlpha(alpha:Float):Void;
	override function setLibrary(library:nanofl.engine.Library):Void;
	function getTransformed(m:nanofl.engine.geom.Matrix):nanofl.engine.fills.IFill;
	function begin(g:nanofl.engine.ShapeRender):Void;
	function equ(e:nanofl.engine.fills.IFill):Bool;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	function toString():String;
}
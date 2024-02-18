package nanofl.engine.strokes;

extern class LinearStroke extends nanofl.engine.strokes.BaseStroke implements nanofl.engine.strokes.IStroke {
	function new(colors:Array<String>, ratios:Array<Float>, x0:Float, y0:Float, x1:Float, y1:Float, ?thickness:Float, ?caps:String, ?joints:String, ?miterLimit:Float, ?ignoreScale:Bool):Void;
	var colors : Array<String>;
	var ratios : Array<Float>;
	var x0 : Float;
	var y0 : Float;
	var x1 : Float;
	var y1 : Float;
	function begin(g:nanofl.engine.ShapeRender):Void;
	override function clone():nanofl.engine.strokes.LinearStroke;
	override function equ(e:nanofl.engine.strokes.IStroke):Bool;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	function applyAlpha(alpha:Float):Void;
	override function getTransformed(m:nanofl.engine.geom.Matrix, applyToThickness:Bool):nanofl.engine.strokes.LinearStroke;
	function toString():String;
}
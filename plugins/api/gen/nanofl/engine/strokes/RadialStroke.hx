package nanofl.engine.strokes;

extern class RadialStroke extends nanofl.engine.strokes.BaseStroke implements nanofl.engine.strokes.IStroke {
	function new(colors:Array<String>, ratios:Array<Float>, cx:Float, cy:Float, r:Float, fx:Float, fy:Float, ?thickness:Float, ?caps:String, ?joints:String, ?miterLimit:Float, ?ignoreScale:Bool):Void;
	var colors : Array<String>;
	var ratios : Array<Float>;
	var cx : Float;
	var cy : Float;
	var r : Float;
	var fx : Float;
	var fy : Float;
	function begin(g:nanofl.engine.ShapeRender):Void;
	override function clone():nanofl.engine.strokes.RadialStroke;
	override function equ(e:nanofl.engine.strokes.IStroke):Bool;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	function applyAlpha(alpha:Float):Void;
	override function getTransformed(m:nanofl.engine.geom.Matrix, applyToThickness:Bool):nanofl.engine.strokes.RadialStroke;
	function toString():String;
}
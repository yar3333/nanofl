package nanofl.engine.strokes;

extern class SolidStroke extends nanofl.engine.strokes.BaseStroke implements nanofl.engine.strokes.IStroke {
	function new(?color:String, ?thickness:Float, ?caps:String, ?joints:String, ?miterLimit:Float, ?ignoreScale:Bool):Void;
	var color : String;
	function begin(g:nanofl.engine.ShapeRender):Void;
	override function clone():nanofl.engine.strokes.SolidStroke;
	override function equ(e:nanofl.engine.strokes.IStroke):Bool;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	function applyAlpha(alpha:Float):Void;
	function toString():String;
}
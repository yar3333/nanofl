package nanofl.engine.strokes;

extern class SelectionStroke extends nanofl.engine.strokes.BaseStroke implements nanofl.engine.strokes.IStroke {
	function new(base:nanofl.engine.strokes.IStroke, scale:Float):Void;
	function begin(g:nanofl.engine.ShapeRender):Void;
	function swapInstance(oldNamePath:String, newNamePath:String):Void;
	function applyAlpha(alpha:Float):Void;
	function toString():String;
}
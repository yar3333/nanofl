package nanofl.ide.undo.states;

extern class ShapeState extends nanofl.ide.undo.states.ElementState {
	function new(edges:Array<nanofl.engine.geom.StrokeEdge>, polygons:Array<nanofl.engine.geom.Polygon>):Void;
	var edges(default, null) : Array<nanofl.engine.geom.StrokeEdge>;
	var polygons(default, null) : Array<nanofl.engine.geom.Polygon>;
	override function equ(_state:nanofl.ide.undo.states.ElementState):Bool;
	override function toString():String;
}
package nanofl.ide.undo.states;

extern class FigureState {
	function new(shapeStates:Array<nanofl.ide.undo.states.ShapeState>):Void;
	var shapeStates(default, null) : Array<nanofl.ide.undo.states.ShapeState>;
	function equ(state:nanofl.ide.undo.states.FigureState):Bool;
}
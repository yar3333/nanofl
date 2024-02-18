package nanofl.ide.undo.states;

import datatools.ArrayTools;

class FigureState
{
	public var shapeStates(default, null) : Array<ShapeState>;
	
	public function new(shapeStates:Array<ShapeState>)
	{
		this.shapeStates = shapeStates;
	}
	
	public function equ(state:FigureState) : Bool
	{
		return ArrayTools.equ(shapeStates, state.shapeStates);
	}
}
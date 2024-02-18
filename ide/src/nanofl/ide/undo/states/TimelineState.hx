package nanofl.ide.undo.states;

import nanofl.engine.movieclip.Layer;

class TimelineState
{
	public var layerStates(default, null) : Array<Layer>;
	
	public function new(layerStates:Array<Layer>)
	{
		this.layerStates = layerStates;
	}
}

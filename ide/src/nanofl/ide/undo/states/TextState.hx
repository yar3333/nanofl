package nanofl.ide.undo.states;

import nanofl.TextRun;
import nanofl.ide.undo.states.ElementState;
import datatools.ArrayTools;

class TextState extends ElementState
{
	public var width(default, null) : Float;
	public var height(default, null) : Float;
	public var selectable(default, null) : Bool;
	public var border(default, null) : Bool;
	public var textRuns(default, null) : Array<TextRun>;
	public var newTextFormat(default, null) : TextRun;
	
	public function new(width:Float, height:Float, selectable:Bool, border:Bool, textRuns:Array<TextRun>, newTextFormat:TextRun)
	{
		this.width = width;
		this.height = height;
		this.selectable = selectable;
		this.border = border;
		this.textRuns = textRuns;
		this.newTextFormat = newTextFormat;
	}
	
	override public function equ(_state:ElementState):Bool 
	{
		var state = cast(_state, TextState);
		return state.width == width
			&& state.height == height
			&& state.selectable == selectable
			&& state.border == border
			&& ArrayTools.equ(state.textRuns, textRuns)
			&& state.newTextFormat.equ(newTextFormat);
	}
}
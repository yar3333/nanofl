package nanofl.ide.undo.states;

import nanofl.engine.MeshParams;
import nanofl.engine.BlendModes;
import nanofl.engine.FilterDef;
import nanofl.engine.coloreffects.ColorEffect;
import datatools.ArrayTools;
import datatools.NullTools;
import nanofl.ide.undo.states.ElementState;

class InstanceState extends ElementState
{
	public var name(default, null) : String;
	public var colorEffect(default, null) : ColorEffect;
	public var filters(default, null) : Array<FilterDef>;
	public var blendMode(default, null) : BlendModes;
	public var meshParams(default, null) : MeshParams;
	
	public function new(name:String, colorEffect:ColorEffect, filters:Array<FilterDef>, blendMode:BlendModes, meshParams:MeshParams)
	{
		this.name = name;
		this.colorEffect = colorEffect;
		this.filters = filters;
		this.blendMode = blendMode;
		this.meshParams = meshParams;
	}
	
	override public function equ(_state:ElementState) : Bool
	{
		var state = cast(_state, InstanceState);
		return state.name == name
			&& NullTools.equ(state.colorEffect, colorEffect)
			&& ArrayTools.equ(state.filters, filters)
			&& state.blendMode == blendMode
			&& MeshParamsTools.equ(state.meshParams, meshParams)
	}
}
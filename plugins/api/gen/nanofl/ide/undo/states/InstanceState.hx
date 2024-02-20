package nanofl.ide.undo.states;

extern class InstanceState extends nanofl.ide.undo.states.ElementState {
	function new(name:String, colorEffect:nanofl.engine.coloreffects.ColorEffect, filters:Array<nanofl.engine.FilterDef>, blendMode:nanofl.engine.BlendModes, meshParams:nanofl.engine.MeshParams):Void;
	var name(default, null) : String;
	var colorEffect(default, null) : nanofl.engine.coloreffects.ColorEffect;
	var filters(default, null) : Array<nanofl.engine.FilterDef>;
	var blendMode(default, null) : nanofl.engine.BlendModes;
	var meshParams(default, null) : nanofl.engine.MeshParams;
	override function equ(_state:nanofl.ide.undo.states.ElementState):Bool;
}
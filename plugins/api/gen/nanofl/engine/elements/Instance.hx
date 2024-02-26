package nanofl.engine.elements;

extern class Instance extends nanofl.engine.elements.Element implements nanofl.engine.IPathElement {
	function new(namePath:String, ?name:String, ?colorEffect:nanofl.engine.coloreffects.ColorEffect, ?filters:Array<nanofl.engine.FilterDef>, ?blendMode:nanofl.engine.BlendModes, ?meshParams:nanofl.engine.MeshParams):Void;
	var namePath : String;
	var name : String;
	var colorEffect : nanofl.engine.coloreffects.ColorEffect;
	var filters : Array<nanofl.engine.FilterDef>;
	var blendMode : nanofl.engine.BlendModes;
	var meshParams : nanofl.engine.MeshParams;
	var symbol(get, never) : nanofl.engine.libraryitems.InstancableItem;
	@:noCompletion
	private function get_symbol():nanofl.engine.libraryitems.InstancableItem;
	override function saveProperties(out:htmlparser.XmlBuilder):Void;
	override function clone():nanofl.engine.elements.Instance;
	function isScene():Bool;
	override function getState():nanofl.ide.undo.states.ElementState;
	override function setState(state:nanofl.ide.undo.states.ElementState):Void;
	override function toString():String;
	var layers(get, never) : Array<nanofl.engine.movieclip.Layer>;
	@:noCompletion
	function get_layers():Array<nanofl.engine.movieclip.Layer>;
	override function createDisplayObject(frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	override function updateDisplayObject(dispObj:easeljs.display.DisplayObject, frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	function getNavigatorName():String;
	function getNavigatorIcon():String;
	function getChildren():Array<nanofl.engine.elements.Element>;
	function getTimeline():nanofl.engine.ITimeline;
	override function setLibrary(library:nanofl.engine.Library):Void;
	override function equ(element:nanofl.engine.elements.Element):Bool;
	function getFilters():Array<nanofl.engine.FilterDef>;
	function setFilters(filters:Array<nanofl.engine.FilterDef>):Void;
}
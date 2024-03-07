package nanofl.engine.elements;

extern class GroupElement extends nanofl.engine.elements.Element implements nanofl.engine.IElementsContainer implements nanofl.engine.IPathElement {
	function new(elements:Array<nanofl.engine.elements.Element>):Void;
	var elements(get, never) : Array<nanofl.engine.elements.Element>;
	private function get_elements():Array<nanofl.engine.elements.Element>;
	var name : String;
	var currentFrame(get, set) : Int;
	private function get_currentFrame():Int;
	private function set_currentFrame(v:Int):Int;
	var layers(get, never) : Array<nanofl.engine.movieclip.Layer>;
	@:noCompletion
	function get_layers():Array<nanofl.engine.movieclip.Layer>;
	function addElement(element:nanofl.engine.elements.Element, ?index:Int):Void;
	function removeElementAt(n:Int):Void;
	function removeElement(element:nanofl.engine.elements.Element):Void;
	override function clone():nanofl.engine.elements.GroupElement;
	override function setLibrary(library:nanofl.engine.Library):Void;
	function getChildren():Array<nanofl.engine.elements.Element>;
	override function createDisplayObject():easeljs.display.Container;
	function getMaskFilter(layer:nanofl.engine.movieclip.Layer, frameIndex:Int):easeljs.display.Container;
	function isScene():Bool;
	function getNavigatorName():String;
	function getNavigatorIcon():String;
	function getTimeline():nanofl.engine.ITimeline;
	override function transform(m:nanofl.engine.geom.Matrix, ?applyToStrokeAndFill:Bool):Void;
	override function getUsedSymbolNamePaths():Array<String>;
	override function equ(element:nanofl.engine.elements.Element):Bool;
}
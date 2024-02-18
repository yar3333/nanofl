package nanofl.engine.elements;

extern class TextElement extends nanofl.engine.elements.Element {
	function new(name:String, width:Float, height:Float, selectable:Bool, border:Bool, textRuns:Array<nanofl.TextRun>, ?newTextFormat:nanofl.TextRun):Void;
	var name : String;
	var width : Float;
	var height : Float;
	var selectable : Bool;
	var border : Bool;
	var textRuns : Array<nanofl.TextRun>;
	var newTextFormat : nanofl.TextRun;
	function getText():String;
	override function createDisplayObject(frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):nanofl.TextField;
	override function updateDisplayObject(dispObj:easeljs.display.DisplayObject, frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):nanofl.TextField;
	function getMinSize(dispObj:easeljs.display.DisplayObject):{ var height : Float; var width : Float; };
	override function getState():nanofl.ide.undo.states.ElementState;
	override function setState(_state:nanofl.ide.undo.states.ElementState):Void;
	override function equ(element:nanofl.engine.elements.Element):Bool;
	override function clone():nanofl.engine.elements.TextElement;
	function breakApart():Array<nanofl.engine.elements.TextElement>;
	override function fixErrors():Bool;
}
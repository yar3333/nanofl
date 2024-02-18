package nanofl.engine.elements;

extern class SpriteFrameElement extends nanofl.engine.elements.Element {
	function new(sprite:nanofl.engine.libraryitems.SpriteItem, index:Int):Void;
	override function saveProperties(out:htmlparser.XmlBuilder):Void;
	override function savePropertiesJson(obj:Dynamic):Void;
	override function clone():nanofl.engine.elements.SpriteFrameElement;
	override function getState():nanofl.ide.undo.states.ElementState;
	override function setState(state:nanofl.ide.undo.states.ElementState):Void;
	override function createDisplayObject(frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	override function updateDisplayObject(dispObj:easeljs.display.DisplayObject, frameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	override function equ(element:nanofl.engine.elements.Element):Bool;
	override function toString():String;
}
package nanofl.engine.libraryitems;

extern class InstancableItem extends nanofl.engine.libraryitems.LibraryItem {
	var linkedClass : String;
	function newInstance():nanofl.engine.elements.Instance;
	function getDisplayObjectClassName():String;
	function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):Void;
	function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function loadPropertiesJson(obj:Dynamic):Void;
}
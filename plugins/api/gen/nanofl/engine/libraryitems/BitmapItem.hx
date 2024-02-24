package nanofl.engine.libraryitems;

extern class BitmapItem extends nanofl.engine.libraryitems.InstancableItem implements nanofl.engine.ITextureItem {
	function new(namePath:String, ext:String):Void;
	var ext : String;
	var textureAtlas : String;
	var image(default, null) : js.html.ImageElement;
	override function clone():nanofl.engine.libraryitems.BitmapItem;
	override function getIcon():String;
	function getUrl():String;
	override function preload():js.lib.Promise<{ }>;
	override function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	override function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):Void;
	override function getDisplayObjectClassName():String;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	override function loadPropertiesJson(obj:Dynamic):Void;
	override function toString():String;
}
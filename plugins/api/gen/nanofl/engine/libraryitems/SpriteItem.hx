package nanofl.engine.libraryitems;

extern class SpriteItem extends nanofl.engine.libraryitems.InstancableItem implements nanofl.engine.ITextureItem implements nanofl.engine.ILayersContainer {
	function new(namePath:String, frames:Array<nanofl.engine.SpriteItemFrame>):Void;
	var layers(get, never) : datatools.ArrayRO<nanofl.engine.movieclip.Layer>;
	@:noCompletion
	function get_layers():datatools.ArrayRO<nanofl.engine.movieclip.Layer>;
	var likeButton : Bool;
	var autoPlay : Bool;
	var loop : Bool;
	var textureAtlas : String;
	var spriteSheet(default, null) : easeljs.display.SpriteSheet;
	override function clone():nanofl.engine.libraryitems.SpriteItem;
	override function getIcon():String;
	override function preload():js.lib.Promise<{ }>;
	override function createDisplayObject(initFrameIndex:Int, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):easeljs.display.DisplayObject;
	override function updateDisplayObject(dispObj:easeljs.display.DisplayObject, childFrameIndexes:Array<{ public var frameIndex(default, default) : Int; public var element(default, default) : nanofl.engine.IPathElement; }>):Void;
	override function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	override function getDisplayObjectClassName():String;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function loadPropertiesJson(obj:Dynamic):Void;
	override function toString():String;
}
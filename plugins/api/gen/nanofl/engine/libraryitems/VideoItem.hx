package nanofl.engine.libraryitems;

extern class VideoItem extends nanofl.engine.libraryitems.InstancableItem {
	function new(namePath:String, ext:String):Void;
	var ext : String;
	var autoPlay : Bool;
	var loop : Bool;
	var width(default, null) : Int;
	var height(default, null) : Int;
	var duration(default, null) : Float;
	var poster(default, null) : js.html.CanvasElement;
	override function clone():nanofl.engine.libraryitems.VideoItem;
	override function getIcon():String;
	override function preload():js.lib.Promise<{ }>;
	override function createDisplayObject():easeljs.display.DisplayObject;
	override function getDisplayObjectClassName():String;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	override function loadPropertiesJson(obj:Dynamic):Void;
	override function toString():String;
}
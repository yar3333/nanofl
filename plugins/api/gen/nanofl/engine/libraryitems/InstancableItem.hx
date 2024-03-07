package nanofl.engine.libraryitems;

extern class InstancableItem extends nanofl.engine.libraryitems.LibraryItem {
	var linkedClass : String;
	function newInstance():nanofl.engine.elements.Instance;
	function getDisplayObjectClassName():String;
	function createDisplayObject():easeljs.display.DisplayObject;
	function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function loadPropertiesJson(obj:Dynamic):Void;
}
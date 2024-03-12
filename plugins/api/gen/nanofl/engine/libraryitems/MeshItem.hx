package nanofl.engine.libraryitems;

extern class MeshItem extends nanofl.engine.libraryitems.InstancableItem implements nanofl.engine.libraryitems.ISpritableItem implements nanofl.engine.ITextureItem {
	function new(namePath:String):Void;
	var textureAtlas : String;
	var renderAreaSize : Int;
	var loadLights : Bool;
	var scene(default, null) : js.three.scenes.Scene;
	var boundingRadius : Float;
	var renderer(get, never) : js.three.renderers.Renderer;
	var spriteSheet(get, never) : easeljs.display.SpriteSheet;
	override function clone():nanofl.engine.libraryitems.MeshItem;
	override function getIcon():String;
	override function preload():js.lib.Promise<{ }>;
	override function createDisplayObject(params:Dynamic):easeljs.display.DisplayObject;
	private function get_spriteSheet():easeljs.display.SpriteSheet;
	private function get_renderer():js.three.renderers.Renderer;
	override function getDisplayObjectClassName():String;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	override function loadPropertiesJson(obj:Dynamic):Void;
	override function toString():String;
	static var DEFAULT_RENDER_AREA_SIZE(default, never) : Int;
}
package nanofl.engine.libraryitems;

extern class MovieClipItem extends nanofl.engine.libraryitems.InstancableItem implements nanofl.engine.libraryitems.IPlayableItem implements nanofl.engine.libraryitems.ISpritableItem implements nanofl.engine.ITextureItem {
	function new(namePath:String):Void;
	var layers(get, never) : Array<nanofl.engine.movieclip.Layer>;
	private function get_layers():Array<nanofl.engine.movieclip.Layer>;
	var autoPlay : Bool;
	var loop : Bool;
	var likeButton : Bool;
	var textureAtlas : String;
	var relatedSound : String;
	/**
		
		        Build `SpriteSheet` on-the-fly (every frame of movie clip become bitmap in SpriteSheet) on first DisplayObject creating.
		        Fields `exportAsSprite` and `spriteSheet` are ignored if this movie clip included in texture atlas.
		    
	**/
	var exportAsSprite : Bool;
	var spriteSheet(get, never) : easeljs.display.SpriteSheet;
	function addLayer(layer:nanofl.engine.movieclip.Layer):Void;
	/**
		
			 * Add block of layers into timeline.
			 * Assume that layers' parentIndex referenced inside block.
			 
	**/
	function addLayersBlock(layersToAdd:Array<nanofl.engine.movieclip.Layer>, ?index:Int):Void;
	function getTotalFrames():Int;
	override function clone():nanofl.engine.libraryitems.MovieClipItem;
	override function getIcon():String;
	override function createDisplayObject(params:Dynamic):easeljs.display.DisplayObject;
	private function get_spriteSheet():easeljs.display.SpriteSheet;
	override function getDisplayObjectClassName():String;
	override function preload():js.lib.Promise<{ }>;
	override function equ(item:nanofl.engine.ILibraryItem):Bool;
	override function getNearestPoint(pos:nanofl.engine.geom.Point):nanofl.engine.geom.Point;
	override function setLibrary(library:nanofl.engine.Library):Void;
	function transform(m:nanofl.engine.geom.Matrix):Void;
	override function loadPropertiesJson(obj:Dynamic):Void;
	function isGroup():Bool;
	override function toString():String;
	static function createWithFrame(namePath:String, ?elements:Array<nanofl.engine.elements.Element>, ?layerName:String):nanofl.engine.libraryitems.MovieClipItem;
	static function loadFromJson(namePath:String, baseLibraryUrl:String):js.lib.Promise<nanofl.engine.libraryitems.MovieClipItem>;
}
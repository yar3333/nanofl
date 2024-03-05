package nanofl.engine;

extern class MaskTools {
	static function createMaskFromMovieClipLayer(mc:nanofl.MovieClip, layerIndex:Int):easeljs.display.Container;
	static function applyMaskToDisplayObject(mask:easeljs.display.DisplayObject, obj:easeljs.display.DisplayObject):Void;
}
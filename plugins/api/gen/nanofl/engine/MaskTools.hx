package nanofl.engine;

extern class MaskTools {
	static function processMovieClip(mc:nanofl.MovieClip):Void;
	static function applyMaskToDisplayObject(maskBitmapCache:easeljs.filters.BitmapCache, maskCacheCanvas:js.html.CanvasElement, obj:easeljs.display.DisplayObject):Void;
}
package nanofl.ide.displayobjects;

extern class VideoCache {
	static function getImageAsync(videoSrc:String, position:Float):js.lib.Promise<js.html.CanvasElement>;
}
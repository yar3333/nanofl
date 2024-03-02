package nanofl.engine;

extern class Loader {
	static function image(url:String):js.lib.Promise<js.html.ImageElement>;
	static function file(url:String):js.lib.Promise<String>;
	static function javaScript(url:String):js.lib.Promise<{ }>;
	static function video(url:String):js.lib.Promise<js.html.VideoElement>;
	static function queued<T>(urls:Array<String>, load:String -> js.lib.Promise<T>):js.lib.Promise<Array<T>>;
}
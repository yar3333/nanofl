package nanofl.engine;

extern class Loader {
	static function image(url:String):js.lib.Promise<js.html.Image>;
	static function file(url:String):js.lib.Promise<String>;
	static function queued<T>(urls:Array<String>, load:String -> js.lib.Promise<T>):js.lib.Promise<Array<T>>;
	static function loadJsScript(url:String):js.lib.Promise<{ }>;
}
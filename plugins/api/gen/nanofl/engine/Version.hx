package nanofl.engine;

extern class Version {
	static var ide(default, null) : String;
	static var player(default, null) : String;
	static var document(default, null) : String;
	static function compare(v1:String, v2:String):Int;
	static function handle<T>(version:String, handlers:Map<String, () -> T>):T;
}
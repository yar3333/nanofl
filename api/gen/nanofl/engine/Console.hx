package nanofl.engine;

extern class Console {
	function new():Void;
	function log(v:Dynamic):Void;
	function info(v:Dynamic):Void;
	function warn(v:Dynamic):Void;
	function error(v:Dynamic):Void;
	static function filter(method:String, filter:Array<Dynamic> -> Bool):Dynamic -> Void;
}
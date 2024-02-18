package nanofl.ide;

extern class Log {
	static var fileSystem : nanofl.ide.sys.FileSystem;
	static var onMessage : stdlib.Event<{ public var type(default, default) : String; public var message(default, default) : String; }>;
	static var logFile : String;
	static function init(fileSystem:nanofl.ide.sys.FileSystem, alerter:components.nanofl.others.alerter.Code):Void;
	static function sendBugReport(err:Dynamic, ?data:String):Void;
	static function toError(v:Dynamic):js.lib.Error;
}
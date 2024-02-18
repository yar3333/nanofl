package nanofl.ide;

extern class ExternalScriptLoader {
	static function loadAndExecute(jsFilePath:String):js.lib.Promise<{ }>;
}
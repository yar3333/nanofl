package nanofl.ide.filesystem;

extern class ExternalChangesDetector extends nanofl.ide.InjectContainer {
	function start():Void;
	function runPreventingAutoReloadAsync<T>(f:() -> js.lib.Promise<T>):js.lib.Promise<T>;
	function runPreventingAutoReloadSync(f:() -> Void):js.lib.Promise<{ }>;
}
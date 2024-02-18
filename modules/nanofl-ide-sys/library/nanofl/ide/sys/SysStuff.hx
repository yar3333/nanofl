package nanofl.ide.sys;

@:jsRequire("@nanofl/ide-sys", "SysStuff") extern class SysStuff {
	static function registerInInjector(injector:js.injecting.Injector):Void;
}
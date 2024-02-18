package nanofl.ide;

@:jsRequire("@nanofl/ide-globals", "Globals") extern class Globals {
	static var injector(default, null) : js.injecting.InjectorRO;
	@:allow(Main)
	private static function setInjector(_injector:js.injecting.Injector):Void;
}
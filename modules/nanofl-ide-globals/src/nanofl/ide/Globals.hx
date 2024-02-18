package nanofl.ide;

class Globals
{
	public static var injector(default, null) : js.injecting.InjectorRO;

	@:allow(Main)
	static function setInjector(_injector:js.injecting.Injector) : Void
	{
		injector = _injector;
	}
}

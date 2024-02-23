package nanofl.engine;

class Console
{
	public function new() {}
	
	public function log(v:Dynamic) js.Browser.console.log(v);
	public function info(v:Dynamic) js.Browser.console.info(v);
	public function warn(v:Dynamic) js.Browser.console.warn(v);
	public function error(v:Dynamic) js.Browser.console.error(v);
	
	public static function filter(method:String, filter:Array<Dynamic>->Bool) : Dynamic->Void
	{
		if (js.Browser.console == null) return null;
		
		var r = Reflect.field(js.Browser.console, method);
		Reflect.setField(js.Browser.console, method, getFilterFunction(r, filter));
		return r;
		
	}
	
	static function getFilterFunction(oldConsoleMethod:Dynamic->Void, filter:Array<Dynamic>->Bool) : Dynamic->Void
	{
		return Reflect.makeVarArgs(args ->
		{
			if (filter(args))
			{
				Reflect.callMethod(js.Browser.console, oldConsoleMethod, args);
			}
		});
	}
}

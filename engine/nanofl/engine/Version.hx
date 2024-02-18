package nanofl.engine;

using stdlib.Lambda;

class Version
{
	public static var ide(default, null) = "5.0.0";
	public static var player(default, null) = "5.0.0";
	public static var document(default, null) = "2.3.0";
	
	public static function compare(v1:String, v2:String) : Int
	{
		var n1 = v1.split(".").map(Std.parseInt);
		var n2 = v2.split(".").map(Std.parseInt);
		for (i in 0...3)
		{
			var r = Reflect.compare(n1[i], n2[i]);
			if (r != 0) return r;
		}
		return 0;
	}
	
	public static function handle<T>(version:String, handlers:Map<String, Void->T>) : T
	{
		var versions = handlers.keys().filter(x -> compare(x, version) <= 0).sorted(compare);
		if (versions.length == 0) versions = handlers.keys().sorted(compare);
		return (handlers.get(versions[versions.length - 1]))();
	}
}
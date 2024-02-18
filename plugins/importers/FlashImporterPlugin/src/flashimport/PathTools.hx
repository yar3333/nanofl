package flashimport;

class PathTools
{
	public static function unescape(s:String) : String
	{
		return ~/&#(\d\d\d)/g.map(s, function(re)
		{
			var code = Std.parseInt(re.matched(1));
			return String.fromCharCode(code);
		});
	}
}
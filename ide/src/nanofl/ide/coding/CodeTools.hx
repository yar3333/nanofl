package nanofl.ide.coding;

using stdlib.StringTools;

class CodeTools
{
	public static function namePathToClassName(namePath:String) : String
	{
		var parts = namePath.split("/").map(toIdentifier);
		return (parts.length > 1 ? parts.slice(0, parts.length - 1).map(decapitalize).join(".") + "." : "")
			   + parts[parts.length - 1].capitalize();
	}
	
	static function toIdentifier(s:String) : String
	{
		var r = "";
		var isPrevBad = false;
		var i = 0; while (i < s.length)
		{
			if (~/[a-zA-Z0-9]/.match(s.charAt(i)))
			{
				r += s.charAt(i);
				isPrevBad = false;
			}
			else
			{
				if (!isPrevBad)
				{
					r += "_";
					isPrevBad = true;
				}
			}
			i++;
		}
		
		if (r.charAt(0) == "_") r = "a" + r;
		
		return r;
	}
	
	static function decapitalize(s:String) : String
	{
		if (s == null || s == "") return s;
		return s.charAt(0).toLowerCase() + s.substring(1);
	}
}